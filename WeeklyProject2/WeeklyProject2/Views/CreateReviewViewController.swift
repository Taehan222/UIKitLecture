//
//  CreateReviewViewController.swift
//  WeeklyProject2
//
//  Created by 윤태한 on 3/3/25.
//

import UIKit

class CreateReviewViewController: UIViewController {

    @IBOutlet weak var reviewTextView: UITextView!
    
    var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        reviewTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)

        reviewTextView.layer.borderColor = UIColor.gray.cgColor
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.cornerRadius = 10
        
        loadReview()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        saveReview()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 리뷰 JSON 저장 및 불러오기
    func getReviewFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("reviews.json")
    }
    
    func loadReview() {
        guard let movieID = movieID else { return }
        let fileURL = getReviewFileURL()
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let reviews = try decoder.decode([Review].self, from: data)
            
            if let review = reviews.first(where: { $0.movieID == movieID }) {
                reviewTextView.text = review.text
            }
        } catch {
            print("리뷰 로드 실패: \(error)")
        }
    }
    
    func saveReview() {
        guard let movieID = movieID, let reviewText = reviewTextView.text else { return }
        let fileURL = getReviewFileURL()
        var reviews: [Review] = []
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            reviews = try decoder.decode([Review].self, from: data)
        } catch {
            print("기존 리뷰 파일 없음, 새로운 파일 생성")
        }
        
        reviews.removeAll { $0.movieID == movieID } // 기존 리뷰 삭제 후 추가
        let newReview = Review(movieID: movieID, text: reviewText)
        reviews.append(newReview)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(reviews)
            try data.write(to: fileURL)
            print("리뷰 저장 성공")
        } catch {
            print("리뷰 저장 실패: \(error)")
        }
    }
    
}
