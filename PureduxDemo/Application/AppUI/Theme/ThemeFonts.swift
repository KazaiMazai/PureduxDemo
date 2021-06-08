//
//  ThemeFonts.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import SwiftUI
import UIKit

extension AppUITheme {
    struct Fonts {
        let largeTitle: FontType
        let title: FontType
        let headline: FontType
        let subheadline: FontType
        let body: FontType
        let callout: FontType
        let footnote: FontType
        let caption: FontType

        static var defaultFonts: Fonts {
            Fonts(
                largeTitle: .largeTitle,
                title: .title,
                headline: .headline,
                subheadline: .subheadline,
                body: .body,
                callout: .callout,
                footnote: .footnote,
                caption: .caption)
        }
    }
}

extension AppUITheme {
    enum FontType {
        case largeTitle
        case title
        case headline
        case subheadline
        case body
        case callout
        case footnote
        case caption

        case custom(name: String, size: CGFloat)
        case fixedSize(name: String, size: CGFloat)

        var font: Font {
            switch self {
            case .largeTitle:
                return Font.largeTitle
            case .title:
                return Font.title
            case .headline:
                return Font.headline
            case .subheadline:
                return Font.subheadline
            case .body:
                return Font.body
            case .callout:
                return Font.callout
            case .footnote:
                return Font.footnote
            case .caption:
                return Font.caption
            case let .custom(name, size):
                return Font.custom(name, size: size)
            case let .fixedSize(name, size):
                if #available(iOS 14.0, *) {
                    return Font.custom(name, fixedSize: size)
                } else {
                    return Font.custom(name, size: size)
                }
            }
        }

        var uiFont: UIFont {
            switch self {
            case .largeTitle:
                return UIFont.systemFont(ofSize: 34)
            case .title:
                return UIFont.systemFont(ofSize: 28)
            case .headline:
                return UIFont.boldSystemFont(ofSize: 17)
            case .subheadline:
                return UIFont.systemFont(ofSize: 15)
            case .body:
                return UIFont.systemFont(ofSize: 17)
            case .callout:
                return UIFont.systemFont(ofSize: 16)
            case .footnote:
                return UIFont.systemFont(ofSize: 13)
            case .caption:
                return UIFont.systemFont(ofSize: 12)
            case let .custom(name, size):
                return UIFont(name: name, size: size)!
            case let .fixedSize(name, size):
                return UIFont(name: name, size: size)!
            }
        }
    }
}
