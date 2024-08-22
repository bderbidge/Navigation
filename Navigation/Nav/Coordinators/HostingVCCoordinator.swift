//
//  HostingVCCoordinator.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/22/24.
//

import Foundation
import UIKit
import SwiftUI

protocol SwiftUIToUIKitCoordinator: Coordinator where R == UIKitRouter {
    func start() -> UIViewController
}

struct HostingVCCoordinator: UIViewControllerRepresentable {
    var coordinator: any SwiftUIToUIKitCoordinator
    var router: UIKitRouter
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: coordinator.start())
        router.navigationController = navigationController
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Update the UINavigationController if needed
    }
}
