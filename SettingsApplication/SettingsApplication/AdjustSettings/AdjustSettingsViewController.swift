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
    
    var sectionTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        return sectionTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sectionTitle == "밝기" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayAdjustTableViewCell", for: indexPath) as? DisplayAdjustTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else if sectionTitle == "소리" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoundAdjustTableViewCell", for: indexPath) as? SoundAdjustTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension AdjustSettingsViewController: SettingsDelegate {
    func setDisplayTitle() {
        sectionTitle = "밝기"
    }
    
    func setSoundTitle() {
        sectionTitle = "소리"
    }
}
