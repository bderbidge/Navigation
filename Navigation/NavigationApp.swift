//
//  NavigationApp.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/21/24.
//

import SwiftUI

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            TabViewContainer<MainNavigationTab>(isSwiftui: true)
        }
    }
}
