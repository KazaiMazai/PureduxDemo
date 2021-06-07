//
//  View+Placeholder.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import SwiftUI

public struct PlaceHolder<T: View>: ViewModifier {
    let placeHolder: T
    let alignment: Alignment
    let show: Bool

    public func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            placeHolder
                .opacity(show ? 1.0 : 0.0)
            content
        }
    }
}

public extension View {
    func placeHolder<T: View>(_ holder: T, alignment: Alignment = .leading, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder: holder, alignment: alignment, show: show))
    }
}

public struct VerticalPlaceHolder<T: View>: ViewModifier {
    let placeHolder: T
    let show: Bool
    let spacing: CGFloat?

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            placeHolder
                .animation(.default)
                .opacity(show ? 1.0 : 0.0)
                .animation(nil)
            content
        }
    }
}

public extension View {
    func verticalPlaceHolder<T: View>(_ holder: T, show: Bool, spacing: CGFloat? = nil) -> some View {
        self.modifier(VerticalPlaceHolder(placeHolder: holder, show: show, spacing: spacing))
    }
}
