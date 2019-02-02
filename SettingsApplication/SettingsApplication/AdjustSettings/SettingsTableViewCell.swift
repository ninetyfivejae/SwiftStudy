//
//  SettingsTableViewCell.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var optionIconImageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {            
            //self.backgroundColor = UIColor(hexFromString: "7DB9CA")
            self.backgroundColor = UIColor(hexFromString: GlobalConstants.hexPointColor, alpha: 0.5)
        } else {
            self.backgroundColor = .white
        }
    }
}
