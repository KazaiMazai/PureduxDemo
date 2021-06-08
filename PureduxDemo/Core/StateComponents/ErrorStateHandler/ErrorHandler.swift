//
//  ErrorHandler.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

public struct ErrorHandler: Codable {
    private var currentError: SomeError?

    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case let action as ErrorAction:
            currentError = action.error

        case is Actions.ErrorHandling.DequeueError:
            currentError = nil
        default:
            break
        }
    }
}

extension ErrorHandler {
    var lastError: Error? {
        return currentError?.error
    }

    var hasError: Bool {
        return currentError?.error != nil
    }
}
