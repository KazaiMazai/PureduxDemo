//
//  AppStateConfig.swift
//  BETest
//
//  Created by Sergey Kazakov on 21.05.2021.
//

import Foundation

struct AppStateConfig {
    let timeEventsInterval: TimeInterval

    static func defaultConfig() -> AppStateConfig {
        AppStateConfig(
            timeEventsInterval: 0.3)
    }
}
