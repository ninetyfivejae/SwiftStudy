//
//  SecondViewController.swift
//  Practice
//
//  Created by 신재혁 on 09/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("2st viewDidLoad")
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
}
