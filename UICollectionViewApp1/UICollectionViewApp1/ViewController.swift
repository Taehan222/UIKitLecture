//
//  ViewController.swift
//  UICollectionViewApp1
//
//  Created by 윤태한 on 2/27/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items = Array(1...12).map {"card\($0)"}
    let images = Array(1...6).map {UIImage(named: "card\($0)")!}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // CustomCollectionViewCell 등록
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 셀 개수 반환
        return images.count
    }
    
    // MARK: - UICollectionViewDataSource
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        //cell.backgroundColor = .systemBlue
        cell.imageView?.image = UIImage(named: "card1")
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    // 셀 크기 지정 (3열 레이아웃)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3  // 3열 설정 (여백 포함)
        return CGSize(width: width, height: width) // 정사각형 셀
    }
    
    // 행 간 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 같은 행 내 셀 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

