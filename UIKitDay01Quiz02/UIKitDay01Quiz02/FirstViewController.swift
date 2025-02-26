//
//  FirstViewController.swift
//  UIKitDay01Quiz02
//
//  Created by 윤태한 on 2/26/25.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDidLoad: UILabel!
    @IBOutlet weak var lblViewWillAppear: UILabel!
    @IBOutlet weak var lblViewDidAppear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        lblStatus.text = "viewDidLoad 호출"
        lblDidLoad.text = "viewDidLoad 호출"
        
        self.title = "첫 번째 화면"  // 네비게이션 바의 제목 설정
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(goNext))
        
    }
    
    @objc func goNext() {
            let nextVC = SecondViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        lblStatus.text = "viewWillAppear 호출"
        lblViewWillAppear.text = "viewWillAppear 호출"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        lblStatus.text = "viewDidAppear 호출"
        lblViewDidAppear.text = "viewDidAppear 호출"
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("viewWillDisappear")
//        lblStatus.text = "view
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("viewDidDisappear")
//        lblStatus.text = "view
//    }
    
    
    
    
}
