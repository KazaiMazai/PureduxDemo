//
//  PaginatedResponse.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client.Responses {
    struct PaginatedResponse<Resource: Codable>: Codable {
        let page: Int
        let totalPages: Int
        let totalResults: Int
        let results: [Resource]
    }
}
