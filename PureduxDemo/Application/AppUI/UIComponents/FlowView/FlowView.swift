//
//  FlowView.swift
//  PureduxDemo
//
//  Created by Sergey Kazakov on 08.06.2021.
//

import SwiftUI

extension FlowView {
    struct Props<First: View, Second: View> {
        let presentFirst: Bool

        let first: () -> First
        let second: () -> Second
    }
}

struct FlowView<First: View, Second: View>: View {
    let props: Props<First, Second>
 
    var body: some View {
        ZStack {
            if props.presentFirst {
                props.first()
            } else {
                props.second()
            }
        }
    }
}

struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlowView(props: FlowView.Props(
                        presentFirst: true,
                        first: { Color.red },
                        second: { Color.green })
            )

            FlowView(props: FlowView.Props(
                        presentFirst: false,
                        first: { Color.red },
                        second: { Color.green })
            )

        }
    }
}
