//
//  Action.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import Foundation
import PureduxCommonCore

protocol Action { }

enum Actions { }

protocol ErrorAction: Action {
    var error: SomeError { get }

    init(error: SomeError)
}

extension ErrorAction {
    init(error: Error) {
        self.init(error: SomeError(error: error))
    }
}
