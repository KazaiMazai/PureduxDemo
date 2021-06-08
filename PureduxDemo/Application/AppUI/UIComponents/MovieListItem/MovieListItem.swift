//
//  File.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension MovieListItem {
    struct Props {
        let title: String
        let description: String
        let onAppear: Command?

        static var preview: Props {
            Props(
                title: "Title",
                description: "Description",
                onAppear: nil)
        }
    }
}

extension MovieListItem {
    struct Style {
        var titleColor: Color = .black
        var descriptionTitleColor: Color = .gray

        var titleFont: Font = .title
        var descriptionFont: Font = .body
        var verticalPadding: CGFloat = 8
    }
}

struct MovieListItem: View {
    let props: Props
    let style: Style

    var body: some View {
        VStack(alignment: .leading, spacing: style.verticalPadding) {
            Text(props.title)
                .foregroundColor(style.titleColor)
                .font(style.titleFont)

            Text(props.description)
                .foregroundColor(style.descriptionTitleColor)
                .font(style.descriptionFont)
                .padding(.bottom, style.verticalPadding)
            
        }.onAppear { props.onAppear?() }
    }
}
