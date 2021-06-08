//
//  Root.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import SwiftUI

extension RootView {
    struct Props<Content: View> {
        let content: () -> Content
        let alert: Alert.Props

        @Binding var showAlert: Bool

        let willResignActive: Command
        let didEnterBackground: Command

        let willEnterForeground: Command
        let didBecomeActive: Command

        static var preview: Props<Color> {
            Props<Color>(
                content: { Color.red },
                alert: .none,
                showAlert: .constant(false),
                willResignActive: nop,
                didEnterBackground: nop,
                willEnterForeground: nop,
                didBecomeActive: nop)
        }

        static func preview<Content>(
            content: @escaping () -> Content) -> Props<Content> {

            Props<Content>(
                content: content,
                alert: .none,
                showAlert: .constant(false),
                willResignActive: nop,
                didEnterBackground: nop,
                willEnterForeground: nop,
                didBecomeActive: nop)
        }
    }
}

struct RootView<Content: View>: View {
    let props: Props<Content>

    var body: some View {
        props.content()
            .alert(isPresented: props.$showAlert) { Alert(props: props.alert) }
            .onReceive(NotificationCenter.default.publisher(
                        for: UIApplication.willEnterForegroundNotification)) { _ in
                props.willEnterForeground()
            }
            .onReceive(NotificationCenter.default.publisher(
                        for: UIApplication.didBecomeActiveNotification)) { _ in
                props.didBecomeActive()
            }
            .onReceive(NotificationCenter.default.publisher(
                        for: UIApplication.willResignActiveNotification)) { _ in
                props.willResignActive()
            }
            .onReceive(NotificationCenter.default.publisher(
                        for: UIApplication.didEnterBackgroundNotification)) { _ in
                props.didEnterBackground()
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView(
                props: RootView.Props(
                    content: { Color.green },
                    alert: .none,
                    showAlert: .constant(false),
                    willResignActive: nop,
                    didEnterBackground: nop,
                    willEnterForeground: nop,
                    didBecomeActive: nop))

            RootView(
                props: RootView.Props(
                    content: { Color.red },
                    alert: .preview,
                    showAlert: .constant(true),
                    willResignActive: nop,
                    didEnterBackground: nop,
                    willEnterForeground: nop,
                    didBecomeActive: nop))
        }
    }

}
