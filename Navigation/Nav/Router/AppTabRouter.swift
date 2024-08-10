//
//  AppRouter.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import Combine

protocol AppTabRouter: ObservableObject { 
    
    var tabControllers: [any TabCoordinator] { get }
    var activeTabPublisher: AnyPublisher<Int, Never> { get set }
    
    func route(navigationPath: some NavigationDestination, shouldPopToRoot: Bool, shouldUpdateUI: Bool, animated: Bool)
}
