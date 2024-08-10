//
//  TabNavigationView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/7/24.
//

import Foundation
import SwiftUI

struct TabNavigationView<Nav: NavigationDestinationView>: View {
    @ObservedObject var router: SwiftUIRouter<Nav>
    var view: any CoordinatorView
    var name: String
    
    var body: some View {
        NavigationStack(path: $router.path) {
            bodyView()
                .navigationTitle(name)
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    func bodyView() -> some View {
        AnyView(view)
    }
}
