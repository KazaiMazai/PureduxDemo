//
//  File.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import SwiftUI
import PureduxSwiftUI

extension ViewStore {
    func dispatching(_ action: Action) -> Command {
        return {
            self.dispatch(action)
        }
    }

    func dispatching<T>(_ action: @escaping (T) -> Action) -> CommandWith<T> {
        return { value in
            self.dispatch(action(value))
        }
    }
}
