//
//  ScreenViewFactoryKey.swift
//  BETest
//
//  Created by Sergey Kazakov on 23.05.2021.
//

import SwiftUI

struct ScreenViewFactoryKey: EnvironmentKey {
    static let defaultValue: ScreenViewsFactory = ScreenViewsFactory.defaultScreenViewsFactory
}

extension EnvironmentValues {
    var screenViewsFactory: ScreenViewsFactory {
        get { self[ScreenViewFactoryKey.self] }
        set { self[ScreenViewFactoryKey.self] = newValue }
    }
}
