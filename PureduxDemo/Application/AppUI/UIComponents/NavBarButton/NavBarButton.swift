//
//  NavBarButton.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 09.06.2021.
//

import SwiftUI

extension NavBarButton {
    struct Props {
        let title: String
        let action: Command

        static var preview: Props {
            Props(title: "Title",
                  action: nop)
        }
    }

    struct Style {
        var titleFont: Font = .body
        var titleColor: Color = .white
        var backgoundColor: Color = .blue
        var height: CGFloat = 32
        var horizontalPadding: CGFloat = 16
    }
}

struct NavBarButton: View {
    let props: Props
    let style: Style

    var body: some View {
        Button(action: props.action) {
            Text(props.title)
                .font(style.titleFont)
                .foregroundColor(style.titleColor)
                .frame(height: style.height)
                .padding(.horizontal, style.horizontalPadding)
        }
        .background(Capsule().fill(style.backgoundColor))
    }
}

struct NavBarButton_Previews: PreviewProvider {
    static var previews: some View {
        NavBarButton(props: .preview, style: NavBarButton.Style())
    }
}
