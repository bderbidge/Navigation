//
//  TabViewCoordinatorImp.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/9/24.
//

import Foundation
import SwiftUI

struct NavStackWrapper<Navigation: NavigationDestinationView, Content: View>: View {
    @ObservedObject var router: SwiftUIRouter<Navigation>
    let name: String
    @ViewBuilder let content: Content

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationTitle(name)
        }
    }
}
