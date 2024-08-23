//
//  SecondTab.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import SwiftUI

struct SecondTab: NavigationStackView {

    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var router: SwiftUIRouter<AccountRoutes>
    var name: String
    
    var content: some View {
        VStack {
            Text("Second")
            Button("Navigate") {
                viewModel.press()
            }
        }
    }
    
    func start(output: ContentViewModel.Output) {
        router.route(navigationPath: .stuff(router))
    }
}
