//
//  Alert+Props.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import SwiftUI

extension Alert {
    struct Props {
        let title: String
        let message: String
        let dismiss: String

        static var preview: Props {
            Props(
                title: "Error",
                message: "Some message",
                dismiss: "Ok")
        }

        static var none: Props {
            Props(
                title: "",
                message: "",
                dismiss: "")
        }
    }

    init(props: Props) {
        self.init(
            title: Text(props.title),
            message: Text(props.message),
            dismissButton: .default(Text(props.dismiss)))
    }
}
