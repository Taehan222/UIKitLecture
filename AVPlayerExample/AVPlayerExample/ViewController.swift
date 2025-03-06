//
//  ViewController.swift
//  AVPlayerExample
//
//  Created by 윤태한 on 3/6/25.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?

        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var volumeSlider: UISlider!

        override func viewDidLoad() {
            super.viewDidLoad()
            setupAudioPlayer()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }

        func setupAudioPlayer() {
            guard let url = Bundle.main.url(forResource: "sample", withExtension: "mp3") else {
                print("오디오 파일을 찾을 수 없습니다.")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            } catch {
                print("오디오 플레이어 초기화 실패: \(error)")
            }
        }

        @IBAction func playAudio(_ sender: UIButton) {
            audioPlayer?.play()
        }

        @IBAction func pauseAudio(_ sender: UIButton) {
            audioPlayer?.pause()
        }

        @IBAction func stopAudio(_ sender: UIButton) {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }

        @IBAction func volumeChanged(_ sender: UISlider) {
            audioPlayer?.volume = sender.value
        }

        @objc func updateTime() {
            let minutes = Int(audioPlayer?.currentTime ?? 0) / 60
            let seconds = Int(audioPlayer?.currentTime ?? 0) % 60
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }

}

