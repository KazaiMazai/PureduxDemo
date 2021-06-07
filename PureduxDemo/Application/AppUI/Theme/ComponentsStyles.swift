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
        let navBar: NavBarStyle
        let authTitle: AuthTitle.Style
        let authTextField: AuthTextField.Style
        let authSecuredTextField: AuthSecuredTextField.Style
        let mainActionButton: ActionButton.Style
        let movieListItem: MovieListItem.Style

        static func stylesForTheme(config: AppUITheme.Config) -> Styles {
            Styles(navBar: .nativeStyle,
                   authTitle: .with(configs: config),
                   authTextField: .with(configs: config),
                   authSecuredTextField: .with(configs: config),
                   mainActionButton: .with(configs: config),
                   movieListItem: .with(configs: config)
            )
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

extension MovieListItem.Style {
    static func with(configs: AppUITheme.Config) -> MovieListItem.Style {
        .defaultStyle
    }
}

extension AuthTitle.Style {
    static func with(configs: AppUITheme.Config) -> AuthTitle.Style {
        .defaultStyle
//        AuthTitle.Style(
//            titleColor: configs.colors.title.color,
//            font: configs.fonts.title.font)
    }
}

extension AuthSecuredTextField.Style {
    static func with(configs: AppUITheme.Config) -> AuthSecuredTextField.Style {
        .defaultStyle
//        AuthSecuredTextField.Style(
//            keyboardType: .default,
//            alignment: .center,
//            titleFont: configs.fonts.title,
//            borderColor: configs.colors.border.color,
//            borderColorFocused: configs.colors.primary.color,
//            placehodlerColor: configs.colors.lightPlaceholder.color,
//            titleColor: configs.colors.title,
//            backgroundColor: configs.colors.background.color,
//            height: configs.sizes.components.inputFields,
//            cornerRadius: configs.sizes.corners.small,
//            borderWidth: configs.sizes.boarders.line,
//            horizontalPadding: configs.paddings.large
//        )
    }
}

extension AuthTextField.Style {
    static func with(configs: AppUITheme.Config) -> AuthTextField.Style {
        .defaultStyle
//        AuthTextField.Style(
//            keyboardType: .default,
//            alignment: .center,
//            titleFont: configs.fonts.title.font,
//            borderColor: configs.colors.border.color,
//            borderColorFocused: configs.colors.primary.color,
//            placehodlerColor: configs.colors.lightPlaceholder.color,
//            titleColor: configs.colors.title.color,
//            backgroundColor: configs.colors.background.color,
//            height: configs.sizes.components.inputFields,
//            cornerRadius: configs.sizes.corners.small,
//            borderWidth: configs.sizes.boarders.line,
//            horizontalPadding: configs.paddings.large
//        )
    }
}

extension ActionButton.Style {
    static func with(configs: AppUITheme.Config) -> ActionButton.Style {
        .defaultStyle
//        ActionButton.Style(
//            titleFont: configs.fonts.title.font,
//            titleColor: configs.colors.title.color,
//            backgroundColor: configs.colors.primary.color,
//            backgroundDisabledColor: configs.colors.lightPlaceholder.color,
//            cornerRadius: configs.sizes.corners.small,
//            height: configs.sizes.components.mainButtonHeight,
//            maxWidth: configs.sizes.components.mainButtonMaxWidth
//        )
    }
}
