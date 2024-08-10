//
//  FirstRouteView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/10/24.
//

import Foundation
import SwiftUI

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
        Text("Second")
    }
}

extension FirstRouteView {
    class ViewModel : ViewModelNavigation {
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
