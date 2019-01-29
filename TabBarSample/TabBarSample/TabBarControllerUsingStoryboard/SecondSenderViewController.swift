//
//  SecondSenderViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

protocol ButtonPressed {
    func changeLabelText(to: String)
}

class SecondSenderViewController: UIViewController {
    
    @IBOutlet weak var secondSenderTextField: UITextField!
    
    var delegate: ButtonPressed?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func secondSenderButtonTapped(_ sender: Any) {
        if let text = secondSenderTextField.text {
            delegate?.changeLabelText(to: text)
        }
    }
}
