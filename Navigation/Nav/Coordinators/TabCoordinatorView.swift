//
//  TabCoordinatorView.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/9/24.
//

import Foundation
import SwiftUI

protocol TabCoordinatorView: BaseCoordinatorView {
    var name: String { get }
    var pathBinding: Binding<[Router.Navigation]> { get }
    func setPath(path: [Router.Navigation])
    
    associatedtype TabNav: View
    func nav(path: Binding<[Router.Navigation]>) -> TabNav
    
    associatedtype TabContent: CoordinatorView
    var tabContent: TabContent { get }
}

extension TabCoordinatorView {
    var body: some View {
        Group {
            nav(path: pathBinding)
        }
    }
    
    @ViewBuilder
    func nav(path: Binding<[Router.Navigation]>) -> some View {
        NavigationStack(path: path) {
            tabContent
                .navigationTitle(name)
        }.environmentObject(router)
            .onReceive(router.pathPublisher) { value in
                setPath(path: value)
            }
    }
}
