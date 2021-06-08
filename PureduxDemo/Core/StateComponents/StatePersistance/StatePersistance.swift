//
//  StatePersistance.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

struct StatePersistance: Codable {
    private var delayedSaveJob: DelayedJob

    init(delayInterval: TimeInterval) {
        delayedSaveJob = DelayedJob(timeInterval: delayInterval)
    }
}

extension StatePersistance {
    var delayedSaveRequest: RequestState<DelayedRequest> {
        delayedSaveJob.request
    }
}

// MARK: - Reducer

extension StatePersistance {
    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case is Actions.Persistance.SaveState.Success:
            delayedSaveJob.setFinished()

        case is Actions.Persistance.SaveState.Failure:
            delayedSaveJob.setFailed()

        case is Actions.Persistance.SaveState.Cancel:
            delayedSaveJob.setCancelled()

        case is Actions.Auth.Login.Result.Success:
            delayedSaveJob.forceSchedule(now: env.now(), makeUUID: env.makeUUID)

        case is Actions.Auth.Logout.PerformLogout:
            delayedSaveJob.forceSchedule(now: env.now(), makeUUID: env.makeUUID)

        case is Actions.App.State.WillResignActive:
            delayedSaveJob.forceSchedule(now: env.now(), makeUUID: env.makeUUID)

        default:
            delayedSaveJob.scheduleIfNeeded(now: env.now(), makeUUID: env.makeUUID)
        }

    }
}
