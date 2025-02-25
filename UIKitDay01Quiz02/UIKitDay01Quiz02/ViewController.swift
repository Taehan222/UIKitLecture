//
//  ViewController.swift
//  UIKitDay01Quiz02
//
//  Created by 윤태한 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {
    var img: UIImage?
    var num: Int = 1
    
    @IBOutlet weak var imgView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img = UIImage(named: "\(num).png")
        imgView1.image = img
        
    }

    @IBAction func btnNext(_ sender: UIButton) {
        if num < 7 {
            img = UIImage(named: "\(num+1).png")
            imgView1.image = img
            num += 1
        }
    }
    
    @IBAction func btnPrev(_ sender: UIButton) {
        if num > 1 {
            img = UIImage(named: "\(num-1).png")
            imgView1.image = img
            num -= 1
        }
    }
    
}

