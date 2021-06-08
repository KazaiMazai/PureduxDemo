//
//  AppActions.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Actions {
    //swiftlint:disable type_name
    enum App {}
}

extension Actions.App {
    enum State {}
}

extension Actions.App.State {
    struct WillResignActive: Action {

    }

    struct WillEnterForeground: Action {

    }

    struct DidBecomeActive: Action {

    }

    struct DidEnterBackground: Action {

    }
}
