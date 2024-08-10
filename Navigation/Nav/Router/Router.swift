//
//  Router.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

protocol Router {
    associatedtype Nav: NavigationDestination
    func redirectPath(for navigationPath: Nav) -> String?
    func redirectPath(for navigationPath: String) -> String?
    func canRoute(navigationPath: Nav) -> Bool
    func canRoute(navigationPathString: String) -> Bool
    func popToRoot()
    func route(navigationPath: Nav)
    func route(path: String)
}

protocol SwiftUIRouterR: Router, ObservableObject {
    associatedtype Navigation: NavigationDestinationView
    var pathPublisher: Published<[Navigation]>.Publisher { get }
}

class SwiftUIRouter<Navigation: NavigationDestinationView>: SwiftUIRouterR {
    
    @Published var path = [Navigation]()
    var pathPublisher: Published<[Navigation]>.Publisher {
        $path
    }
    
    func redirectPath(for navigationPath: Navigation) -> String? {
        nil
    }
    
    func canRoute(navigationPath: Navigation) -> Bool {
        true
    }
    
    func route(navigationPath: Navigation) {
        path.append(navigationPath)
    }
    
    func redirectPath(for navigationPath: String) -> String? {
        nil
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func canRoute(navigationPathString: String) -> Bool {
        Navigation.routes.contains(where: {
            $0.rawValue == navigationPathString
        })
    }
    
    func route(path: String) {
        guard let route = Navigation.routes.first(where: { $0.rawValue == path }) else {
            return
        }
        self.path.append(route)
    }
}

class UIKitRouter: Router {
    func redirectPath(for navigationPath: some NavigationDestination) -> String? {
        nil
    }
    
    func canRoute(navigationPath: some NavigationDestination) -> Bool {
        true
    }
    
    func route(navigationPath: some NavigationDestination) {
    }
    
    var navigationController: UINavigationController? = nil
    
    func popToRoot() {
    }
    
    func canRoute(navigationPathString: String) -> Bool {
        true
    }
    
    func canRoute(navigationPath: UIViewController) -> Bool {
        true
    }
    
    func redirectPath(for navigationPath: String) -> String? {
        nil
    }
    
    func redirectPath(for navigationPath: UIViewController) -> String? {
        nil
    }
    
    func route(navigationPath: UIViewController) {
        navigationController?.pushViewController(navigationPath, animated: true)
    }
    
    func route(path: String) {
    }
}
