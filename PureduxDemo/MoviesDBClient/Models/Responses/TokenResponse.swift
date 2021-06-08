//
//  Token.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client.Responses {
    struct Token: Codable {
        let expiresAt: Date
        let requestToken: String
    }
}
