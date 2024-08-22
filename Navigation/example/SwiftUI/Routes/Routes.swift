//
//  routes.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import SwiftUI

enum HomeRoutes: NavigationDestinationView {
    static func routes(container: any RouterContainer) -> [HomeRoutes] {
        guard let depContainer = container as? NavAppContainer else { return [] }
        return [.home(depContainer.dependencyContainer), .stuff]
    }
    

    var prefix: String {
        "home"
    }
    
    case home(DependencyContainer)
    case stuff
    
    var rawValue: String {
        switch self {
        case .home:
            "home"
        case .stuff:
            "stuff"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home(let container):
            FirstRouteView(viewModel: .init(container: container))
        case .stuff:
            Text("Hey this is home stuff")
        }
    }
}

enum AccountRoutes: NavigationDestinationView {
    static func routes(container: any RouterContainer) -> [AccountRoutes] {
        [.home, .stuff]
    }
    
    var prefix: String {
        "account"
    }
    
    case home
    case stuff
    
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
        case .home:
            Text("Account Home")
        case .stuff:
            Text("Hey This is account stuff")
        }
    }
}
