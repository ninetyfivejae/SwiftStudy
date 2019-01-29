//
//  SenderTableViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

protocol SaveDataDelegate: class {
    func saveData(data saveData:[String:String])
}

class SenderTableViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    weak var delegate: SaveDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var data = [String:String]()
        data["name"] = nameTextField.text!
        data["phone"] = phoneTextField.text!
        delegate?.saveData(data: data)
        self.navigationController?.popViewController(animated: true)
    }
}
