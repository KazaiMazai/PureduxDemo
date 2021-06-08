//
//  MoviesFeedView.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension MoviesFeedView {
    struct Props {
        let navBarTitle: String
        let items: [Identifying<Int, ItemType>]
        let onAppear: Command

        static var preview: Props {
            Props(navBarTitle: "Title",
                  items: [],
                  onAppear: nop)
        }
    }
}

struct MoviesFeedView: View {
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
        .onAppear { props.onAppear() }
        .navigationBarTitle(props.navBarTitle)
    }
}

extension MoviesFeedView.Props {
    enum ItemType {
        case movieListItem(MovieListItem.Props)
        case placeholder
    }

}
