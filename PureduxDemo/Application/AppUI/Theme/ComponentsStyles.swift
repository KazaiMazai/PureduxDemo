//
//  ComponentsStyles.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import Foundation
import SwiftUI

extension AppUITheme {
    struct Styles {
        let navBarStyle: NavBarStyle
        let authTitleStyle: AuthTitle.Style

        static func defaultStyles(colors: Colors, fonts: Fonts) -> Styles {
            Styles(
                navBarStyle: NavBarStyle.nativeStyle,
                authTitleStyle: .with(colors: colors, fonts: fonts))
        }
    }
}

extension AppUITheme.Styles {
    struct NavBarStyle {
        let titleColor: Color
        let backgroundColor: Color
        let separatorColor: Color
        let titleFont: Font
        let height: CGFloat

        static var nativeStyle: NavBarStyle {
            NavBarStyle(
                titleColor: AppUITheme.ColorType.black.color,
                backgroundColor: AppUITheme.ColorType.rgb(
                    red: 247.0 / 255.0,
                    green: 247.0 / 255.0,
                    blue: 247.0 / 255.0).color,
                separatorColor: AppUITheme.ColorType.rgb(
                    red: 210.0 / 255.0,
                    green: 210.0 / 255.0,
                    blue: 210.0 / 255.0).color,
                titleFont: Font.system(
                    size: 17,
                    weight: .semibold),
                height: 44)
        }
    }
}

extension AuthTitle.Style {
    static func with(colors: AppUITheme.Colors,
                     fonts: AppUITheme.Fonts) -> AuthTitle.Style {
        AuthTitle.Style(
            titleColor: colors.title.color,
            font: fonts.title.font)
    }
}
