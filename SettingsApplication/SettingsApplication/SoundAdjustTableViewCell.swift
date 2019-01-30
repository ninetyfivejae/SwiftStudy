//
//  AdjustTableViewCell.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit
import AVFoundation

class SoundAdjustTableViewCell: UITableViewCell, AVAudioPlayerDelegate {
    
    @IBOutlet weak var minimumIconImageView: UIImageView!
    @IBOutlet weak var maximumIconImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var audioPlayer: AVAudioPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.minimumIconImageView.image = UIImage(named: "soundIcon")
        self.maximumIconImageView.image = UIImage(named: "soundIcon")
        setLastState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLastState() {
        slider.setValue(Float(UserDefaults.standard.double(forKey: "currentVolume")), animated: false)
        audioPlayer?.volume = Float(UserDefaults.standard.double(forKey: "currentVolume"))
    }
    
    func saveCurrentState() {
        UserDefaults.standard.set(audioPlayer?.volume, forKey: "currentVolume")
        //synchronize가 호출되지 못하는 비정상적인 상황 대비해서 바로 메모리의 내용을 파일로 동기화
        UserDefaults.standard.synchronize()
    }

    @IBAction func sliderAdjusted(_ sender: UISlider) {
        print("\(sender.value)")
    
        //사운드 크기 조절
        initAudio()
        audioPlayer?.volume = sender.value
        saveCurrentState()
        audioPlayer?.play()
    }

    func initAudio() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
            audioPlayer?.prepareToPlay()
        } catch {
            print(error)
        }
        
        if audioPlayer == nil {
            print("audioPlayer error")
        }else{
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
        }
    }
}
