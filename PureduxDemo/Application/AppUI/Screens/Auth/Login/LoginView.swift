//
//  LoginView.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension LoginView {
    struct Props {
        let emailTextField: AuthTextField.Props
        let passwordTextField: AuthSecuredTextField.Props
        let title: AuthTitle.Props

        let actionButton: ActionButton.Props

        static var preview: Props {
            Props(
                emailTextField: .preview,
                passwordTextField: .preview,
                title: .preview,
                actionButton: .preview)
        }
    }
}

struct LoginView: View {
    @Environment(\.appUITheme) var theme
    let props: Props

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            AuthTitle(props: props.title, style: theme.styles.authTitle)
            Spacer()

            VStack(spacing: theme.config.paddings.large) {
                AuthTextField(props: props.emailTextField,
                              style: theme.styles.authTextField)
                AuthSecuredTextField(props: props.passwordTextField,
                                     style: .defaultStyle)
                ActionButton(props: props.actionButton,
                             style: theme.styles.mainActionButton)
            }

            Spacer()
        }
        .padding([.leading, .trailing], theme.config.paddings.huge)
        .nativeKeyboardAdaptive()
        .background(theme.config.colors.background.color.edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(props: .preview)
    }
}
