//
//  TopView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import SwiftUI

struct TabViewContainer<Tabs: TabCoordinator>: View {
    let isUiKit: Bool
    let container: RouterContainer
    var body: some View {
        Group {
            if let router = AppRouter(tabControllers: Tabs.tabs(container: container)) {
                if isUiKit {
                    MainTabBarView(appRouter: router)
                } else {
                    TabViewCoordinator(appRouter: router)
                }
            } else {
                ProgressView()
            }
        }
    }
}
