//
//  ViewController.swift
//  UIKitDay01Quiz04
//
//  Created by 윤태한 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtNum1: UITextField!
    @IBOutlet weak var txtOp: UITextField!
    @IBOutlet weak var txtNum2: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    var result: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCalc(_ sender: UIButton) {
        var num1: Int, num2: Int
        
        num1 = Int(txtNum1.text ?? "0")!
        num2 = Int(txtNum2.text ?? "0")!
        if num1 < num2 {
            swap(&num1, &num2)
        }
        
        if txtOp.text! == "+" {
            result = num1 + num2
        }else if txtOp.text! == "-" {
            result = num1 - num2
        }
        
        lblResult.text = "결과: \(result)"
    }
    
}

