//
//  SecondRouteView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/22/24.
//

import Foundation
import SwiftUI

extension SecondRouteView {
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

struct SecondRouteView: CoordinatorView {
    func start(output: ViewModel.Output) {
    }
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var router: SwiftUIRouter<HomeRoutes>
    
    var content: some View {
        VStack {
            Text("Second")
//            Button("test change") {
//                viewModel.press()
//            }
        }
    }
}
