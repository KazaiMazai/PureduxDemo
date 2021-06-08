//
//  LoginForm.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

extension LoginState {
    struct PickCredentials: Codable {

        private(set) var username: String = ""
        private(set) var password: String = ""

        private(set) var requesToken: RequestState<SingleRequest> = .none
        private(set) var createSession: RequestState<SessionRequest> = .none
    }
}

extension LoginState.PickCredentials {
    typealias SessionRequest = RequestWithPayload<SingleRequest, SessionRequestToken>
}

extension LoginState.PickCredentials {
    var canPerformLogin: Bool {
        !username.isEmpty && !password.isEmpty
    }

    var isInProgress: Bool {
        requesToken.isInProgress || createSession.isInProgress
    }
}

// MARK: - Reducer

extension LoginState.PickCredentials {
    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case is Actions.Auth.Login.Flow:
            self = .init()

        case let action as Actions.Auth.Login.UpdateUsername:
            updateUsername(value: action.value)

        case let action as Actions.Auth.Login.UpdatePassword:
            updatePassword(value: action.value)

        case is Actions.Auth.Login.Perform:
            performLoginIfPossible(with: env.makeUUID())

        case let action as Actions.Auth.ObtainToken.Result.Success:
            setRequesTokenSuccess()
            createSessionWith(token: action.token, requestId: env.makeUUID())

        case is Actions.Auth.ObtainToken.Result.Failed:
            setRequesTokenFailed()

        case is Actions.Auth.Login.Result.Success:
            setCreateSessionSuccess()

        case is Actions.Auth.Login.Result.Failed:
            setCreateSessionFailed()
        default:
            break
        }
    }
}

// MARK: - Mutations

private extension LoginState.PickCredentials {
    mutating func updateUsername(value: String) {
        if isInProgress {
            return
        }

        username = value
    }

    mutating func updatePassword(value: String) {
        if isInProgress {
            return
        }

        password = value
    }

    mutating func performLoginIfPossible(with requestId: UUID) {
        guard canPerformLogin else {
            return
        }

        if isInProgress {
            return
        }

        requesToken = .inProgress(SingleRequest(id: RequestID(rawValue: requestId)))
    }

    mutating func setRequesTokenFailed() {
        requesToken = .failed
    }

    mutating func setRequesTokenSuccess() {
        requesToken = .success
    }

    mutating func createSessionWith(token: SessionRequestToken, requestId: UUID) {
        createSession = .inProgress(SessionRequest(
            payload: token,
            state: SingleRequest(id: RequestID(rawValue: requestId))))
    }

    mutating func setCreateSessionFailed() {
        createSession = .failed
    }

    mutating func setCreateSessionSuccess() {
        createSession = .success
    }
}
