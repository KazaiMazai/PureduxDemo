//
//  LoginSideEffects.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxStore
import PureduxNetworkOperator
import PureduxSideEffects
import PureduxCommonCore

struct AuthSideEffects: NetworkSideEffects {
    let client: MoviesDBAuth

    var effects: SideEffects<AppState, Action, [NetworkOperator.Request]> {
        [
            SideEffects(props: createRequestToken),
            SideEffects(props: validateRequestToken),
            SideEffects(props: createSession)
        ]
        .compactMap { $0 }
    }
}

private extension AuthSideEffects {
    func createRequestToken(state: AppState, on store: Store<AppState, Action>) -> NetworkOperator.Request? {
        guard case let .inProgress(requestState) = state.login.pickCredentials.requesToken,
              requestState.canPerform(state.currentTime.now)
        else {
            return nil
        }

        do {

            let req = try client.createRequestToken()
            return prepareRequest(
                requestState.id,
                request: req,
                store: store) {

                switch $0 {
                case .success(let result):
                    return Actions.Auth.ObtainToken.Result.Success(
                        token: TemporaryRequestToken(token: result.requestToken))
                case .cancelled:
                    return Actions.Auth.ObtainToken.Result.Cancelled()
                case let .unauthorized(error), let .failed(error):
                    return Actions.Auth.ObtainToken.Result.Failed(error: error)
                }
            }

        } catch {
            store.dispatch(Actions.Auth.ObtainToken.Result.Failed(error: error))
            return nil
        }
    }

    func validateRequestToken(
        state: AppState,
        on store: Store<AppState, Action>) -> NetworkOperator.Request? {

        guard case let .inProgress(requestState) = state.login.pickCredentials.validateToken,
              requestState.canPerform(state.currentTime.now)
        else {
            return nil
        }

        do {

            let req = try client.validateRequestToken(
                username: state.login.pickCredentials.username,
                password: state.login.pickCredentials.password,
                requestToken: requestState.payload.token)

            return prepareRequest(
                requestState.id,
                request: req,
                store: store) {

                switch $0 {
                case .success(let result):
                    return Actions.Auth.ValidateToken.Result.Success(
                        token: SessionRequestToken(token: result.requestToken))
                case .cancelled:
                    return Actions.Auth.ValidateToken.Result
                        .Cancelled()
                case let .unauthorized(error), let .failed(error):
                    return Actions.Auth.ValidateToken.Result.Failed(error: error)
                }
            }

        } catch {
            store.dispatch(Actions.Auth.ValidateToken.Result.Failed(error: error))
            return nil
        }
    }

    func createSession(
        state: AppState,
        on store: Store<AppState, Action>) -> NetworkOperator.Request? {

        guard case let .inProgress(requestState) = state.login.pickCredentials.createSession,
              requestState.canPerform(state.currentTime.now)
        else {
            return nil
        }

        do {

            let req = try client.createSession(
                requestToken: requestState.payload.token)

            return prepareRequest(
                requestState.id,
                request: req,
                store: store) {

                switch $0 {
                case .success(let result):
                    return Actions.Auth.Login.Result.Success(
                        session: Session(id: Session.ID(rawValue: result.sessionId)))
                case .cancelled:
                    return Actions.Auth.Login.Result
                        .Cancelled()
                case let .unauthorized(error), let .failed(error):
                    return Actions.Auth.Login.Result.Failed(error: error)
                }
            }

        } catch {
            store.dispatch(Actions.Auth.ValidateToken.Result.Failed(error: error))
            return nil
        }
    }
}
