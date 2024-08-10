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
    @State private var selectedTabID = 1

    public var body: some View {
        TabView(selection: $selectedTabID) {
            ForEach(0..<appRouter.tabControllers.count, id: \.self) { index in
                controllerBuilder(coordinator: appRouter.tabControllers[index], index: index+1)
            }
            .onReceive(appRouter.activeTabPublisher) { newActiveTab in
                selectedTabID = newActiveTab
            }
        }
        .environmentObject(appRouter)
       
    }
    
    @ViewBuilder
    func controllerBuilder(coordinator: any TabCoordinator, index: Int) -> some View {
        Group {
            switch coordinator.tabView {
            case .swiftui(let tabCoordinatorView):
                AnyView(tabCoordinatorView)
            case .uikit(let swiftUIToUIKitCoordinator, let router):
                HostingVCCoordinator(coordinator: swiftUIToUIKitCoordinator, router: router)
            }
        }.tabItem {
            Label(coordinator.name, systemImage: coordinator.imageName)
        }
        .tag(index)
    }
}

