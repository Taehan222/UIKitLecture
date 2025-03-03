//
//  ViewController.swift
//  WeeklyProject2
//
//  Created by 윤태한 on 3/1/25.
//

import UIKit

// 1. 영화 데이터를 담을 모델 정의 (Codable 채택)
struct Movie: Codable {
    let id: String
    let title: String
    let director: String
    let releaseDate: String
    let genre: String
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [Movie]()
    var favoriteMovies = Set<String>() // 즐겨찾기한 영화 ID 저장
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        collectionView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        navigationController?.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        
        setupCollectionView()
        loadFavorites()
        loadMoviesFromJSON()
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
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
    
    // MARK: - UserDefaults 활용한 즐겨찾기 기능
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
        collectionView.reloadData() // UI 업데이트
    }
    
    // MARK: - UICollectionViewDataSource
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
        
        // 즐겨찾기 상태 UI 업데이트
        let isFavorite = favoriteMovies.contains(movie.id)
        let favoriteImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.favoriteButton.setImage(favoriteImage, for: .normal)
        
        // 버튼 클릭 이벤트 추가
        cell.favoriteButtonAction = { [weak self] in
            self?.toggleFavorite(movieID: movie.id)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
            detailVC.selectedMovie = movies[indexPath.row] // Movie 객체 전달
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // MARK: - 롱프레스 삭제 기능 추가
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: location) {
            if gesture.state == .began {
                let alert = UIAlertController(title: "삭제", message: "이 영화를 삭제하시겠습니까?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                    let movie = self.movies[indexPath.row]
                    // 삭제된 영화가 즐겨찾기에 있다면 함께 삭제
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
