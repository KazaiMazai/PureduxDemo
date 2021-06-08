//
//  AuthState.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

struct AuthState: Codable {
    private(set) var session: Session?

    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case let action as Actions.Auth.Login.Result.Success:
            session = action.session
        case is Actions.Auth.Logout.LogoutResult:
            session = nil
        default:
            break
        }
    }
}

extension AuthState {
    var isAuthenticated: Bool {
        session != nil
    }
}
