//
//  Requests.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation

extension Client {
    enum RequestType {
        case data
    }

    struct Request<Result: Decodable> {
        init(urlRequest: URLRequest,
             type: RequestType,
             handler: @escaping (Data?, URLResponse?, Error?) -> Client.Response<Result>) {
            self.urlRequest = urlRequest
            self.type = type
            self.handler = handler
        }

        let type: RequestType
        let urlRequest: URLRequest
        let handler: (Data?, URLResponse?, Error?) -> Response<Result>
    }
}

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return jsonObject.flatMap { $0 as? [String: Any] }
    }
}
