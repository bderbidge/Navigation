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

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            TabViewContainer<MainNavigationTab>(isUiKit: false, container: NavAppContainer(dependencyContainer: .init()))
        }
    }
}
