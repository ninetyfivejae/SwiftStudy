//
//  ConfigureFriendViewController.swift
//  SettingsApplication
//
//  Created by 신재혁 on 04/02/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit
import SDWebImage

class ConfigureFriendViewController: UIViewController {

    @IBOutlet weak var testFriendImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        testFriendImageView.sd_setImage(with: URL(string: "https://static-breeze.nike.co.kr/kr/ko_kr/cmsstatic/product/-82622102/touch-of-lime.jpg?zoom"), placeholderImage: UIImage(named: "https://www.google.co.kr/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"))
    }
    
}
