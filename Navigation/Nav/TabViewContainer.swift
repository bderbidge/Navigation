//
//  TopView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import SwiftUI

struct TabViewContainer<Tabs: TabCoordinator>: View {
    let isSwiftui: Bool
    var body: some View {
        Group {
            if let router = AppRouter(tabControllers: Tabs.tabs) {
                if isSwiftui {
                    TabViewCoordinator(appRouter: router)
                } else {
                    MainTabBarView(appRouter: router)
                }
            } else {
                ProgressView()
            }
        }
    }
}
