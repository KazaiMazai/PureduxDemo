//
//  ScreenViewFactory.swift
//  BETest
//
//  Created by Sergey Kazakov on 23.05.2021.
//

import SwiftUI

struct ScreenViewsFactory {

    func makeView(for type: ScreenViews) -> AnyView {
        switch type {
        case .root:
            return RootPresenter().eraseToAnyView
        case .authFlow:
            return AuthFlowPresenter().eraseToAnyView
        case .login:
            return LoginPresenter().eraseToAnyView
        case .moviesFeed:
            return Color.red.eraseToAnyView
        case .movieDetail:
            return Color.yellow.eraseToAnyView
        }
    }
}

extension ScreenViewsFactory {
    static let defaultScreenViewsFactory: ScreenViewsFactory =  {
        ScreenViewsFactory()
    }()
}
