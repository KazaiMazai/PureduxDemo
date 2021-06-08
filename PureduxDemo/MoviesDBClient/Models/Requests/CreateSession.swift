//
//  CreateSession.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client.Requests {
    struct CreateSession: Codable {
        let requestToken: String
    }

    struct CreateSessionWithLogin: Codable {
        let username: String
        let password: String
        let requestToken: String
    }
}
