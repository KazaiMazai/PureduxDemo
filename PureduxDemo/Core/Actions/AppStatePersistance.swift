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
    enum Result { }
}
extension Actions.Persistance.Result {
    struct Success: Action {
      
    }

    struct Failure: ErrorAction {
        let error: SomeError
    }

    struct Cancel: Action {

    }
}
