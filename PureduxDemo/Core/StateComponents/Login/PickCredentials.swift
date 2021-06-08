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
        private(set) var createSession: RequestState<SingleRequest> = .none
    }
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

    }
}
