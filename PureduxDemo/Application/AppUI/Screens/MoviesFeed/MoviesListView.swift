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
        let logout: NavBarButton.Props
        let items: [Identifying<Int, ItemType>]
        let onAppear: Command

        static var preview: Props {
            Props(navBarTitle: "Title",
                  logout: .preview,
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
                    MovieListItem(props: props,
                                  style: theme.styles.movieListItem)
                case .placeholder:
                    Color.gray.frame(height: 52)
                }
            }
        }

        .onAppear { props.onAppear() }
        .navigationBarTitle(props.navBarTitle)
        .background(Color.red.edgesIgnoringSafeArea(.all))
        .navigationBarItems(
            trailing: NavBarButton(
                props: props.logout,
                style: theme.styles.navBarButton))

    }
}

extension MoviesFeedView.Props {
    enum ItemType {
        case movieListItem(MovieListItem.Props)
        case placeholder
    }

}
