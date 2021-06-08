//
//  MoviesList.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

extension Actions {
    enum MoviesList { }
}

extension Actions.MoviesList {
    enum FetchResult {}
}

extension Actions.MoviesList {
    struct Flow: Action {
        let isActive: Bool
    }

    struct FetchMore: Action {
        
    }
}

extension Actions.MoviesList.FetchResult {
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
