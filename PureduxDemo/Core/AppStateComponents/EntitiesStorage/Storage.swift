//
//  Storage.swift
//  BETest
//
//  Created by Sergey Kazakov on 21.05.2021.
//

import Foundation
import PureduxCommonCore

public struct Storage: Codable {
    public private(set) var lastModified: Date = .distantPast
    private(set) var schema = ModelSchema()
}

extension Storage {
    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        default:
            break
        }
    }
}

