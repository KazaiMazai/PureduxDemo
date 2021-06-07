//
//  MoviesListView.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension MoviesListView {
    struct Props {
        let navBarTitle: String
        let items: [Identifying<Int, ItemType>]
    }
}

struct MoviesListView: View {
    @Environment(\.appUITheme) var theme
    let props: Props

    var body: some View {
        List {
            ForEach(props.items) {
                switch $0.element {
                case .movieListItem(let props):
                    MovieListItem(props: props, style: theme.styles.movieListItem)
                case .placeholder:
                    Color.gray.frame(height: 52)
                }
            }
        }
        .navigationBarTitle(props.navBarTitle)
    }
}

extension MoviesListView.Props {
    enum ItemType {
        case movieListItem(MovieListItem.Props)
        case placeholder
    }

}
