//
//  MainTableViewController.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let sections = ["프로필", "설정", "친구"]
    let items = [["신재혁"], ["디스플레이 및 밝기", "사운드"], ["친구1", "친구3", "친구3"]]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = UIColor.lightGray
//        return view
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.optionLabel.text = self.items[indexPath.section][indexPath.row]
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.nameLabel.text = self.items[indexPath.section][indexPath.row]
            
            return cell
        }
    }
}
