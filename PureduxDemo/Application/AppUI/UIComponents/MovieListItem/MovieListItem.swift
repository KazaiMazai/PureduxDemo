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
        let titleColor: Color
        let descriptionTitleColor: Color

        let titleFont: Font
        let descriptionFont: Font
        let padding: CGFloat

        static var defaultStyle: Style {
            Style(titleColor: .black,
                  descriptionTitleColor: .gray,
                  titleFont: Font.title,
                  descriptionFont: Font.body,
                  padding: 8)
        }
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
