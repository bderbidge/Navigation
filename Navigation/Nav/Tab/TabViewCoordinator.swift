//
//  TabViewContainer.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import SwiftUI
import Combine

struct TabViewCoordinator<AppRouter: AppTabRouter>: View {
    @ObservedObject var appRouter: AppRouter
    @State private var selectedTabID: Int?

    public var body: some View {
        TabView(selection: $selectedTabID) {
            ForEach(appRouter.tabControllers, id: \.rawValue) { tab in
                controllerBuilder(coordinator: tab)
            }
        }
        .environmentObject(appRouter)
        .onReceive(appRouter.activeTabPublisher) { newActiveTab in
            selectedTabID = newActiveTab
        }
    }
    
    @ViewBuilder
    func controllerBuilder(coordinator: any TabCoordinator) -> some View {
        Group {
            if let tabView = coordinator as? SwiftUITabCoordinator, let tabView = tabView.tabView {
                AnyView(tabView) 
            } else if let uikit = coordinator as? UIKitTabCoordinator, let router = coordinator.navigationRouter as? UIKitRouter, let tabCoordinator = uikit.tabCoordinator {
                HostingVCCoordinator(coordinator: tabCoordinator, router: router)
            } else {
                EmptyView()
            }
        }.tabItem {
            Label(coordinator.name, systemImage: coordinator.imageName)
        }
        .tag(0)
    }
}

