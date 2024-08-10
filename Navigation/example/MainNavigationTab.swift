//
//  MainNavigationTab.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import SwiftUI

enum MainNavigationTab: TabCoordinator {
    case home(SwiftUIRouter<HomeRoutes>)
    case account(SwiftUIRouter<AccountRoutes>)
    case content(UIKitRouter)
    
    static var tabs: [MainNavigationTab] {
        [.home(SwiftUIRouter<HomeRoutes>()), .account(SwiftUIRouter<AccountRoutes>()), .content(UIKitRouter())]
    }
    
    var rawValue: String {
        switch self {
        case .home:
            "home"
        case .account:
            "person"
        case .content:
            "content"
        }
    }
    
    var name: String {
        switch self {
        case .home:
            "Home"
        case .account:
            "Account"
        case .content:
            "Content"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            "house"
        case .account:
            "person"
        case .content:
            "content"
        }
    }
    
    var navigationRouter: any Router {
        switch self {
        case .home(let router):
            router
        case .account(let router):
            router
        case .content(let router):
            router
        }
    }

    var tabView: NavType {
        switch self {
        case .home(let router):
                .swiftui(TabCoordinatorViewImp(name: name, tabContent: ContentView(viewModel: .init()), router: router))
        case .account(let router):
                .swiftui(TabCoordinatorViewImp(name: name, tabContent: SecondTab(viewModel: .init()), router: router))
        case .content(let router):
                .uikit(ScreenCoordinator(router: router), router)
        }
    }
}
