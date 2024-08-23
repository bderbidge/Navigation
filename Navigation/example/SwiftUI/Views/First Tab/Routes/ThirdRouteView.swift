//
//  ThirdRouteView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/22/24.
//

import Foundation
import SwiftUI

extension ThirdRouteView {
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

struct ThirdRouteView: CoordinatorView {
    func start(output: ViewModel.Output) {
    }
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var router: SwiftUIRouter<HomeRoutes>
    
    var content: some View {
        VStack {
            Text("Second")
//            Button("test change") {
//                viewModel.press()
//            }
        }
    }
}
