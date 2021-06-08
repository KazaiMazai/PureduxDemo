//
//  NetworkSideEffects.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxStore
import PureduxNetworkOperator
import PureduxSideEffects
import PureduxCommonCore

protocol NetworkSideEffects {
    var effects: SideEffects<AppState, Action, [NetworkOperator.Request]> { get }
}

extension NetworkSideEffects {
    func prepareRequest<Data: Decodable>(
        _ id: RequestID,
        request: Client.Request<Data>,
        store: Store<AppState, Action>,
        onComplete: @escaping (Client.Response<Data>) -> Action) -> NetworkOperator.Request {

        NetworkOperator.Request(
            id: id.rawValue,
            request: request.urlRequest,
            taskType: request.type.taskType,
            handler: { data, response, error in
                let result = request.handler(data, response, error)

                let action = onComplete(result)
                store.dispatch(action)

                if case .unauthorized = result {
                    store.dispatch(Actions.Auth.Logout.PerformLogout(forced: true))
                }
        })
    }
}

extension Client.RequestType {
    var taskType: NetworkOperator.TaskType {
        switch self {
        case .data:
            return .dataTask
        }
    }
}
