//
//  Navigation Destination.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation
import SwiftUI
import UIKit

public protocol NavigationDestination: Equatable, Hashable, Identifiable {
    var rawValue: String { get }
}

extension UIViewController: NavigationDestination {
    public var rawValue: String {
        ""
    }
}

protocol NavigationDestinationView: NavigationDestination {
    associatedtype V: View
    var view: V { get }
    static var routes: [Self] { get }
}

extension NavigationDestinationView {
    var id: String {
        UUID().uuidString
    }
}
