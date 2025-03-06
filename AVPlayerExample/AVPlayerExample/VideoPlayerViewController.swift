//
//  VideoPlayerViewController.swift
//  AVPlayerExample
//
//  Created by 윤태한 on 3/6/25.
//


import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var timeObserver: Any?
    
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var seekSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }
    
    func setupPlayer() {
        guard let path = Bundle.main.path(forResource: "sample_video", ofType: "mp4") else {
            print("비디오 파일을 찾을 수 없습니다.")
            return
        }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        guard let player = player else {
            print("오류: AVPlayer가 초기화되지 않았습니다.")
            return
        }
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspect
        view.layer.insertSublayer(playerLayer!, below: playPauseButton.layer)
        
        // 비디오가 로드된 후 슬라이더 최대값을 설정하기 위해 KVO 추가
        player.currentItem?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
        
        // 슬라이더 자동 업데이트 (비디오 재생 시간에 맞춰 슬라이더 이동)
        addPeriodicTimeObserver()
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else {
            print("오류: AVPlayer가 초기화되지 않았습니다.")
            return
        }
        
        if player.rate == 0 {
            player.play()
            playPauseButton.setTitle("Pause", for: .normal)
        } else {
            player.pause()
            playPauseButton.setTitle("Play", for: .normal)
        }
    }
    
    
    // **슬라이드 바가 영상 길이와 맞도록 설정**
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status", let playerItem = player?.currentItem, playerItem.status == .readyToPlay {
            DispatchQueue.main.async {
                let duration = playerItem.duration.seconds
                if duration > 0 {
                    self.seekSlider.maximumValue = Float(duration) // 슬라이더 최대값을 영상 길이와 동일하게 설정
                }
            }
        }
    }
    
    // **슬라이더 자동 업데이트 (영상 재생 시간과 동기화)**
    func addPeriodicTimeObserver() {
        guard let player = player else { return }
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else { return }
            let currentTime = player.currentTime().seconds
            let duration = player.currentItem?.duration.seconds ?? 0
            if duration > 0 {
                self.seekSlider.value = Float(currentTime)
            }
        }
    }
    
    // **슬라이더를 움직여서 영상 위치 조정**
    @IBAction func seekSliderChanged(_ sender: UISlider) {
        guard let player = player else { return }
        let newTime = CMTime(seconds: Double(sender.value), preferredTimescale: 600)
        player.seek(to: newTime)
    }
    
    deinit {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
        player?.currentItem?.removeObserver(self, forKeyPath: "status")
    }
    
}
