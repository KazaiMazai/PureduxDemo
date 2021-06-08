//
//  AuthTitle.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import SwiftUI

extension AuthTitle {
    struct Props: Hashable, Equatable {
        let text: String

        static var preview: Props {
            Props(text: "Title")
        }
    }
}

extension AuthTitle {
    struct Style {
        var titleColor: Color = .black
        var font: Font = .title
    }
}

struct AuthTitle: View {
    let props: Props
    let style: Style

    var body: some View {
        Text(props.text)
            .foregroundColor(style.titleColor)
            .font(style.font)
    }
}
