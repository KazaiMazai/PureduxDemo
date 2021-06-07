//
//  AppUITheme.swift
//  BETest
//
//  Created by Sergey Kazakov on 02.10.2020.
//

import SwiftUI
import UIKit

struct AppUITheme {
    let styles: Styles
    let config: Config

    static var defaultTheme: AppUITheme = {
        let config = Config.defaultConfig

        return AppUITheme(
            styles: .stylesForTheme(config: config),
            config: config)
    }()

    struct Config {
        let colors: Colors
        let fonts: Fonts
        let paddings: Paddings
        let sizes: Sizes

        static var defaultConfig: Config = {
            let colors = Colors.defaultColors
            let fonts = Fonts.defaultFonts
            let paddings =  Paddings.defaultPaddings
            let sizes = Sizes.defaultSizes

            return Config(
                colors: colors,
                fonts: fonts,
                paddings: paddings,
                sizes: sizes)
        }()
    }
}
