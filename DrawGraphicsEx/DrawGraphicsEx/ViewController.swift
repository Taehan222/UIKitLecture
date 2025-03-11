//
//  ViewController.swift
//  DrawGraphicsEx
//
//  Created by 윤태한 on 3/11/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    var lastPoint: CGPoint? // 터치 시작 위치 저장
    var isDrawing = false   // 그리기 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDrawLine(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw Line
        // 설정 -> 액션
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.move(to: CGPoint(x: 70, y: 50))
        context.addLine(to: CGPoint(x: 200, y: 250))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawRectangle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let rectangle = CGRect(x: 50, y: 50, width: 200, height: 100)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(5)
        context.addRect(rectangle)
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawCircle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let circleRect = CGRect(x: 50, y: 50, width: 150, height: 150)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(5)
        context.addEllipse(in: circleRect)
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawArc(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.purple.cgColor)
        context.setLineWidth(5)
        context.addArc(center: CGPoint(x: 150, y: 150),
                       radius: 100,
                       startAngle: 0,
                       endAngle: .pi / 2,
                       clockwise: true)
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawFill(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let fillRect = CGRect(x: 50, y: 50, width: 150, height: 150)
        context.setFillColor(UIColor.orange.cgColor)
        context.fill(fillRect)
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    @IBAction func btnReset(_ sender: UIButton) {
        imgView.image = nil
    }
    
    // **터치 기반 드로잉 추가**
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.location(in: imgView)
            isDrawing = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDrawing { return }
        guard let touch = touches.first, let lastPoint = lastPoint else { return }
        
        let currentPoint = touch.location(in: imgView)
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        imgView.image?.draw(in: imgView.bounds)
        
        context?.setLineWidth(3.0)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineCap(.round)
        
        context?.move(to: lastPoint)
        context?.addLine(to: currentPoint)
        context?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = false
    }
    
    
}

