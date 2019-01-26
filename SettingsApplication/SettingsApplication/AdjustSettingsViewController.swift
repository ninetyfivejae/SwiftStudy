//
//  AdjustSettingsViewController.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class AdjustSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        return "소리"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayAdjustTableViewCell", for: indexPath) as? DisplayAdjustTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoundAdjustTableViewCell", for: indexPath) as? SoundAdjustTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        
//        let indexPath = IndexPath(row: 0, section: 0)
//        if let cell = tableView.cellForRow(at: indexPath) as? SoundAdjustTableViewCell {
//            cell.isHidden = true
//        }
        
    }
}
