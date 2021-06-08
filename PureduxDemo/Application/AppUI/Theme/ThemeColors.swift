//
//  ThemeColors.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import UIKit
import SwiftUI

extension AppUITheme {
    enum ColorType {
        case black
        case blue
        case gray
        case white
        case green
        case red

        case hex(String)
        case rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0)

        var color: Color {
            switch self {
            case .black:
                return Color.black
            case .blue:
                return Color.blue
            case .gray:
                return Color.gray
            case .white:
                return Color.white
            case .green:
                return Color.green
            case .red:
                return Color.red
            case .hex(let hexColor):
                return Color(hexColor)
            case let .rgb(red, green, blue, alpha):
                return Color(
                    red: Double(red),
                    green: Double(green),
                    blue: Double(blue),
                    opacity: Double(alpha))
            }
        }

        var uiColor: UIColor {
            switch self {
            case .black:
                return UIColor.black
            case .blue:
                return UIColor.blue
            case .gray:
                return UIColor.gray
            case .white:
                return UIColor.white
            case .green:
                return UIColor.green
            case .red:
                return UIColor.red
            case .hex(let hexColor):
                return UIColor(hex: hexColor) ?? .white
            case let .rgb(red, green, blue, alpha):
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }
        }
    }
}

extension AppUITheme {
    struct Colors {
        let mainBackground: ColorType
        let background: ColorType
        let backgroundDark: ColorType

        let primary: ColorType
        let secondary: ColorType

        let lightTitle: ColorType
        let darkTitle: ColorType
        let buttonTitle: ColorType

        let title: ColorType
        let subtitle: ColorType
        let textFieldTint: ColorType

        let lightPlaceholder: ColorType
        let border: ColorType

        static let defaultColors: Colors = {
            Colors(
                mainBackground: .white,
                background: .white,
                backgroundDark: .gray,

                primary: .blue,
                secondary: .blue,

                lightTitle: .gray,
                darkTitle: .black,
                buttonTitle: .white,

                title: .black,
                subtitle: .gray,
                textFieldTint: .gray,
                lightPlaceholder: .gray,
                border: .gray
            )
        }()
    }
}

extension AppUITheme.Colors {
    private enum ColorHex {
        static let mainBlue: String = "#3286FA"
    }
}
