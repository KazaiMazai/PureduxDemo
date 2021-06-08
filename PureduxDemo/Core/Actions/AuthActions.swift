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
    enum ValidateToken {}
}

// MARK: - Actions.Auth.Login

extension Actions.Auth.Login {
    struct Flow: Action {
        let isActive: Bool
    }

    struct UpdateUsername: Action {
        let value: String
    }

    struct UpdatePassword: SecuredLogAction {
        let value: String
    }

    struct Perform: Action {

    }
}

// MARK: - Actions.Auth.Login.Result

extension Actions.Auth.Login {
    enum Result {}
}

extension Actions.Auth.Login.Result {
    struct Failed: ErrorAction {
        let error: SomeError

        init(error: Error) {
            self.error = SomeError(error: error)
        }
    }

    struct Success: Action {
        let session: Session
    }

    struct Cancelled: Action {

    }
}

// MARK: - Actions.Auth.ObtainToken.Result

extension Actions.Auth.ObtainToken {
    enum Result {}
}

extension Actions.Auth.ObtainToken.Result {
    struct Success: Action {
        let token: TemporaryRequestToken
    }

    struct Cancelled: Action {

    }

    struct Failed: ErrorAction {
        init(error: Error) {
            self.error = SomeError(error: error)
        }

        let error: SomeError

    }
}

// MARK: - Actions.Auth.ObtainToken

extension Actions.Auth.ValidateToken {
    enum Result {}
}

extension Actions.Auth.ValidateToken.Result {
    struct Success: Action {
        let token: SessionRequestToken
    }

    struct Cancelled: Action {

    }

    struct Failed: ErrorAction {
        let error: SomeError

        init(error: Error) {
            self.error = SomeError(error: error)
        }
    }
}

// MARK: - Actions.Auth.Logout

extension Actions.Auth.Logout {
    struct PerformLogout: Action {
        let forced: Bool
    }
}

// MARK: - Actions.Auth.Logout.Result

extension Actions.Auth.Logout {
    enum Result {}
}

extension Actions.Auth.Logout.Result {
    struct Success: Action {

    }

    struct Cancelled: Action {

    }

    struct Failed: ErrorAction {
        let error: SomeError

        init(error: Error) {
            self.error = SomeError(error: error)
        }
    }
}
