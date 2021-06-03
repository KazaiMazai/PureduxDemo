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
    let colors: Colors
    let fonts: Fonts
    let paddings: Paddings

    static var defaultTheme: AppUITheme = {
        let colors = Colors.defaultColors
        let fonts = Fonts.defaultFonts
        let paddings =  Paddings.defaultPaddings

        let styles = Styles.defaultStyles(colors: colors, fonts: fonts)

        return AppUITheme(
            styles: styles,
            colors: colors,
            fonts: fonts,
            paddings: paddings)
    }()
}
