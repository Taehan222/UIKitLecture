//
//  ThirdViewController.swift
//  AutoLayoutProject
//
//  Created by 윤태한 on 3/4/25.
//

import UIKit

class ThirdViewController: UIViewController {
    var userName: String?
    var job: String?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Third View Controller"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(userName!, job!)
        
        view.backgroundColor = .systemCyan
        
        setupLayer()
        
    }
    
    func setupLayer() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}
