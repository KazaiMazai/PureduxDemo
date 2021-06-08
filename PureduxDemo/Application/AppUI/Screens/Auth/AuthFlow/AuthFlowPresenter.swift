//
//  AuthFlowPresenter.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import SwiftUI
import PureduxSwiftUI

struct AuthFlowPresenter: PresentableView {
    typealias Content = FlowView<AnyView, AnyView>
    typealias Props = Content.Props<AnyView, AnyView>

    @Environment(\.screenViewsFactory) var viewsFactory

    func props(for state: AppState, on store: ObservableStore<AppState, Action>) -> Props {
        Props(
            presentFirst: state.authentication.isAuthenticated,
            first: { viewsFactory.makeView(for: .moviesFeed).eraseToAnyView },
            second: { viewsFactory.makeView(for: .login).eraseToAnyView })
    }

    func content(for props: Props) -> Content {
        Content(props: props)
    }
}
