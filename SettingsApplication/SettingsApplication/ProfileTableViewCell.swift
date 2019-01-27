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
    
    func setLastState() {
        if let image = UserDefaults.standard.imageForKey(key: "currentProfileImage"), let name = UserDefaults.standard.string(forKey: "currentProfileName") {
            profileImage = image
            profileName = name
        } else {
            profileImage = #imageLiteral(resourceName: "defaultProfileImage")
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
