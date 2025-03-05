//
//  ViewController.swift
//  AudioEx
//
//  Created by 윤태한 on 3/5/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer!
    
    let timePlayerSelector : Selector = #selector(ViewController.updatePlayTime)

    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 오디오 파일 불러오기
        audioFile = Bundle.main.url(forResource: "sample-15s", withExtension: "mp3")!
        initPlayer()
    }
    
    func initPlayer() {
        // 오디오 재생 초기화 함수
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("에러 발생: \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0.0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeIntervalToString(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeIntervalToString(0.0)
        setPlayButtons(true, pause: false, stop: false)
        
    }
    
    func convertNSTimeIntervalToString(_ timeInterval: TimeInterval) -> String {
        let seconds: Int = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", Int(timeInterval / 60), seconds)
        return strTime
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeIntervalToString(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
    
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeIntervalToString(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
        
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
}

