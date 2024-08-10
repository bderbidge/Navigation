//
//  routes.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import SwiftUI

enum HomeRoutes: NavigationDestinationView {
    var prefix: String {
        "home"
    }
    
    static var routes: [HomeRoutes] = [.home, .stuff]
    
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
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            FirstRouteView(viewModel: .init())
        case .stuff:
            Text("Hey this is home stuff")
        }
    }
}

enum AccountRoutes: NavigationDestinationView {
    var prefix: String {
        "account"
    }
    
    static var routes: [AccountRoutes] = [.home, .stuff]
    
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
