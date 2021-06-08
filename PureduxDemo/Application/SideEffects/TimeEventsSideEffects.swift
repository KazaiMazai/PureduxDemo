//
//  TimeEventEmitter.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import Foundation
import PureduxSideEffects
import PureduxCommonOperators
import PureduxStore

struct TimeEventsSideEffects {
    var effects: SideEffects<AppState, Action, [TimeEventsOperator.Request]> {
        SideEffects(props: timeEventsRequests)
    }
}

extension TimeEventsSideEffects {
    private func timeEventsRequests(
        state: AppState,
        on store: Store<AppState, Action>) -> [TimeEventsOperator.Request] {
        
        guard case let .inProgress(requestState) = state.currentTime.request else {
            return []
        }

        let request = TimeEventsOperator.Request(id: requestState.id.rawValue,
                                                 delay: state.currentTime.delayInterval) {
            switch $0 {
            case .success:
                store.dispatch(Actions.Time.TimeChanged())
            case .cancelled:
                break
            case .failure:
                break
            case .statusChanged:
                break
            }
        }

        return [request]
    }
}
