//
//  ViewController.swift
//  UICollectionViewEx
//
//  Created by 윤태한 on 2/28/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let items = Array(1...30).map { "card\($0)" }
    var images = Array(1...30).map { UIImageView(image: UIImage(systemName: "card\($0)")) }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UICollectionViewDelegate
        // UICollectionViewDataSource
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        // UILongPressGestureRecognizer를 컬렉션 뷰에 추가
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    // 롱프레스 제스처 처리 메서드
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView) // 터치된 위치 가져오기
        if let indexPath = collectionView.indexPathForItem(at: location) { // 터치된 위치의 indexPath 확인
            if gesture.state == .began { // 길게 누르기가 시작될 때만 실행
                let alert = UIAlertController(title: "삭제", message: "이 이미지를 삭제하시겠습니까?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                    self.images.remove(at: indexPath.row) // 배열에서 해당 데이터 삭제
                    self.collectionView.deleteItems(at: [indexPath]) // 컬렉션 뷰 업데이트
                }))
                present(alert, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .systemBlue
        cell.imageView?.image = UIImage(named: "card\((indexPath.item + 1) % 7)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3  // 3열 설정 (여백 포함)
        return CGSize(width: width, height: width) // 정사각형 셀
    }
    
    // 셀 간 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
            detailVC.selectedImage = UIImage(named: "card\((indexPath.item + 1) % 7)")  // 선택한 이미지 전달
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }


}

