//
//  ReceiverViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class ReceiverViewController: UIViewController {

    @IBOutlet weak var receiverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassDataVC"{
            let senderViewController = segue.destination as! SenderViewController
            senderViewController.delegate = self
        }
    }
}

extension ReceiverViewController: SendDataDelegate {
    func changeLabelText(to: String) {
        receiverLabel.text = to
    }
}
