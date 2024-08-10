//
//  Coordinator.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

protocol Coordinator {
    associatedtype R: Router
    var router: R { get }
    func start()
}

extension Coordinator {
    func start() {}
}

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

protocol BaseCoordinatorView: View, Coordinator  {
    associatedtype Router: SwiftUIRouterR
    var router: Router { get }
}

protocol CoordinatorView: BaseCoordinatorView where Router == SwiftUIRouter<Nav> {
    associatedtype Nav: NavigationDestinationView
    var router: SwiftUIRouter<Nav> { get }
    
    associatedtype Content: View
    var content: Content { get }
    
    associatedtype VM: ViewModelNavigation
    var viewModel: VM { get }
    func start(output: VM.Output)
}

extension CoordinatorView {
    var body: some View {
        Group {
            content
        }
        .onReceive(viewModel.coordinatorOutput) { output in
            guard let output = output else { return }
            start(output: output)
        }
        .navigationDestination(for: Nav.self) { value in
            value.view
        }
    }
}
