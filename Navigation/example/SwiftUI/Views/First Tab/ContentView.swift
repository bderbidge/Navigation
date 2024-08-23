//
//  ContentView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/21/24.
//

import SwiftUI

class ContentViewModel: ViewModelNavigation {
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

struct ContentView: NavigationStackView {
    
    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var router: SwiftUIRouter<HomeRoutes>
    var name: String
    var container = DependencyContainer()
    
    var content: some View {
        VStack {
            Text("Any")
            Button("Press me") {
                viewModel.press()
            }
        }
    }
    
    func start(output: ContentViewModel.Output) {
        switch output {
        case .detail:
            router.route(navigationPath: .home(container, router))
        }
    }
}
