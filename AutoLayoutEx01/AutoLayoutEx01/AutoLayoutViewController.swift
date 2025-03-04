//
//  AutoLayoutViewController.swift
//  AutoLayoutEx01
//
//  Created by 윤태한 on 3/4/25.
//


import UIKit

class AutoLayoutViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Auto Layout 연습"
        label.textAlignment = .center
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        // 중요: Auto Layout을 사용을 위한 false 설정
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupLayout()
        
    }
    
    
    
    func setupLayout() {
        // 스택뷰 생성
        // 스택뷰에 컴포넌트 붙이기
        // 스택뷰를 뷰에 붙이기
        // 스택뷰의 오토레이아웃 설정
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(redView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 400),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
//
//        // 생성한 뷰 화면에 붙인다
//        view.addSubview(titleLabel)
//        view.addSubview(redView)
//        
//        // 긴 속성 짧게 ...
//        // let titleTop = titleLabel.topAnchor
//        // let safeTop = view.safeAreaLayoutGuide.topAnchor
//        
//        // 긴 속성 짧게 해주는 사용자 정의 클래스
//        let title = MyConstraints(view: titleLabel)
//        let redBox = MyConstraints(view: redView)
//        
//        // 오토레이아웃 설정
//        NSLayoutConstraint.activate([
//            title.top.constraint(equalTo: title.safeTop, constant: 20),
//            title.leading.constraint(equalTo: view.leadingAnchor, constant: 20),
//            title.trailing.constraint(equalTo: view.trailingAnchor, constant: -20),
//            redBox.top.constraint(equalTo: title.bottom, constant: 20), // titleLabel 아래 20만큼 띄움
//            redBox.leading.constraint(equalTo: view.leadingAnchor, constant: 20), // 좌측 여백 20
//            redBox.trailing.constraint(equalTo: view.trailingAnchor, constant: -20), // 우측 여백 20
//            redBox.height.constraint(equalToConstant: 200) // 높이 200 고정
//        ])
    }

}
