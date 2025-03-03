//
//  ImageDetailViewController.swift
//  WeeklyProject2
//
//  Created by 윤태한 on 3/1/25.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var selectedMovie: Movie?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        
        if let movie = selectedMovie {
            imageView.image = UIImage(named: "movie\(movie.id)")
            titleLabel.text = movie.title
            directorLabel.text = "감독: \(movie.director)"
            releaseDateLabel.text = "개봉일: \(movie.releaseDate)"
            genreLabel.text = "장르: \(movie.genre)"
        }
    }
    
    
    @IBAction func editReviewButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let reviewVC = storyboard.instantiateViewController(withIdentifier: "CreateReviewViewController") as? CreateReviewViewController {
            reviewVC.movieID = selectedMovie?.id
            present(reviewVC, animated: true, completion: nil)
        }
    }
    
}

