//
//  ViewController.swift
//  EmbededSwiftUIEx
//
//  Created by 윤태한 on 3/11/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // HostingController를 이용해서 SwiftUIView를 랩핑하기
        let swiftUIView = SwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.frame = view.bounds
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }


}

