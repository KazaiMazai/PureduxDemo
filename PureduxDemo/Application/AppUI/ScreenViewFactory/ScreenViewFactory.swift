//
//  ScreenViewFactory.swift
//  BETest
//
//  Created by Sergey Kazakov on 23.05.2021.
//

import SwiftUI

struct ScreenViewsFactory {
    @ViewBuilder
    func makeView(for type: ScreenViews) -> some View {
        switch type {
        case .login:
            LoginPresenter()
        case .moviesFeed:
            Color.red
        case .movieDetail:
            Color.yellow
        }
    }
}

extension ScreenViewsFactory {
    static let defaultScreenViewsFactory: ScreenViewsFactory =  {
        ScreenViewsFactory()
    }()
}
