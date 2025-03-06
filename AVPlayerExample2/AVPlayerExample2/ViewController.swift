//
//  ViewController.swift
//  AVPlayerExample2
//
//  Created by 윤태한 on 3/6/25.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController, UIDocumentPickerDelegate {
    var audioPlayer: AVAudioPlayer?
    var selectedAudioURL: URL?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var selectFileButton: UIButton!
    @IBOutlet weak var fileNameLabel: UILabel! // 파일명 표시
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI() {
        playButton.isEnabled = false
        stopButton.isEnabled = false
        fileNameLabel.text = "No file selected"
    }
    
    @IBAction func selectAudioFile(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeAudio as String], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true)
    }
    
    // 파일 선택 후 실행되는 메서드**
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else { return }
        selectedAudioURL = selectedURL
        fileNameLabel.text = selectedURL.lastPathComponent // 파일명 표시
        playButton.isEnabled = true
        stopButton.isEnabled = true
        setupAudioPlayer()
    }
    
    // 오디오 플레이어 초기화**
    func setupAudioPlayer() {
        guard let url = selectedAudioURL else { return }
        
        // 기존 플레이어가 실행 중이면 정리
        audioPlayer?.stop()
        audioPlayer = nil
        
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("오디오 파일 재생 실패: \(error)")
            fileNameLabel.text = "오디오 파일 재생 실패"
        }
    }
    
    
    // 재생 버튼 액션**
    @IBAction func playAudio(_ sender: UIButton) {
        audioPlayer?.play()
    }
    
    
    // 정지 버튼 액션**
    @IBAction func stopAudio(_ sender: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
    
    
    func playAudioFromSimulatorFiles() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentDirectory.appendingPathComponent("LetItBeMe.mp3")
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer.play()
        } catch {
            print("오디오 파일 재생 실패: \(error)")
        }
    }
    
}

