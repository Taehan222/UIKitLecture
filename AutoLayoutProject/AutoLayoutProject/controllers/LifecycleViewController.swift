//
//  LifecycleViewController.swift
//  AutoLayoutProject
//
//  Created by 윤태한 on 3/4/25.
//

import UIKit

class LifecycleViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lifecycle View Controller"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        setupLayer()
        
    }
    
    func setupLayer() {
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    
    @objc func handleNext() {
        let SecondVC = SecondViewController()
        print("다음 뷰로 이동합니다")
        SecondVC.userName = "태한"
        SecondVC.job = "개발자"
        navigationController?.pushViewController(SecondVC, animated: true)
    }


}
