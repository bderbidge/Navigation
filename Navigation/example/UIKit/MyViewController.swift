//
//  MyViewController.swift
//  Navigation
//
//  Created by Brandon Derbidge on 8/1/24.
//

import Foundation
import UIKit

class MyViewModel: ViewModelNavigation {
    enum Output: CoordinatorOutput {
        case detail
    }
    
    @Published var output: Output?
    var coordinatorOutput: Published<Output?>.Publisher {
        $output
    }
    
    func press()  {
        output = .detail
    }
}

class MyViewController: UIViewController {
    var vm: MyViewModel
    
    init(vm: MyViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 1
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Hello, UIKit!"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system) // Use .system type for a better default button style
        button.setTitle("Press Me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonTapped() {
        vm.press()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 3
        view.addSubview(label)
        view.addSubview(button)
        
        // Set up label constraints
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
        ])
        
        // Set up button constraints
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

