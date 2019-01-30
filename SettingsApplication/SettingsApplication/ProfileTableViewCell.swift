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
            self.backgroundColor = UIColor.hexStringToUIColor(hex: "#7DB9CA")
        } else {
            self.backgroundColor = .white
        }
    }
    
    func setLastState() {
        if let image = UserDefaults.standard.imageForKey(key: "currentProfileImage"), let name = UserDefaults.standard.string(forKey: "currentProfileName") {
            profileImage = image
            profileName = name
        } else {
            profileImage = UIImage(named: "defaultProfileImage")
            profileName = "이름 지정하지 않음"
        }
        
        profileImageView.image = profileImage
        nameLabel.text = profileName
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        profileImageView.image = #imageLiteral(resourceName: "defaultProfileImage")
//        nameLabel.text = "이름 지정하지 않음"
//    }
}

extension UIColor {
    class func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
