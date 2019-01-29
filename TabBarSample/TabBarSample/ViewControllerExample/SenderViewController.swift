//
//  SenderViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

protocol SendDataDelegate {
    func changeLabelText(to: String)
}

class SenderViewController: UIViewController {

    @IBOutlet weak var senderTextField: UITextField!
    
    var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func senderButton(_ sender: Any) {
        if let data = senderTextField.text {
            delegate?.changeLabelText(to: data)
            dismiss(animated: true, completion: nil)
        }
    }
}
