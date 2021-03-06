//
//  Session.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

struct Session: Codable {
    //swiftlint:disable type_name
    struct ID: Codable {
        let rawValue: String
    }

    let id: ID
}
