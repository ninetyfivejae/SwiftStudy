//
//  SecondViewController.swift
//  Practice
//
//  Created by 신재혁 on 09/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var informationLabel: UILabel!
    var infoObject: String?

    @IBOutlet weak var dataTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("2st viewDidLoad")
        
        if infoObject != nil {
            informationLabel.text = infoObject
            dataTextView.text = infoObject
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("2st viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("2st viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("2st viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("2st viewDidDisappear")
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
