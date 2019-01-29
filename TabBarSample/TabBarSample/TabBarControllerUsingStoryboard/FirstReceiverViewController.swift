//
//  SenderViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class FirstReceiverViewController: UIViewController {
    
    @IBOutlet weak var firstReceiverLabel: UILabel!
    
    var secondSenderViewController: SecondSenderViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        secondSenderViewController?.delegate = self
    }
    
    @IBAction func showViewController(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = sb.instantiateViewController(withIdentifier: "SecondVC") as? ViewController {
            self.present(secondVC, animated: true, completion: nil)
        }
        
    }
}

extension FirstReceiverViewController: ButtonPressed {
    func changeLabelText(to: String) {
        firstReceiverLabel.text = to
    }
}
