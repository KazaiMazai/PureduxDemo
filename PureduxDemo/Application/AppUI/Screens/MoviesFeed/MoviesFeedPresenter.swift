//
//  MoviesFeedPresenter.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import SwiftUI
import PureduxSwiftUI
import PureduxCommon

struct MoviesFeedPresenter: PresentableView {
    func content(for props: MoviesFeedView.Props) -> MoviesFeedView {
        MoviesFeedView(props: props)
    }

    func props(for state: AppState, on store: ObservableStore<AppState, Action>) -> MoviesFeedView.Props {
        Props(
            navBarTitle: L10n.MoviesFeed.NavBar.title,
            logout: NavBarButton.Props(
                title: L10n.MoviesFeed.NavBar.Buttons.logout,
                action: store.dispatching(Actions.Auth.Logout.PerformLogout(forced: false))),
            items: movieItemsProps(for: state, on: store),
            onAppear: store.dispatching(Actions.MoviesFeed.Flow(isActive: true))
        )
    }

    var distinctStateChangesBy: Equating<AppState> {
        .equal { $0.storage.lastModified } &&
        .equal { $0.moviesFeed.lastModified }
    }
}

extension MoviesFeedPresenter {
    func movieItemsProps(
        for state: AppState,
        on store: ObservableStore<AppState, Action>) -> [Identifying<Int, MoviesFeedView.Props.ItemType>] {

        let ids = state.moviesFeed.movies
        let movies = state.storage.movies.findAllById(ids)

        let canPaginate = state.moviesFeed.canPaginate
        let lastIndex = movies.count - 1

        return movies
            .enumerated()
            .map { idx, item in
                MovieListItem.Props(
                    title: item.title,
                    description: item.description,
                    onAppear: idx == lastIndex && canPaginate ?
                        store.dispatching(Actions.MoviesFeed.FetchMore())
                        : nil)
            }
            .map { MoviesFeedView.Props.ItemType.movieListItem($0) }
            .enumerated()
            .map { idx, item in Identifying(id: idx, element: item) }
    }
}
