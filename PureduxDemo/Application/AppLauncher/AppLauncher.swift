//
//  AppDI.swift
//  BETest
//
//  Created by Sergey Kazakov on 01.10.2020.
//

import SwiftUI
import PureduxSideEffects
import PureduxSwiftUI
import PureduxStore
import PureduxCommonOperators
import PureduxNetworkOperator

struct AppLauncher {
    private let theme: AppUITheme
    private let screenViewsFactory: ScreenViewsFactory
    private let environmentStore: ObservableStore<AppState, Action>
    private let store: Store<AppState, Action>
    private let appStateEnvironment: AppEnvironment
    private let appStateConfig: AppStateConfig

    private let timeEvents: Middleware<AppState, Action, TimeEventsOperator>
    private let network: Middleware<AppState, Action, NetworkOperator>

    private let logger: Logger
    private let client: Client

    init() {
        let env = AppEnvironment.defaultAppEnvironment()
        let config = AppStateConfig.defaultConfig()
        let initialState = AppState.createStateWith(config: config, env: env)

        let logLevel = LogLevel.debug
        let reducerLogger: Logger = .with(label: "Reducer", logger: .console(logLevel))
        let actionsLogger = ActionsLogger(logger: reducerLogger)
        logger = .console(logLevel)
        
        store = Store(initial: initialState) { state, action in
            actionsLogger.log(action: action)
            state.reduce(action, env: env)
        }

        environmentStore = ObservableStore(store: store)
        appStateEnvironment = env
        appStateConfig = config
        theme = AppUITheme.defaultTheme
        screenViewsFactory = ScreenViewsFactory.defaultScreenViewsFactory

        client = Client(
            baseURL: URL(string: "https://api.themoviedb.org/3/")!,
            apiKey: "37347f4b1c7ebd6c41b60e3e539d4a60")

        timeEvents = Middleware(
            store: store,
            operator: TimeEventsOperator(
                label: "TimeEvents",
                qos: .background,
                logger: .with(logLevel: .silent,
                              logger: logger)),
            sideEffects: TimeEventsSideEffects().effects)

        network = Middleware(
            store: store,
            operator: NetworkOperator(
                label: "Network",
                logger: .with(logLevel: .trace,
                              logger: logger)),
            sideEffects: [
                AuthSideEffects(client: client).effects

            ].flatten())
    }
}

extension AppLauncher {
    func launchUIWith(scene: UIScene) -> UIWindow? {
        guard let windowScene = scene as? UIWindowScene else {
            return nil
        }

        let window = UIWindow(windowScene: windowScene)
        let rootView = rootViewWith(view: screenViewsFactory.makeView(for: .root))
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
        store.subscribe(observer: network.asObserver)
    }

    func rootViewWith<V: View>(view: V) -> some View {
        StoreProvidingView(store: environmentStore) {
            view.environment(\.appUITheme, theme)
                .environment(\.screenViewsFactory, self.screenViewsFactory)
        }
    }
}
