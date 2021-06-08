//
//  MoviesList.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

extension Actions {
    enum MoviesFeed { }
}

extension Actions.MoviesFeed {
    enum FetchResult {}
}

extension Actions.MoviesFeed {
    struct Flow: Action {
        let isActive: Bool
    }

    struct FetchMore: Action {
        
    }
}

extension Actions.MoviesFeed.FetchResult {
    struct Failed: ErrorAction {
        var page: Int
        let error: SomeError

        init(page: Int, error: Error) {
            self.page = page
            self.error = SomeError(error: error)
        }

    }

    struct Success: Action {
        let page: Int
        let totalPages: Int
        let items: [Movie]
    }

    struct Cancelled: Action {

    }
}
