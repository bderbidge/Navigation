//
//  NavigationApp.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/21/24.
//

import SwiftUI

struct NavAppContainer: RouterContainer {
    var dependencyContainer: DependencyContainer
}

struct BaseContainer {
    let appRouter: AppRouter
    let routerContainer: NavAppContainer
    
    init() {
        self.routerContainer = .init(dependencyContainer: .init())
        self.appRouter = AppRouter(tabControllers: MainNavigationTab.tabs(container: routerContainer))
    }
}

@main
struct NavigationApp: App {
    let baseContainer = BaseContainer()
    
    var body: some Scene {
        WindowGroup {
            TabViewContainer<AppRouter>(isUiKit: false, appRouter: baseContainer.appRouter)
        }
    }
}


