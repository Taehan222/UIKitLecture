//
//  ViewController.swift
//  CoreDataRelationshipEx
//
//  Created by 윤태한 on 3/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 테스트 데이터 추가
        let newUser = DataManager.shared.createUser(name: "홍길동", email: "hong@example.com")
        let newPost1 = DataManager.shared.createPost(title: "첫 번째 게시글", content: "안녕하세요!", user: newUser)
        let newPost2 = DataManager.shared.createPost(title: "두 번째 게시글", content: "반갑습니다!", user: newUser)
        
        // 2. 모든 사용자 조회
        let users = DataManager.shared.fetchUsers()
        print("저장된 사용자 목록:")
        for user in users {
            print("ID: \(user.id!), 이름: \(user.name), 이메일: \(user.email)")
        }
        
        // 3. 특정 사용자의 게시글 조회
        let posts = DataManager.shared.fetchPosts(for: newUser)
        print("\(newUser.name)의 게시글 목록:")
        for post in posts {
            print("제목: \(post.title), 내용: \(post.content ?? "내용 없음")")
        }
        
        // 4. 게시글 삭제 테스트
        if let firstPost = posts.first {
            DataManager.shared.deletePost(firstPost)
            print("\(firstPost.title) 게시글 삭제 완료")
        }
        
        // 5. 사용자 삭제 테스트
        DataManager.shared.deleteUser(newUser)
        print("\(newUser.name) 사용자 삭제 완료")
        
        // 6. 삭제 후 데이터 확인
        let remainingUsers = DataManager.shared.fetchUsers()
        print("남은 사용자 수: \(remainingUsers.count)")
        
        let remainingPosts = DataManager.shared.fetchPosts(for: newUser)
        print("남은 게시글 수: \(remainingPosts.count)")
    }
    
    
}

