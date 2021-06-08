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
                   authTitle: .styleFor(config: config),
                   authTextField: .styleFor(config: config),
                   authSecuredTextField: .styleFor(config: config),
                   mainActionButton: .styleFor(config: config),
                   movieListItem: .styleFor(config: config)
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
    static func styleFor(config: AppUITheme.Config) -> MovieListItem.Style {
        MovieListItem.Style(
            titleColor: config.colors.title.color,
            descriptionTitleColor: config.colors.subtitle.color,
            titleFont: config.fonts.title.font,
            descriptionFont: config.fonts.body.font,
            verticalPadding: config.paddings.normal)
    }
}

extension AuthTitle.Style {
    static func styleFor(config: AppUITheme.Config) -> AuthTitle.Style {
        AuthTitle.Style(
            titleColor: config.colors.title.color,
            font: config.fonts.title.font)
    }
}

extension AuthSecuredTextField.Style {
    static func styleFor(config: AppUITheme.Config) -> AuthSecuredTextField.Style {
        AuthSecuredTextField.Style(
            keyboardType: .default,
            alignment: .center,
            titleFont: config.fonts.title,
            borderColor: config.colors.border.color,
            borderColorFocused: config.colors.primary.color,
            placehodlerColor: config.colors.lightPlaceholder.color,
            titleColor: config.colors.title,
            backgroundColor: config.colors.background.color,
            height: config.sizes.components.inputFields,
            cornerRadius: config.sizes.corners.small,
            borderWidth: config.sizes.boarders.line,
            horizontalPadding: config.paddings.large
        )
    }
}

extension AuthTextField.Style {
    static func styleFor(config: AppUITheme.Config) -> AuthTextField.Style {
        AuthTextField.Style(
            keyboardType: .default,
            alignment: .center,
            titleFont: config.fonts.title.font,
            borderColor: config.colors.border.color,
            borderColorFocused: config.colors.primary.color,
            placehodlerColor: config.colors.lightPlaceholder.color,
            titleColor: config.colors.title.color,
            backgroundColor: config.colors.background.color,
            height: config.sizes.components.inputFields,
            cornerRadius: config.sizes.corners.small,
            borderWidth: config.sizes.boarders.line,
            horizontalPadding: config.paddings.large
        )
    }
}

extension ActionButton.Style {
    static func styleFor(config: AppUITheme.Config) -> ActionButton.Style {
        ActionButton.Style(
            titleFont: config.fonts.title.font,
            titleColor: config.colors.title.color,
            backgroundColor: config.colors.primary.color,
            backgroundDisabledColor: config.colors.lightPlaceholder.color,
            cornerRadius: config.sizes.corners.small,
            height: config.sizes.components.mainButtonHeight,
            maxWidth: config.sizes.components.mainButtonMaxWidth
        )
    }
}
