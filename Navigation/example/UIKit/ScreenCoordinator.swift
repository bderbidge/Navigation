//
//  ScreenCoordinator.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import UIKit
import Combine

class ScreenCoordinator: SwiftUIToUIKitCoordinator {
    var router: UIKitRouter
    var cancelable = Set<AnyCancellable>()
    
    init(router: UIKitRouter) {
        self.router = router
    }
    
    func start() -> UIViewController {
        let vm = MyViewModel()
        let vc = MyViewController(vm: vm)
        vm.coordinatorOutput.sink {[weak self] value in
            guard let self else { return }
            switch value {
            case .detail:
                let coordinator = NavigateCoordinator(router: router)
                coordinator.start()
            case .none:
                break
            }
        }.store(in: &cancelable)
        return vc
    }
}

struct NavigateCoordinator: Coordinator {
    var router: UIKitRouter
    
    func start() {
        router.route(navigationPath: MyViewController(vm: .init()))
    }
}
