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
}

extension ErrorAction {
    
}

extension Actions {
    enum ErrorHandling { }
}

extension Actions.ErrorHandling {
    struct DequeueError: Action {

    }
}
