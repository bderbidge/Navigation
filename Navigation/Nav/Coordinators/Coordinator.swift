//
//  Coordinator.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator {
    associatedtype R: Router
    var router: R { get }
    func start()
}

extension Coordinator {
    func start() {}
}

protocol BaseCoordinatorView: View, Coordinator  {
    associatedtype Router: SwiftUIRouterR
    var router: Router { get }
}
