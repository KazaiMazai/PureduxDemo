//
//  File.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension MovieListItem {
    struct Props: Hashable, Equatable {
        let title: String
        let description: String

        static var preview: Props {
            Props(
                title: "Title",
                description: "Description")
        }
    }
}

extension MovieListItem {
    struct Style {
        var titleColor: Color = .black
        var descriptionTitleColor: Color = .gray

        var titleFont: Font = .title
        var descriptionFont: Font = .body
        var padding: CGFloat = 8
    }
}

struct MovieListItem: View {
    let props: Props
    let style: Style

    var body: some View {
        VStack(alignment: .leading, spacing: style.padding) {
            Text(props.title)
                .foregroundColor(style.titleColor)
                .font(style.titleFont)
            Text(props.title)
                .foregroundColor(style.titleColor)
                .font(style.titleFont)
        }
    }
}
