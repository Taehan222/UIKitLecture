//
//  DataManager.swift
//  CoreDataRelationshipEx
//
//  Created by 윤태한 on 3/7/25.
//


import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // 사용자 생성
    func createUser(name: String, email: String) -> User {
        let user = User(context: context)
        user.id = UUID() // UUID 자동 생성
        user.name = name
        user.email = email
        saveContext()
        return user
    }
    
    // 게시글 생성
    func createPost(title: String, content: String, user: User) {
        let post = Post(context: context)
        post.id = UUID()
        post.title = title
        post.content = content
        post.createdAt = Date()
        post.user = user
        
        user.addToPosts(post)
        saveContext()
    }
    
    // 모든 사용자 가져오기
    func fetchUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("사용자 데이터를 가져오는 데 실패: \(error.localizedDescription)")
            return []
        }
    }
    
    // 특정 사용자의 게시글 가져오기
    func fetchPosts(for user: User) -> [Post] {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        do {
            return try context.fetch(request)
        } catch {
            print("게시물을 가져오는 데 실패: \(error.localizedDescription)")
            return []
        }
    }
    
    // 사용자 삭제 (연결된 게시물도 함께 삭제)
    func deleteUser(_ user: User) {
        // 사용자의 모든 게시물을 먼저 삭제
        if let posts = user.posts as? Set<Post> {
            for post in posts {
                context.delete(post)
            }
        }
        // 사용자 삭제
        context.delete(user)
        saveContext()
    }
    
    // 게시글 삭제
    func deletePost(_ post: Post) {
        context.delete(post)
        saveContext()
    }
    
    // 데이터 저장
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("데이터 저장 실패: \(error.localizedDescription)")
        }
    }
}
