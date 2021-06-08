//
//  Action.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import Foundation

protocol Action { }

enum Actions { }

protocol SecuredLogAction: Action, CustomDebugStringConvertible {

}

extension SecuredLogAction {
    public var debugDescription: String {
        "\(String(reflecting: type(of: self)))(value: \"***\")"
    }
}
