//
//  routes.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import SwiftUI

enum HomeRoutes: NavigationDestinationView {
    
    static func routes(container: any RouterContainer, router: SwiftUIRouter<HomeRoutes>) -> [HomeRoutes] {
        guard let depContainer = container as? NavAppContainer else { return [] }
        return [.home(depContainer.dependencyContainer, router), .stuff(depContainer.dependencyContainer, router)]
    }

    var prefix: String {
        "home"
    }
    
    case home(DependencyContainer, SwiftUIRouter<HomeRoutes>)
    case stuff(DependencyContainer, SwiftUIRouter<HomeRoutes>)
    
    var rawValue: String {
        switch self {
        case .home:
            "home"
        case .stuff:
            "stuff"
        }
    }
    
    var view: some View {
        switch self {
        case let  .home(container, router):
            FirstRouteView(viewModel: .init(container: container), router: router)
        case .stuff(let container, _):
            SecondRouteView(viewModel: .init(container: container))
        }
    }
}

enum AccountRoutes: NavigationDestinationView {
    
    static func routes(container: any RouterContainer, router: SwiftUIRouter<AccountRoutes>) -> [AccountRoutes] {
        [.home(router), .stuff(router)]
    }
    
    var prefix: String {
        "account"
    }
    
    case home(SwiftUIRouter<AccountRoutes>)
    case stuff(SwiftUIRouter<AccountRoutes>)
    
    var rawValue: String {
        switch self {
        case .home:
            "home"
        case .stuff:
            "stuff"
        }
    }
    
    var view: some View {
        switch self {
        case .home(let router):
            SecondTabFirstRoute(viewModel: .init(), router: router)
        case .stuff(let router):
            StuffView(viewModel: .init(), router: router)
        }
    }
}
