//
//  StoreLogger.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxSideEffects

struct ActionsLogger {
    let logger: Logger

    func log(action: Action) {
        if action is ErrorAction {
            logAction(LogLevel.error, action: action)
            return
        }

        if action is Actions.Time.TimeChanged {
            logAction(.trace, action: action)
            return
        }

        logAction(.debug, action: action)
    }

    private func logAction(_ level: LogLevel, action: Action) {
        logger.log(level, "\(String(reflecting: action))")
    }
}
