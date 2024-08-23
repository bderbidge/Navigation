//
//  CoordinatorView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/22/24.
//

import Foundation
import SwiftUI

protocol CoordinatorView: View, Coordinator {
    associatedtype Navigation: NavigationDestinationView
    var router: SwiftUIRouter<Navigation> { get }
    
    associatedtype Content: View
    var content: Content { get }
    
    associatedtype VM: ViewModelNavigation
    var viewModel: VM { get }
    func start(output: VM.Output)
}

extension CoordinatorView {
    var body: some View {
        coordinatorView
    }
    
    var coordinatorView: some View {
        Group {
            content
        }
        .onReceive(viewModel.coordinatorOutput) { output in
            guard let output = output else { return }
            start(output: output)
        }
    }
}
