//
//  LoginState.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

struct LoginState {
    private(set) var pickCredentials: PickCredentials = PickCredentials()

    mutating func reduce(_ action: Action, env: AppEnvironment) {
        pickCredentials.reduce(action, env: env)
    }

}
