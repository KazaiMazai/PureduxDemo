//
//  MoviesFeedSideEffects.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import Foundation
import PureduxStore
import PureduxNetworkOperator
import PureduxSideEffects
import PureduxCommonCore

struct MoviesFeedSideEffects: NetworkSideEffects {
    let client: MoviesDBDiscover

    var effects: SideEffects<AppState, Action, [NetworkOperator.Request]> {
        [
            SideEffects(props: initialFetchFeed),
            SideEffects(props: pageFetchFeed)
        ]
        .compactMap { $0 }
    }
}

private extension MoviesFeedSideEffects {
    func initialFetchFeed(state: AppState, on store: Store<AppState, Action>) -> NetworkOperator.Request? {
        guard case let .inProgress(requestState) = state.moviesFeed.intitialRequest,
              requestState.canPerform(state.currentTime.now)
        else {
            return nil
        }

        do {

            let req = try client.discoverPopularMovies()
            return prepareRequest(
                requestState.id,
                request: req,
                store: store) {

                switch $0 {
                case .success(let result):
                    return Actions.MoviesFeed.FetchResult.Success(
                        page: result.page,
                        totalPages: result.totalPages,
                        items: result.results.map { $0.appModel }
                    )
                case .cancelled:
                    return Actions.MoviesFeed.FetchResult.Cancelled()
                case let .unauthorized(error), let .failed(error):
                    return Actions.MoviesFeed.FetchResult.Failed(page: 0,
                                                                 error: error)
                }
            }

        } catch {
            store.dispatch(Actions.MoviesFeed.FetchResult.Failed(page: 0,
                                                                 error: error))
            return nil
        }
    }

    func pageFetchFeed(state: AppState, on store: Store<AppState, Action>) -> NetworkOperator.Request? {
        guard case let .inProgress(requestState) = state.moviesFeed.pageRequest,
              requestState.canPerform(state.currentTime.now)

        else {
            return nil
        }

        let page = requestState.payload
        do {
            let req = try client.discoverPopularMovies(page: page)
            return prepareRequest(
                requestState.id,
                request: req,
                store: store) {

                switch $0 {
                case .success(let result):
                    return Actions.MoviesFeed.FetchResult.Success(
                        page: result.page,
                        totalPages: result.totalPages,
                        items: result.results.map { $0.appModel }
                    )
                case .cancelled:
                    return Actions.MoviesFeed.FetchResult.Cancelled()
                case let .unauthorized(error), let .failed(error):
                    return Actions.MoviesFeed.FetchResult.Failed(page: page,
                                                                 error: error)
                }
            }

        } catch {
            store.dispatch(Actions.MoviesFeed.FetchResult.Failed(page: page,
                                                                 error: error))
            return nil
        }
    }
}
