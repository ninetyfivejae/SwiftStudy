//
//  DisplayAdjustTableViewCell.swift
//  SettingsApplication
//
//  Created by 신재혁 on 26/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class DisplayAdjustTableViewCell: UITableViewCell {

    @IBOutlet weak var minimumIconImageView: UIImageView!
    @IBOutlet weak var maximumIconImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.minimumIconImageView.image = UIImage(named: "displayIcon")
        self.maximumIconImageView.image = UIImage(named: "displayIcon")
        setLastState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLastState() {
        slider.setValue(Float(UserDefaults.standard.double(forKey: "currentBrightness")), animated: false)
        UIScreen.main.brightness = CGFloat(UserDefaults.standard.double(forKey: "currentBrightness"))
    }
    
    @IBAction func sliderAdjusted(_ sender: UISlider) {
        print("\(sender.value)")
        
        //디스플레이 밝기 조절
        UIScreen.main.brightness = CGFloat(sender.value)
        //값 저장
        UserDefaults.standard.set(CGFloat(sender.value), forKey: "currentBrightness")
    }
}
