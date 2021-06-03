//
//  AppState.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import Foundation

struct AppState {
    private(set) var currentTime: AppTime
    private(set) var storage: Storage

    init(currentTime: AppTime, storage: Storage) {
        self.currentTime = currentTime
        self.storage = storage
    }
}

extension AppState {
    static func createStateWith(config: AppStateConfig, env: AppEnvironment) -> AppState {
        AppState(
            currentTime: AppTime(
                time: env.now(),
                interval: config.timeEventsInterval,
                initialRequest: env.makeUUID()),

            storage: Storage())
    }
}

extension AppState {
    mutating func reduce(_ action: Action, env: AppEnvironment) {

        currentTime.reduce(action, env: env)
        storage.reduce(action, env: env)
    }
}
