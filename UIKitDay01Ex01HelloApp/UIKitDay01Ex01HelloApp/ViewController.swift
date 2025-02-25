//
//  ViewController.swift
//  UIKitDay01Ex01HelloApp
//
//  Created by 윤태한 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHello.text = "안녕하세요~"
    }

    @IBAction func changeGreeting(_ sender: UIButton) {
        //print("버튼이 눌렸어요!")
        if btnSend == sender {
            print("send 버튼이 눌렸어요!")
            let name = txtName.text ?? "익명"
            print("텍스트 필드에 입력된 이름은 \(name)입니다.")
            lblHello.text = "\(name)님 안녕하세요!"
        }else{
            print("reset 버튼이 눌렸어요!")
            lblHello.text = "안녕하세요~"
        }
    }
    
    
}

