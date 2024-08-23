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

protocol RouterContainer {
}

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

class SwiftUIRouter<Navigation: NavigationDestinationView>: Router, ObservableObject {
    var registeredRoutes: [String: Navigation] = [:]
    
    init(container: RouterContainer) {
        let registerdRoutes = Navigation.routes(container: container, router: self)
        self.registeredRoutes = Dictionary(uniqueKeysWithValues: registerdRoutes.map{ ($0.path, $0) })
    }
    
    @Published var path = [Navigation]()
    var pathPublisher: Published<[Navigation]>.Publisher {
        $path
    }
    
    func redirectPath(for navigationPath: Navigation) -> String? {
        nil
    }
    
    func canRoute(navigationPath: Navigation) -> Bool {
        (registeredRoutes[navigationPath.path] != nil)
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
        (registeredRoutes[navigationPathString] != nil)
    }
    
    func route(path: String) {
        guard let route = registeredRoutes[path] else {
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
