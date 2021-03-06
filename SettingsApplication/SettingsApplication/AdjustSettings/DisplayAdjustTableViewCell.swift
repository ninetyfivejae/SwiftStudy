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

        self.minimumIconImageView.image = UIImage(named: ImageName.displayIconImage.rawValue)
        self.maximumIconImageView.image = UIImage(named: ImageName.displayIconImage.rawValue)
        setLastState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLastState() {
        if UserDefaults.standard.double(forKey: UserDefaultsKey.currentBrightness.rawValue) != nil {
            slider.setValue(Float(UserDefaults.standard.double(forKey: UserDefaultsKey.currentBrightness.rawValue)), animated: false)
            UIScreen.main.brightness = CGFloat(UserDefaults.standard.double(forKey: UserDefaultsKey.currentBrightness.rawValue))
        } else {
            slider.setValue(Float(UIScreen.main.brightness), animated: false)
        }
    }
    
    @IBAction func sliderAdjusted(_ sender: UISlider) {
        print("\(sender.value)")
        
        //디스플레이 밝기 조절
        UIScreen.main.brightness = CGFloat(sender.value)
        //값 저장
        UserDefaults.standard.set(CGFloat(sender.value), forKey: UserDefaultsKey.currentBrightness.rawValue)
        //synchronize가 호출되지 못하는 비정상적인 상황 대비해서 바로 메모리의 내용을 파일로 동기화
        UserDefaults.standard.synchronize()
    }
}
