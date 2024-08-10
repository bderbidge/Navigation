//
//  TabViewCoordinatorImp.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/9/24.
//

import Foundation
import SwiftUI

struct TabCoordinatorViewImp<ContentCoordinator: CoordinatorView, Router: SwiftUIRouterR>: TabCoordinatorView {
    var pathBinding: Binding<[Router.Navigation]> {
        $path
    }
    
    func setPath(path: [Router.Navigation]) {
        self.path = path
    }
    
    var name: String
    var tabContent: ContentCoordinator
    @ObservedObject var router: Router
    @State var path = [Router.Navigation]()
}
