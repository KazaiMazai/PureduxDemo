//
//  StatePersistanc.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonOperators
import PureduxStore
import PureduxSideEffects

struct StatePersistenceSideEffect<Storage>
    where
    Storage: StateStorageProtocol,
    Storage.State == AppState,
    Storage.MetaData == StateSize {

    typealias Request = StatePersistanceOperator<Storage, AppState, Storage.MetaData>
        .Request<AppState, Storage.MetaData>

    var effects: SideEffects<AppState, Action, [Request]> {
        [
            SideEffects(props: saveState)
        ]
        .compactMap { $0 }
    }
}

extension StatePersistenceSideEffect {
    private func saveState(state: AppState, on store: Store<AppState, Action>) -> Request? {
        guard case let .inProgress(requestState) = state.persistance.delayedSaveRequest,
              requestState.canPerform(state.currentTime.now)
        else {
            return nil
        }

        return Request(
            id: requestState.id.rawValue,
            state: state,
            handler: { result in

                switch result {
                case .success:
                    store.dispatch(Actions.Persistance.SaveState.Success())
                case .cancelled:
                    store.dispatch(Actions.Persistance.SaveState.Cancel())
                case .statusChanged:
                    break
                case .failure(let error):
                    store.dispatch(Actions.Persistance.SaveState.Failure(error: error))
                }
            })
    }
}
