//
//  ViewController.swift
//  UIKitDay02AlarmClock
//
//  Created by 윤태한 on 2/26/25.
//

import UIKit

class ViewController: UIViewController {
    let interval = 1.0
    var count = 0
    var pickedDateAndTime: String!
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickedTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePicker = sender
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        pickedDateAndTime = Formatter.string(from: datePicker.date)
        lblPickedTime.text = "선택시간: " + pickedDateAndTime
    }
    
    @objc func updateTime() {
        let date = NSDate()
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간: " + Formatter.string(from: date as Date)
        
        if pickedDateAndTime == Formatter.string(from: date as Date) {
            view.backgroundColor = .red
        }
    }
    
}

