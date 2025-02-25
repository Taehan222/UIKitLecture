//
//  ViewController.swift
//  UIKitDay01Ex02ImageView
//
//  Created by 윤태한 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgOn = #imageLiteral(resourceName: "lamp_on")
        imgOff = #imageLiteral(resourceName: "lamp_off")
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        var w: CGFloat = 0
        var h: CGFloat = 0
        let scale: CGFloat = 1.6
        
        if isZoom {
            print("축소 됩니다.")
            btnZoom.setTitle("확대", for: .normal)
            
            w = imgView1.frame.size.width / scale
            h = imgView1.frame.size.height / scale
        }else{
            print("확대 됩니다.")
            btnZoom.setTitle("축소", for: .normal)
            
            w = imgView1.frame.size.width * scale
            h = imgView1.frame.size.height * scale
        }
        
        imgView1.frame.size = CGSize(width: w, height: h)
        isZoom = !isZoom
    }
    @IBAction func switchImageONOFF(_ sender: UISwitch) {
        if sender.isOn {
            imgView1.image = imgOn ?? imgOff
        }else{
            imgView1.image = imgOff ?? imgOn
        }
        
        
    }
    
    
}

