//
//  AppRouter.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import Combine

/// A router for managing the navigation of an app with multiple tabs
class AppRouter: AppTabRouter {
    
    var activeTabPublisher: AnyPublisher<Int, Never>
    private var activeTabSubject: CurrentValueSubject<Int, Never>
    
    /// The maximum number of redirects to follow when routing
    let maxRedirects = 5
    
    /// The list of tab controllers in the app
    public var tabControllers: [any TabCoordinator]

    /// Initializes the router with the given tab controllers
    ///
    /// - Parameter tabControllers: The tab controllers to use in the app
    public init?(tabControllers: [any TabCoordinator]) {
        guard !tabControllers.isEmpty else { return nil }
        self.tabControllers = tabControllers
        self.activeTabSubject = CurrentValueSubject(1)
        self.activeTabPublisher = activeTabSubject.eraseToAnyPublisher()
    }
    
    /// Finds the tab controller for the given tab
    ///
    /// - Parameter tab: The tab to find the controller for
    /// - Returns: The tab controller for the given tab, or nil if not found
    private func tabController(for tab: any TabCoordinator) -> (any TabCoordinator)? {
        tabControllers.first(where: { $0.rawValue == tab.rawValue})
    }
    
    /// Routes to the given path
    ///
    /// - Parameters:
    ///   - navigationPath: The navigation path to route to
    ///   - shouldPopToRoot: Whether to pop to the root view controller before navigating
    ///   - shouldUpdateUI: Whether to update the UI after navigating
    ///   - animated: Whether to animate the navigation
    public func route(navigationPath: some NavigationDestination, shouldPopToRoot: Bool = false, shouldUpdateUI: Bool = false, animated: Bool = true) {
        let path = redirectPath(for: navigationPath.rawValue)
        executeRoute(path, animated: animated)
    }
    
    /// Follows redirects for the given path up to a maximum number of times
    ///
    /// - Parameter path: The path to follow redirects for
    /// - Returns: The final path after following redirects
    private func redirectPath(for path: String) -> String {
        var result = path
        
        for i in 1...maxRedirects {
            var newPath: String?
            
            for tabController in tabControllers {
                guard let redirectPath = tabController.navigationRouter.redirectPath(for: result) else { continue }
                newPath = redirectPath
                break
            }
            
            if let newPath = newPath, newPath != result  {
                result = newPath
                
                if i == maxRedirects {
                    // log something here about max redirects for router
                }
            } else {
                break
            }
        }
        
        return result
    }

    /// Executes the route for the given path
    ///
    /// - Parameters:
    ///   - path: The path to execute the route for
    ///   - shouldPopToRoot: Whether to pop to the root view controller before navigating
    ///   - shouldUpdateUI: Whether to update the UI after navigating
    ///   - animated: Whether to animate the navigation
    // Show the right tab and then navigate to the correct route
    private func executeRoute(_ path: String, popToRoot: Bool = false, shouldUpdateSidebar: Bool = false, animated: Bool = false) {
        guard let controller = tabControllers.first(where: {$0.navigationRouter.canRoute(navigationPathString: path)}) else { return }
        
        showTab(controller, shouldPopToRoot: popToRoot, animated: animated) {
            controller.navigationRouter.route(path: path)
        }
    }
    
    /// Shows the given tab
    ///
    /// - Parameters:
    ///   - tab: The tab to show
    ///   - shouldPopToRoot: Whether to pop to the root view controller before navigating
    ///   - animated: Whether to animate the navigation
    public func showTab(_ tab: any TabCoordinator, shouldPopToRoot: Bool = false, animated: Bool = false) {
        guard let controller = tabController(for: tab) else { return }
        showTab(controller, shouldPopToRoot: shouldPopToRoot, animated: animated)
    }
    
    /// Shows the given tab controller
    ///
    /// - Parameters:
    ///   - controller: The tab controller to show
    ///   - shouldPopToRoot: Whether to pop to the root view controller before navigating
    ///   - animated: Whether to animate the navigation
    ///   - completion: A completion block to call after showing the tab
    private func showTab(_ controller: any TabCoordinator, shouldPopToRoot: Bool = false, animated: Bool = false, completion: (()-> Void)? = nil) {
        setTab(controller)
        if shouldPopToRoot {
            controller.navigationRouter.popToRoot()
        }
        
        if let completion = completion {
            completion()
        }
    }
    
    /// Sets the active tab
    ///
    /// - Parameter tab: The tab to set as active
    public func setTab(_ tab: any TabCoordinator) {
        let index = tabControllers.firstIndex(where: {
            $0.rawValue == tab.rawValue
        })
        if let index = index {
            activeTabSubject.send(index+1)
        }
    }
}
