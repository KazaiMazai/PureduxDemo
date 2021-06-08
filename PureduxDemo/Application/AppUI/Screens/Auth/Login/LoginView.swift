//
//  LoginView.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension LoginView {
    struct Props {
        let title: AuthTitle.Props
        let username: AuthTextField.Props
        let password: AuthSecuredTextField.Props
        let loginButton: ActionButton.Props

        static var preview: Props {
            Props(
                title: .preview,
                username: .preview,
                password: .preview,
                loginButton: .preview)
        }
    }
}

struct LoginView: View {
    @Environment(\.appUITheme) var theme
    let props: Props

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            AuthTitle(
                props: props.title,
                style: theme.styles.authTitle)
            Spacer()
            VStack(spacing: theme.config.paddings.large) {
                AuthTextField(
                    props: props.username,
                    style: theme.styles.authTextField)
                AuthSecuredTextField(
                    props: props.password,
                    style: theme.styles.authSecuredTextField)
            }
            Spacer()
            ActionButton(
                props: props.loginButton,
                style: theme.styles.mainActionButton)
        }
        .padding([.leading, .trailing, .bottom], theme.config.paddings.huge)
        .nativeKeyboardAdaptive()
        .background(theme.config.colors.mainBackground.color.edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(props: .preview)
    }
}
