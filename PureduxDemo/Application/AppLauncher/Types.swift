//
//  Types.swift
//  BETest
//
//  Created by Sergey Kazakov on 02.12.2020.
//

import SwiftUI
import PureduxStore
import PureduxSideEffects
import PureduxSwiftUI
import PureduxCommon
import PureduxCommonOperators

typealias ObservableStore = PureduxSwiftUI.ObservableStore
typealias Store = PureduxStore.Store<AppState, Action>
typealias Observer = PureduxStore.Observer<AppState>
typealias Middleware<Operator> =
    PureduxSideEffects.Middleware<AppState, Action, Operator> where Operator: OperatorProtocol

typealias TimeEventsOperator = PureduxCommonOperators.TimeEventsOperator

typealias Logger = PureduxSideEffects.Logger
typealias Loglevel = PureduxSideEffects.LogLevel
typealias ConsoleLogger = PureduxSideEffects.Logger

typealias PresentableView = PureduxSwiftUI.PresentableView 
typealias Equating<T> = PureduxCommon.Equating<T>
typealias StoreProvidingView<Content: View> = PureduxSwiftUI.StoreProvidingView<AppState, Action, Content>

