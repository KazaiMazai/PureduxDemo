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
        private let config: AppUITheme.Config

        static func stylesForTheme(config: AppUITheme.Config) -> Styles {
            Styles(config: config)
        }
    }
}

extension AppUITheme.Styles {
    var navBar: NavBarStyle {
        NavBarStyle.nativeStyle
    }

    var authTitle: AuthTitle.Style {
        .with(configs: config)
    }

    var authTextField: AuthTextField.Style {
        .with(configs: config)
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
    static func with(configs: AppUITheme.Config) -> AuthTitle.Style {
        AuthTitle.Style(
            titleColor: configs.colors.title.color,
            font: configs.fonts.title.font)
    }
}

extension AuthTextField.Style {
    static func with(configs: AppUITheme.Config) -> AuthTextField.Style {
        AuthTextField.Style(
            keyboardType: .default,
            alignment: .center,
            titleFont: configs.fonts.title.font,
            borderColor: configs.colors.border.color,
            borderColorFocused: configs.colors.primary.color,
            placehodlerColor: configs.colors.lightPlaceholder.color,
            titleColor: configs.colors.title.color,
            backgroundColor: configs.colors.background.color,
            height: configs.sizes.components.inputFields,
            cornerRadius: 8,
            borderWidth: 1,
            horizontalPadding: configs.paddings.large
        )
    }
}
