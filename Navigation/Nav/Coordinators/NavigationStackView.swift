//
//  TabCoordinatorView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/9/24.
//

import Foundation
import SwiftUI

protocol NavigationStackView: CoordinatorView {
    var name: String { get }
}

extension NavigationStackView {
    var tabContent: some View {
        Group {
            NavStackWrapper(router: router, name: name) {
                coordinatorView
            }
            .environmentObject(router)
        }
    }
    
    var body: some View {
        tabContent
    }
}
