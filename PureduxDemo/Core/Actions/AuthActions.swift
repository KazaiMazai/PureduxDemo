//
//  AuthActions.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

extension Actions {
    enum Auth { }
}

extension Actions.Auth {
    enum Login {}
    enum Logout {}
    enum ObtainToken {}
}

extension Actions.Auth.Login {
    enum Result {}
}

// MARK: - Actions.Auth.Login

extension Actions.Auth.Login {
    struct Flow: Action {
        let isActive: Bool
    }

    struct UpdateUsername: Action {
        let value: String
    }

    struct UpdatePassword: Action {
        let value: String
    }

    struct Perform: Action {

    }
}

// MARK: - Actions.Auth.Login.Result

extension Actions.Auth.Login.Result {
    struct Failed: ErrorAction {
        let error: SomeError
    }

    struct Success: Action {
        let session: Session
    }

    struct Cancelled: Action {

    }
}

// MARK: - Actions.Auth.ObtainToken

extension Actions.Auth.ObtainToken {
    enum Result {}
}

// MARK: - Actions.Auth.ObtainToken.Result

extension Actions.Auth.ObtainToken.Result {
    struct Success: Action {
        let token: SessionRequestToken
    }

    struct Cancelled: Action {

    }

    struct Failed: ErrorAction {
        let error: SomeError
    }
}

// MARK: - Actions.Auth.Logout

extension Actions.Auth.Logout {
    struct PerformLogout: Action {
        let forced: Bool
    }

    struct LogoutResult: Action {
        let forced: Bool
    }
}