//
//  ProfileTableViewCell.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var profileImage: UIImage?
    var profileName: String?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLastState()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            //self.backgroundColor = UIColor(hexFromString: "7DB9CA")
            self.backgroundColor = UIColor(hexFromString: "7DB9CA", alpha: 0.5)
        } else {
            self.backgroundColor = .white
        }
    }
    
    func setLastState() {
        if let imageURL = UserDefaults.standard.url(forKey: "currentProfileImage") {
            profileImageView.image = UIImage(url: imageURL)
        } else {
            profileImageView.image = UIImage(named: ImageName.defaultProfileImage.rawValue)
        }
        
        if let name = UserDefaults.standard.string(forKey: "currentProfileName") {
            nameLabel.text = name
        } else {
            nameLabel.text = "이름 지정하지 않음"
        }
    }
    
}

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
