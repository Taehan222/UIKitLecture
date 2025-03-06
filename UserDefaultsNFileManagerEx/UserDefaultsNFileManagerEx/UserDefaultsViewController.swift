//
//  UserDefaultsViewController.swift
//  UserDefaultsNFileManagerEx
//
//  Created by 윤태한 on 3/6/25.
//


import UIKit

class UserDefaultsViewController: UIViewController {

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("데이터 저장", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("데이터 불러오기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadData), for: .touchUpInside)
    }

    func setupLayout() {
        view.addSubview(saveButton)
        view.addSubview(loadButton)
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20)
        ])
    }

    @objc func saveData() {
        UserDefaults.standard.set("UIKit 강의", forKey: "courseName")
        print("데이터 저장 완료")
    }

    @objc func loadData() {
        let courseName = UserDefaults.standard.string(forKey: "courseName") ?? "데이터 없음"
        print("불러온 데이터: \(courseName)")
    }
}