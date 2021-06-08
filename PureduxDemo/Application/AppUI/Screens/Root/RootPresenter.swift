//
//  RootPresenter.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import SwiftUI
import PureduxSwiftUI

struct RootPresenter: PresentableView {
    typealias Content = RootView<AnyView>
    typealias Props = Content.Props<AnyView>

    @Environment(\.appUITheme) var theme
    @Environment(\.screenViewsFactory) var viewsFactory

    init() {
        theme.configureUIKitAppearance()
    }

    func props(for state: AppState, on store: ObservableStore<AppState, Action>) -> Props {
        Props(
            content: { viewsFactory.makeView(for: .authFlow) },
            alert: alertPropsFor(for: state, on: store),
            showAlert: Binding(
                get: { state.errorHandler.hasError },
                set: store.dispatching { _ in Actions.ErrorHandling.DequeueError() }),

            willResignActive: store.dispatching(Actions.App.State.WillResignActive()),
            didEnterBackground: store.dispatching(Actions.App.State.DidEnterBackground()),
            willEnterForeground: store.dispatching(Actions.App.State.WillEnterForeground()),
            didBecomeActive: store.dispatching(Actions.App.State.DidBecomeActive())
        )
    }

    func content(for props: Props) -> Content {
        RootView(props: props)
    }
}

private extension RootPresenter {
    func alertPropsFor(for state: AppState, on store: ObservableStore<AppState, Action>) -> Alert.Props {
        guard let error = state.errorHandler.lastError else {
            return .none
        }

        return Alert.Props(
            title: L10n.Errors.Alert.title,
            message: error.localizedDescription,
            dismiss: L10n.Errors.Alert.Actions.defaultOk)
    }
}
