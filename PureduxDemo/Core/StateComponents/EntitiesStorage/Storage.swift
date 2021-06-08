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
    private var schema = ModelSchema()
}

extension Storage {
    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case let action as Actions.MoviesFeed.FetchResult.Success:
            lastModified = env.now()
            schema.movies.saveAll(action.items, timestamp: env.now())
        default:
            break
        }
    }
}

extension Storage {
    var movies: Entities<Movie> {
        schema.movies
    }
}
