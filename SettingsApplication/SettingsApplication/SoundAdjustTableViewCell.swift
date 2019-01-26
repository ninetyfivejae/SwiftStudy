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

        self.minimumIconImageView.image = #imageLiteral(resourceName: "soundIcon")
        self.maximumIconImageView.image = #imageLiteral(resourceName: "soundIcon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func sliderAdjusted(_ sender: UISlider) {
            print("\(sender.value)")
        
            //사운드 크기 조절
            initAudio()
            audioPlayer?.volume = sender.value
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
