//
//  CustomTextField.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import UIKit
import SwiftUI

struct CustomTextField: UIViewRepresentable {
    @Binding private var text: String

    private let editingChanged: (Bool) -> Void
    private let commit: () -> Bool
    private let modifier: (UITextField) -> Void

    init(text: Binding<String>,
         onEditingChanged: @escaping (Bool) -> Void = { _ in },
         commit: @escaping () -> Bool = { false },
         modifier: @escaping (UITextField) -> Void = { _ in }) {

        self.editingChanged = onEditingChanged
        self.commit = commit
        self._text = text
        self.modifier = modifier
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        let coordinator = context.coordinator
        textField.delegate = coordinator
        textField.addTarget(
            coordinator,
            action: #selector(Coordinator.textFieldDidChange),
            for: .editingChanged)
        modifier(textField)
        return textField
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(textChanged: { text = $0 },
                    editingChanged: self.editingChanged,
                    commit: self.commit)
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        modifier(uiView)
    }
}

extension CustomTextField {
    class Coordinator: NSObject, UITextFieldDelegate {
        let textChanged: (String) -> Void
        let editingChanged: (Bool) -> Void
        let commit: () -> Bool

        init(textChanged: @escaping (String) -> Void,
             editingChanged: @escaping (Bool) -> Void,
             commit: @escaping () -> Bool) {

            self.textChanged = textChanged
            self.editingChanged = editingChanged
            self.commit = commit
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            editingChanged(false)
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            editingChanged(true)
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            commit()
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            textChanged(textField.text ?? "")
        }
    }
}
