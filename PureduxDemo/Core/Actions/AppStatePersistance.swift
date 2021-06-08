//
//  AppStatePersistance.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

extension Actions {
    enum Persistance { }
}

extension Actions.Persistance {
    enum SaveState { }
}
extension Actions.Persistance.SaveState {
    struct Success: Action {
      
    }

    struct Failure: ErrorAction {
        let error: SomeError
    }

    struct Cancel: Action {

    }
}
