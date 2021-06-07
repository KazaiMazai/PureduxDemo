//
//  ActionButton.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 07.06.2021.
//

import SwiftUI

extension ActionButton {
    struct Props {
        let title: String
        let state: State

        init(title: String, state: State) {
            self.title = title
            self.state = state
        }

        var action: Command {
            state.action
        }

        var isEnabled: Bool {
            state.isEnabled
        }

        var isInProtgress: Bool {
            state.isInProgress
        }

        static var preview: Props {
            Props(title: "Button Title", state: .enabled(nop))
        }
    }
}

extension ActionButton {
    struct Style {
        let titleFont: Font
        let titleColor: Color
        let backgroundColor: Color
        let backgroundDisabledColor: Color
        let cornerRadius: CGFloat
        let height: CGFloat
        let maxWidth: CGFloat

        static var defaulStyle: Style {
            Style(titleFont: .title,
                  titleColor: .black,
                  backgroundColor: .blue,
                  backgroundDisabledColor: .gray,
                  cornerRadius: 8,
                  height: 52,
                  maxWidth: .infinity)
        }
    }
}

struct ActionButton: View {
    let props: Props
    let style: Style

    var body: some View {
        Button(action: props.action) {
            Text(props.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(style.titleFont)
                .foregroundColor(style.titleColor)
        }
        .frame(height: style.height, alignment: .center)
        .background(props.isEnabled ? style.backgroundColor: style.backgroundDisabledColor)
        .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
    }
}

struct MainActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(props: .preview, style: .defaulStyle)
    }
}

extension ActionButton.Props {
    enum State {
        case disabled
        case enabled(Command)
        case inProgress

        init(isInProgress: Bool, isEnabled: Bool, action: @escaping Command) {
            if isInProgress {
                self = .inProgress
                return
            }

            guard isEnabled else {
                self = .disabled
                return
            }

            self = .enabled(action)
        }

        var isEnabled: Bool {
            guard case .enabled = self else {
                return false
            }

            return true
        }

        var isInProgress: Bool {
            guard case .inProgress = self else {
                return false
            }

            return true
        }

        var action: Command {
            guard case let .enabled(command) = self else {
                return nop
            }

            return command
        }
    }
}
