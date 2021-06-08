//
//  AppUITheme+UIKit.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import UIKit

extension AppUITheme {
    func configureUIKitAppearance() {
        UINavigationBar.appearance().layoutMargins.left = config.paddings.large
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: config.colors.title.uiColor
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: config.colors.title.uiColor
        ]
        UINavigationBar.appearance().tintColor = config.colors.title.uiColor
        UITextField.appearance().tintColor = config.colors.textFieldTint.uiColor
    }
}
