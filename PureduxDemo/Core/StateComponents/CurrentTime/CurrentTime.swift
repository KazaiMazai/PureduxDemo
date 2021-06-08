//
//  CurrentTime.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import Foundation
import PureduxCommonCore

typealias CurrentTime = PureduxCommonCore.CurrentTime

struct AppTime: Codable {
    public var state: PureduxCommonCore.CurrentTime

    init(time: Date, interval: Double, initialRequest: UUID) {
        self.state = CurrentTime(time: time, interval: interval, initialRequestId: initialRequest)
    }

    var request: PureduxCommonCore.RequestState<PureduxCommonCore.SingleRequest> {
        state.request
    }

    var delayInterval: TimeInterval {
        state.interval
    }

    var now: Date {
        state.time
    }

    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case is Actions.Time.TimeChanged:
            self.state.handleTimeChanged(env.now(), nextRequestId: env.makeUUID())
        default:
            break
        }

    }
}
