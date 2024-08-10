//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/5/24.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class MainTabBarViewModel {
    private let appRouter: AppRouter
    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }
    
    var tabs: [any TabCoordinator] {
        appRouter.tabControllers
    }
    
    var activeTabPublisher: AnyPublisher<Int, Never> {
        appRouter.activeTabPublisher
    }
}

struct MainTabBarView: UIViewControllerRepresentable {
    let appRouter: AppRouter
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = MainTabBarController(viewModel: .init(appRouter: appRouter))
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class MainTabBarController: UITabBarController {
    let viewModel: MainTabBarViewModel
    var cancelables = Set<AnyCancellable>()
    
    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var viewcontrollers = [UIViewController]()
        for index in viewModel.tabs.indices {
            let coordinator = viewModel.tabs[index]
            if let tab = coordinator as? SwiftUITabCoordinator, let view = tab.tabView {
                let vc = UIHostingController(rootView: AnyView(view))
                vc.tabBarItem = UITabBarItem(title: tab.name, image: UIImage(systemName: tab.imageName), tag: index)
                viewcontrollers.append(vc)
            } else if let tab = coordinator as? UIKitTabCoordinator, let router = tab.router, let coordinator = tab.tabCoordinator {
                let vc = UINavigationController(rootViewController: coordinator.start())
                router.navigationController = vc
                vc.tabBarItem = UITabBarItem(title: tab.name, image: UIImage(systemName: tab.imageName), tag: index)
                viewcontrollers.append(vc)
            }
           
        }
        viewControllers = viewcontrollers
        viewModel.activeTabPublisher.sink {[weak self] value in
            guard let self else { return }
            selectedIndex = value
        }.store(in: &cancelables)
    }
}
