//
//  ViewController.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class ConfigureProfileViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var configureProfileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureProfileView.layer.cornerRadius = self.configureProfileView.frame.size.width / 2;
        self.configureProfileView.clipsToBounds = true;
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        //변경사항 저장
    }
}
