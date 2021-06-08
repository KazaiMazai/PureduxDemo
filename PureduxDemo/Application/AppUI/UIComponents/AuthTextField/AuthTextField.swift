//
//  AuthTextField.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import SwiftUI

extension AuthTextField {
    struct Props: Hashable, Equatable {
        @Binding var binding: String
        let placeholder: String

        init(binding: Binding<String>,
             placeholder: String) {
            self._binding = binding
            self.placeholder = placeholder
        }

        static var preview: Props {
            Props(binding: .constant(""),
                  placeholder: "TextField")
        }

        static func == (lhs: AuthTextField.Props, rhs: AuthTextField.Props) -> Bool {
            lhs.binding == rhs.binding && lhs.placeholder == rhs.placeholder
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(binding)
            hasher.combine(placeholder)
        }
    }
}

extension AuthTextField {
    struct Style {
        var keyboardType: UIKeyboardType = .default
        var alignment: TextAlignment = .center
        var titleFont: Font = .title

        var borderColor: Color = .gray
        var borderColorFocused: Color = .blue
        var placehodlerColor: Color = .gray
        var titleColor: Color = .black
        var backgroundColor: Color = .white

        var height: CGFloat = 52
        var cornerRadius: CGFloat = 8

        var borderWidth: CGFloat = 1
        var horizontalPadding: CGFloat = 16

        fileprivate var placeholderAlignment: Alignment {
            switch alignment {
            case .leading:
                return .leading
            case .center:
                return.center
            case .trailing:
                return .trailing
            }
        }
    }
}

struct AuthTextField: View {
    let props: Props
    let style: Style

    @State private var borderColor: Color = .clear
    @State private var isEditing: Bool = false

    init(props: Props, style: Style) {
        self.props = props
        self.style = style
        borderColor = style.borderColor
    }

    var body: some View {
        TextField("",
                  text: props.$binding,
                  onEditingChanged: { isEditing = $0 })
            .placeHolder(
                Text(props.placeholder)
                    .multilineTextAlignment(style.alignment)
                    .font(style.titleFont)
                    .foregroundColor(style.placehodlerColor),
                alignment: style.placeholderAlignment,
                show: props.$binding.wrappedValue.isEmpty && !isEditing)
            .padding(.horizontal, style.horizontalPadding)
            .multilineTextAlignment(style.alignment)
            .keyboardType(style.keyboardType)
            .font(style.titleFont)
            .foregroundColor(style.titleColor)
            .frame(height: style.height)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius,
                                 style: .continuous)
                    .stroke(isEditing ?
                                style.borderColorFocused
                                : style.borderColor,
                            lineWidth: style.borderWidth)
            )
    }
}

struct AuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        AuthTextField(props: .preview, style: AuthTextField.Style())
    }
}
