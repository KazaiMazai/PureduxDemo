//
//  AppUITheme.swift
//  BETest
//
//  Created by Sergey Kazakov on 02.10.2020.
//

import SwiftUI
import UIKit

struct AppUITheme {
    let navBarStyle: NavBarStyle

    static var defaultTheme: AppUITheme {
        AppUITheme(navBarStyle: NavBarStyle())
    }
}

extension AppUITheme {
    struct NavBarStyle {
        let titleColor = Color.black
        let backgroundColor = Color(red: 247.0 / 255.0, green: 247.0 / 255.0, blue: 247.0 / 255.0)
        let separatorColor = Color(red: 210.0 / 255.0, green: 210.0 / 255.0, blue: 210.0 / 255.0)
        let titleFont = Font.system(size: 17, weight: .semibold)
        let height: CGFloat = 44
    }
}

extension AppUITheme {
    struct Shadow {
        let color = Color(hex: "#000000")
        let alpha: Double = 0.5
        let offset = CGSize(width: 1, height: 1)
        let blur: CGFloat = 4
    }
}

extension AppUITheme {
    struct Paddings {
        let interItemSpacing: CGFloat = 30
        let textPaddings: CGFloat = 10
        let leftContentInset: CGFloat = 20
        let leftBodyInset: CGFloat = 11
        let triangularHeight: CGFloat = 18
        let triangeSize = CGSize(width: 11, height: 18)
        let maxWidthProportion: CGFloat = 0.75
    }
}
