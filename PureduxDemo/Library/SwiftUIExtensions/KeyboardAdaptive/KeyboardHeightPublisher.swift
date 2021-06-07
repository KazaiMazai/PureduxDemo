//
//  KeyboardHeightPublisher.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import Foundation
import SwiftUI
import Combine

struct KeyboardPresentation {
    internal init(isPresented: Bool, height: CGFloat, duration: Double, curve: Int) {
        self.isPresented = isPresented
        self.height = height
        self.duration = duration

        let animationCurve = UIView.AnimationCurve(rawValue: curve) ?? .easeInOut
        switch animationCurve {
        case .easeInOut:
            animation = .easeInOut(duration: duration)
        case .easeIn:
            animation = .easeIn(duration: duration)
        case .easeOut:
            animation = .easeOut(duration: duration)
        case .linear:
            animation = .linear(duration: duration)
        @unknown default:
            animation = .easeInOut(duration: duration)
        }

    }

    let isPresented: Bool
    let height: CGFloat
    let animation: Animation
    let duration: Double
}

extension Publishers {
    static var keyboardPresentation: AnyPublisher<KeyboardPresentation, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { KeyboardPresentation(isPresented: true,
                                  height: $0.keyboardHeight,
                                  duration: $0.animationDuration,
                                  curve: $0.animationCurve) }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { KeyboardPresentation(isPresented: false,
                                  height: $0.keyboardHeight,
                                  duration: $0.animationDuration,
                                  curve: $0.animationCurve)  }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }

    static var keyboardVisible: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in true }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in false }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }

    var animationDuration: Double {
        return (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
    }

    var animationCurve: Int {
        return (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int) ?? 0
    }
}
