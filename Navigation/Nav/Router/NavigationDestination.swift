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
    var prefix: String { get }
    var path: String { get }
}

extension NavigationDestination {
    var path: String {
        "\(self.prefix)/\(rawValue)"
    }
}

extension UIViewController: NavigationDestination {
    public var prefix: String {
     ""
    }
    
    public var path: String {
        ""
    }
    
    public var rawValue: String {
        ""
    }
}

protocol NavigationDestinationView: NavigationDestination {
    associatedtype V: View
    var view: V { get }
    static func routes(container: RouterContainer) -> [Self]
}

extension NavigationDestinationView {
    var id: String {
        UUID().uuidString
    }
}
