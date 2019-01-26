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
        
        self.minimumIconImageView.image = #imageLiteral(resourceName: "displayIcon")
        self.maximumIconImageView.image = #imageLiteral(resourceName: "displayIcon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sliderAdjusted(_ sender: UISlider) {
        print("\(sender.value)")
        
        //디스플레이 밝기 조절
        UIScreen.main.brightness = CGFloat(sender.value)
    }
    
}
