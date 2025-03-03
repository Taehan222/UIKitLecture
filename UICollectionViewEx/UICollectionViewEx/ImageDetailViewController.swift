//
//  ImageDetailViewController.swift
//  UICollectionViewEx
//
//  Created by 윤태한 on 2/28/25.
//

import UIKit

class ImageDetailViewController: UIViewController {
    var selectedImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImage
    }



}
