//
//  Movie.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation

extension Client.Responses {
    struct Movie: Codable {
        let id: Int
        let title: String
        let originalTitle: String
        let overview: String
        let posterPath: String?
    }
}
