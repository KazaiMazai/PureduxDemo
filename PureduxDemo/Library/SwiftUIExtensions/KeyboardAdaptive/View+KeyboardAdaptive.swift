//
//  View+KeyboardAdaprtive.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI
import Combine

public extension View {
    func keyboardAdaptive(bottomOffset: CGFloat = 0) -> some View {
        ModifiedContent(content: ignoreKeyboard(),
                        modifier: KeyboardAdaptive(bottomOffset: bottomOffset))
    }

    func nativeKeyboardAdaptive(bottomOffset: CGFloat = 0) -> some View {
        Group {
            if #available(iOS 14.0, *) {
                self
            } else {
                keyboardAdaptive(bottomOffset: bottomOffset)
            }
        }
    }

    func ignoreKeyboard() -> some View {
        Group {
            if #available(iOS 14.0, *) {
                ignoresSafeArea(.keyboard, edges: .bottom)
            } else {
                self
            }
        }
    }
}

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
public struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0
    let bottomOffset: CGFloat

    public func body(content: Content) -> some View {
        content
            .padding(.bottom, self.bottomPadding)
            .onReceive(Publishers.keyboardPresentation) { keyboard in
                self.bottomPadding =
                    keyboard.isPresented ?
                    keyboard.height - self.bottomOffset
                    :0
            }
            .animation(.easeInOut(duration: 0.25))
    }
}
