//
//  AppState.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import Foundation

struct AppState: Codable {
    private(set) var login: LoginState = LoginState()
    private(set) var moviesFeed: MoviesFeed = MoviesFeed()

    private(set) var authentication: AuthState = AuthState()

    private(set) var currentTime: AppTime
    private(set) var storage: Storage
    private(set) var persistance: StatePersistance

    private(set) var errorHandler: ErrorHandler = ErrorHandler()
}

// MARK: - Reducer

extension AppState {
    mutating func reduce(_ action: Action, env: AppEnvironment) {
        login.reduce(action, env: env)
        moviesFeed.reduce(action, env: env)

        authentication.reduce(action, env: env)

        currentTime.reduce(action, env: env)
        storage.reduce(action, env: env)
        persistance.reduce(action, env: env)

        errorHandler.reduce(action, env: env)
    }
}

// MARK: - CodingKeys

/**
 AppState's CodingKeys allow to specify which part of the state
 we will encode/decode and, eventually, persist.
*/

extension AppState {
    private enum CodingKeys: String, CodingKey {
        case currentTime
        case storage
        case authentication
        case persistance
    }
}

extension AppState {
    static func createStateWith(config: AppStateConfig, env: AppEnvironment) -> AppState {
        AppState(
            currentTime: AppTime(
                time: env.now(),
                interval: config.timeEventsInterval,
                initialRequest: env.makeUUID()),

            storage: Storage(),
            persistance: StatePersistance(
                delayInterval: config.persistStateDelayTimeInterval))
    }
}
