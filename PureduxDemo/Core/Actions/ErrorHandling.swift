//
//  ErrorHandling.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

protocol ErrorAction: Action {
    var error: SomeError { get }

    init(error: SomeError)
}

extension ErrorAction {
    init(error: Error) {
        self.init(error: SomeError(error: error))
    }
}

extension Actions {
    enum ErrorHandling { }
}

extension Actions.ErrorHandling {
    struct DequeueError: Action {

    }
}
