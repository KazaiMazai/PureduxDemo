//
//  LoginPresenteer.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI
import PureduxSwiftUI

struct LoginPresenter: PresentableView {
    func content(for props: LoginView.Props) -> some View {
        LoginView(props: props)
    }

    func props(for state: AppState, on store: ObservableStore<AppState, Action>) -> LoginView.Props {
        LoginView.Props(
            title: AuthTitle.Props(text: L10n.Login.title),
            username: AuthTextField.Props(
                binding: Binding(
                    get: { state.login.pickCredentials.username },
                    set: { store.dispatch(Actions.Auth.Login.UpdateUsername(value: $0)) }
                ),
                placeholder: L10n.Login.Placeholder.email),
            password: AuthSecuredTextField.Props(
                binding: Binding(
                    get: { state.login.pickCredentials.password },
                    set: { store.dispatch(Actions.Auth.Login.UpdatePassword(value: $0)) }
                ),
                placeholder: L10n.Login.Placeholder.password),
            loginButton: ActionButton.Props(
                title: L10n.Login.MainButton.title,
                state: ActionButton.Props.State(
                    isInProgress: state.login.pickCredentials.isInProgress,
                    isEnabled: state.login.pickCredentials.canPerformLogin,
                    action: store.dispatching(Actions.Auth.Login.Perform()))))
    }
}
