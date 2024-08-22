//
//  FirstRouteView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/10/24.
//

import Foundation
import SwiftUI

struct DependencyContainer: Equatable, Hashable {
}

extension FirstRouteView {
    class ViewModel : ViewModelNavigation {
        var container: DependencyContainer
        init(container: DependencyContainer) {
            self.container = container
        }
        
        enum Output: CoordinatorOutput {
            case detail
        }
        
        @Published var output: Output?
        var coordinatorOutput: Published<Output?>.Publisher {
            $output
        }
        
        func press()  {
            output = .detail
        }
    }
}

struct FirstRouteView: CoordinatorView {
    func start(output: ViewModel.Output) {
        switch output {
        case .detail:
            appRouter.route(navigationPath: AccountRoutes.stuff)
        }
    }
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var router: SwiftUIRouter<HomeRoutes>
    @EnvironmentObject var appRouter: AppRouter
    
    var content: some View {
        VStack {
            Text("Second")
            Button("test change") {
                viewModel.press()
            }
        }
    }
}
