//
//  File.swift
//
//
//  Created by Brandon Derbidge on 5/30/23.
//

import Foundation
import SwiftUI

/// A protocol for defining a tab in the app
protocol TabCoordinator {
    var rawValue: String { get }
    var name: String { get }
    var imageName: String { get }
    var navigationRouter: any Router { get }
    static var tabs: [Self] { get }
}

protocol SwiftUITabCoordinator: TabCoordinator {
    var tabView: (any TabCoordinatorView)? { get }
}

protocol UIKitTabCoordinator: TabCoordinator {
    var tabCoordinator: (any SwiftUIToUIKitCoordinator)?{ get }
    var router: UIKitRouter? { get }
}
