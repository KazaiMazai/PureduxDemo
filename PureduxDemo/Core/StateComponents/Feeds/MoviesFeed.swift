//
//  MoviesListState.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxCommonCore

struct MoviesFeed {
    private(set) var lastModified: Date = .distantPast
    private(set) var movies: [Movie.ID] = []
    private(set) var intitialRequest: RequestState<SingleRequest> = .none
    private(set) var pageRequest: RequestState<PageRequest> = .none

    private var hasMoreItems: Bool = false
    private var currentPage: Int = 0
}

extension MoviesFeed {
    typealias PageRequest = RequestWithPayload<SingleRequest, Int>
}

extension MoviesFeed {
    var canPaginate: Bool {
        hasMoreItems && !pageRequest.isInProgress
    }

    var isInProgress: Bool {
        intitialRequest.isInProgress
    }
}

// MARK: - Reducer
extension MoviesFeed {
    mutating func reduce(_ action: Action, env: AppEnvironment) {
        switch action {
        case is Actions.App.State.DidBecomeActive:
            lastModified = env.now()
            refreshFeed(requestId: env.makeUUID())

        case let action as Actions.MoviesFeed.Flow:
            guard action.isActive else {
                self = .init()
                return
            }

            lastModified = env.now()
            refreshFeed(requestId: env.makeUUID())

        case is Actions.MoviesFeed.FetchMore:
            lastModified = env.now()
            fetchMore(requestId: env.makeUUID())

        case let action as Actions.MoviesFeed.FetchResult.Failed:
            lastModified = env.now()
            handleRequestFail(page: action.page)

        case let action as Actions.MoviesFeed.FetchResult.Success:
            lastModified = env.now()
            handleRequestSucess(movies: action.items, page: action.page, totalPages: action.totalPages)

        default:
            break
        }
    }
}

// MARK: - Mutations

private extension MoviesFeed {
    mutating func refreshFeed(requestId: UUID) {
        if intitialRequest.isInProgress {
            return
        }

        intitialRequest = .inProgress(SingleRequest(id: RequestID(rawValue: requestId)))
        pageRequest = .none
        currentPage = 0
    }

    mutating func fetchMore(requestId: UUID) {
        if pageRequest.isInProgress {
            return
        }

        guard hasMoreItems else {
            return
        }

        pageRequest = .inProgress(
            PageRequest(
                payload: currentPage + 1,
                state: SingleRequest(id: RequestID(rawValue: requestId))))
    }

    mutating func handleRequestSucess(movies: [Movie], page: Int, totalPages: Int) {
        if page == 0 {
            handleInitialFetchSuccess(movies: movies, hasMore: page < totalPages)
        } else {
            handlePageFetchSuccess(movies: movies, page: page, hasMore: page < totalPages)
        }
    }

    mutating func handleRequestFail(page: Int) {
        if page == 0 {
            handleInitialRequestFail()
        } else {
            handlePageRequestFail()
        }
    }

    mutating func handleInitialRequestFail() {
        intitialRequest = .failed
    }

    mutating func handleInitialFetchSuccess(movies: [Movie], hasMore: Bool) {
        self.movies = movies.map { $0.id }
        intitialRequest = .success
        pageRequest = .none
        hasMoreItems = hasMore
        currentPage = 0
    }

    mutating func handlePageRequestFail() {
        pageRequest = .failed
    }

    mutating func handlePageFetchSuccess(movies: [Movie], page: Int, hasMore: Bool) {
        self.movies.append(contentsOf: movies.map { $0.id })
        pageRequest = .success
        hasMoreItems = hasMore
        currentPage = page
    }
}
