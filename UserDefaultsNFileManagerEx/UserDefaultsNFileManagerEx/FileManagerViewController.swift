//
//  Note.swift
//  UserDefaultsNFileManagerEx
//
//  Created by 윤태한 on 3/6/25.
//


import UIKit

struct Note: Codable {
    let title: String
    let content: String
}

class FileManagerViewController: UIViewController {
    let fileName = "notes.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        saveNote()
        loadNote()
    }

    func saveNote() {
        let note = Note(title: "iOS 개발", content: "FileManager 예제 학습 중")
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(note) {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentDirectory.appendingPathComponent(fileName)

            do {
                try data.write(to: fileURL)
                print("노트 저장 성공: \(fileURL)")
            } catch {
                print("노트 저장 실패: \(error)")
            }
        }
    }

    func loadNote() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            if let note = try? decoder.decode(Note.self, from: data) {
                print("불러온 노트: \(note.title), \(note.content)")
            }
        }
    }
}