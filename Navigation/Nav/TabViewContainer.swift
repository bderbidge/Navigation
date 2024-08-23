//
//  TopView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import SwiftUI

struct TabViewContainer<AppRouter: AppTabRouter>: View {
    let isUiKit: Bool
    let appRouter: AppRouter
    
    var body: some View {
        Group {
            if isUiKit {
                MainTabBarView(appRouter: appRouter)
            } else {
                TabViewCoordinator(appRouter: appRouter)
            }
        }
    }
}
