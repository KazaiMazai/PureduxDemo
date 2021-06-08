//
//  AuthSecuredTextField.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 03.06.2021.
//

import SwiftUI

extension AuthSecuredTextField {
    struct Props: Hashable, Equatable {
        @Binding var binding: String
        let placeholder: String

        init(binding: Binding<String>,
             placeholder: String) {
            self._binding = binding
            self.placeholder = placeholder
        }

        static var preview: Props {
            Props(
                binding: .constant(""),
                placeholder: "TextField")
        }

        static func == (lhs: AuthSecuredTextField.Props, rhs: AuthSecuredTextField.Props) -> Bool {
            lhs.binding == rhs.binding && lhs.placeholder == rhs.placeholder
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(binding)
            hasher.combine(placeholder)
        }
    }
}

extension AuthSecuredTextField {
    struct Style {
        var keyboardType: UIKeyboardType = .default
        var alignment: TextAlignment = .center
        var titleFont: AppUITheme.FontType = .title

        var borderColor: Color = .gray
        var borderColorFocused: Color = .blue
        var placehodlerColor: Color = .gray
        var titleColor: AppUITheme.ColorType = .black
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

        fileprivate var textAlignment: NSTextAlignment {
            switch alignment {
            case .leading:
                return .left
            case .center:
                return.center
            case .trailing:
                return .right
            }
        }
    }
}

struct AuthSecuredTextField: View {
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
        CustomTextField(
            text: props.$binding,
            onEditingChanged: { isEditing = $0 },
            modifier: {
                $0.borderStyle = .none
                $0.textColor = style.titleColor.uiColor
                $0.font = style.titleFont.uiFont
                $0.keyboardType = style.keyboardType
                $0.textAlignment = style.textAlignment
                $0.isSecureTextEntry = true
            })
            .placeHolder(Text(props.placeholder)
                            .multilineTextAlignment(style.alignment)
                            .font(style.titleFont.font)
                            .foregroundColor(style.placehodlerColor),
                         alignment: style.placeholderAlignment,
                         show: props.$binding.wrappedValue.isEmpty && !isEditing)
            .padding(.horizontal, style.horizontalPadding)

            .frame(height: style.height)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .stroke(isEditing ?
                                style.borderColorFocused
                                : style.borderColor,
                            lineWidth: style.borderWidth))
         
    }
}

struct AuthSecuredTextField_Previews: PreviewProvider {
    static var previews: some View {
        AuthSecuredTextField(props: .preview, style: AuthSecuredTextField.Style())
    }
}
