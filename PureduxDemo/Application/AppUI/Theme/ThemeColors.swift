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
        let background: ColorType
        let backgroundDark: ColorType

        let accent: ColorType
        let basicAdding: ColorType

        let lightTitle: ColorType
        let darkTitle: ColorType

        let title: ColorType
        let subtitle: ColorType

        let lightPlaceholder: ColorType

        static let defaultColors: Colors = {
            Colors(
                background: .hex(ColorHex.grayScale5),
                backgroundDark: .hex(ColorHex.grayScale1),

                accent: .hex(ColorHex.mainBlue),
                basicAdding: .hex(ColorHex.darkBlue),

                lightTitle: .hex(ColorHex.grayScale4),
                darkTitle: .hex(ColorHex.grayScale1),

                title: .hex(ColorHex.grayScale3),
                subtitle: .hex(ColorHex.grayScale4),
                lightPlaceholder: .hex(ColorHex.grayScale5))
        }()
    }
}

extension AppUITheme.Colors {
    enum ColorHex {
        static let grayScale1: String = "#333333"
        static let grayScale2: String = "#5A5A5A"
        static let grayScale3: String = "#858585"
        static let grayScale4: String = "#D6D6D6"
        static let grayScale5: String = "#EBEBEB"

        static let lightWhite: String = "#FFFFFF"

        static let mainBlue: String = "#3286FA"
        static let darkBlue: String = "#0061F9"

        static let richRed: String = "#FF3B30"
    }
}
