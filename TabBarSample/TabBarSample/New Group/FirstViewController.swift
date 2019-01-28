//
//  FirstViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 28/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //backgroundColor 지정 안 해주면 검은색으로 설정된다
        self.view.backgroundColor = .blue
        self.title = "Tab 1"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
