//
//  Session.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client.Responses {
    struct Session: Codable {
        let sessionId: String
    }
}
