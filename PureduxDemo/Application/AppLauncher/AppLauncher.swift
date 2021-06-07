//
//  AppDI.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import SwiftUI

struct AppLauncher {
    private let theme: AppUITheme
    private let screenViewsFactory: ScreenViewsFactory
    private let environmentStore: ObservableStore<AppState, Action>
    private let store: Store
    private let appStateEnvironment: AppEnvironment
    private let appStateConfig: AppStateConfig

    private let timeEvents: Middleware<TimeEventsOperator>

    init() {
        let env = AppEnvironment.defaultAppEnvironment()
        let config = AppStateConfig.defaultConfig()
        let initialState = AppState.createStateWith(config: config, env: env)
        let reducerLogger: Logger = .with(label: "Reducer", logger: .console(.debug))

        store = Store(initial: initialState) { state, action in
            reducerLogger.log(.debug, "\(String(reflecting: action))")
            state.reduce(action, env: env)
        }

        environmentStore = ObservableStore(store: store)
        appStateEnvironment = env
        appStateConfig = config
        theme = AppUITheme.defaultTheme
        screenViewsFactory = ScreenViewsFactory.defaultScreenViewsFactory

        timeEvents = Middleware(
            store: store,
            operator: TimeEventsOperator(
                label: "TimeEvents Operator",
                qos: .background,
                logger: .console(.silent)),
            sideEffects: TimeEventsSideEffects().sideEffects())
    }
}

extension AppLauncher {
    func launchUIWith(scene: UIScene) -> UIWindow? {
        guard let windowScene = scene as? UIWindowScene else {
            return nil
        }

        let window = UIWindow(windowScene: windowScene)
        let rootView = rootViewWith(view: screenViewsFactory.makeView(for: .login))
        window.rootViewController = DarkHostingController(rootView: rootView)
        return window
    }

    func run() {
        subscribeToStore()
    }
}

private extension AppLauncher {
    func subscribeToStore() {
        store.subscribe(observer: timeEvents.asObserver)
    }

    func rootViewWith<V: View>(view: V) -> some View {
        StoreProvidingView(store: environmentStore) {
            view.environment(\.appUITheme, theme)
                .environment(\.screenViewsFactory, self.screenViewsFactory)
        }
    }
}
