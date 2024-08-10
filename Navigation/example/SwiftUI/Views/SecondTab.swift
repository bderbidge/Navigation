//
//  SecondTab.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import SwiftUI

struct SecondTab: CoordinatorView {
    func start(output: ContentViewModel.Output) {
    }
    
    @ObservedObject var viewModel: ContentViewModel
    @EnvironmentObject var router: SwiftUIRouter<AccountRoutes>
    
    var content: some View {
        Text("Second")
    }
}
