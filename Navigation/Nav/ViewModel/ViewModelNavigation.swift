//
//  ViewModelNavigation.swift
//  Navigation
//
//  Created by Brandon Derbidge on 7/22/24.
//

import Foundation

protocol CoordinatorOutput {}

protocol ViewModelNavigation: ObservableObject {
    associatedtype Output: CoordinatorOutput
    var coordinatorOutput: Published<Output?>.Publisher { get }
}
