//
//  DetailViewController.swift
//  UIKitDay03TodoList
//
//  Created by 윤태한 on 2/27/25.
//

import UIKit

class DetailViewController: UIViewController {

    var task: String?
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailLabel.text = task
        
        navigationItem.title = "Todo 상세 보기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "삭제", style: .plain, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        print("삭제 버튼 눌렀다!")
//        navigationController?.popViewController(animated: true)
    }
    
}
