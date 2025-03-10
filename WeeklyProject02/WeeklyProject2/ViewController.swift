//
//  ViewController.swift
//  WeeklyProject2
//
//  Created by 윤태한 on 3/1/25.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [Movie]()
    var favoriteMovies = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setupCollectionView()
        loadFavorites()
        loadMoviesFromJSON()
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    
    
    func setBackgroundColor() {
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        collectionView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        navigationController?.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width * 0.45, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCell")
        
        view.addSubview(collectionView)
    }
    
    func loadMoviesFromJSON() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            movies = try decoder.decode([Movie].self, from: data)
            collectionView.reloadData()
        } catch {
            print("JSON 파싱 에러: \(error)")
        }
    }
    
    func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.array(forKey: "favoriteMovies") as? [String] {
            favoriteMovies = Set(savedFavorites)
        }
    }
    
    func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteMovies), forKey: "favoriteMovies")
    }
    
    func toggleFavorite(movieID: String) {
        if favoriteMovies.contains(movieID) {
            favoriteMovies.remove(movieID)
        } else {
            favoriteMovies.insert(movieID)
        }
        saveFavorites()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! CustomCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.directorLabel.text = movie.director
        cell.releaseDateLabel.text = "개봉일: \(movie.releaseDate)"
        cell.genreLabel.text = "장르: \(movie.genre)"
        
        if let image = UIImage(named: "movie\(movie.id)") {
            cell.imageView.image = image
        } else {
            cell.imageView.image = nil
        }
        
        let isFavorite = favoriteMovies.contains(movie.id)
        let favoriteImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.favoriteButton.setImage(favoriteImage, for: .normal)
        
        cell.favoriteButtonAction = { [weak self] in
            self?.toggleFavorite(movieID: movie.id)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
            detailVC.selectedMovie = movies[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: location) {
            if gesture.state == .began {
                let alert = UIAlertController(title: "삭제", message: "이 영화를 삭제하시겠습니까?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                    let movie = self.movies[indexPath.row]
                    
                    self.favoriteMovies.remove(movie.id)
                    self.movies.remove(at: indexPath.row)
                    self.collectionView.deleteItems(at: [indexPath])
                    self.saveFavorites()
                }))
                self.present(alert, animated: true)
            }
        }
    }
}
