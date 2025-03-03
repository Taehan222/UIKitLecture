//
//  CustomCollectionViewCell.swift
//  WeeklyProject2
//
//  Created by 윤태한 on 3/1/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteButtonAction: (() -> Void)?
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButtonAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }

}
