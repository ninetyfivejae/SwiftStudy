//
//  MainTableViewController.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

struct Profile {
    var profileImage: UIImage?
    var profileName: String?
}

class MainTableViewController: UITableViewController {
    
    let sections = ["프로필", "설정", "친구"]
    let items = [["신재혁"], ["디스플레이 및 밝기", "사운드"], ["test1", "test2", "tes3"]]
    var profile: Profile = Profile(profileImage: UserDefaults.standard.imageForKey(key: "currentProfileImage"), profileName: UserDefaults.standard.string(forKey: "currentProfileName"))
    
    //친구 리스트 따로 관리하기

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("2st viewWillAppear")
        
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? ProfileTableViewCell {
            cell.profileImageView.image = UserDefaults.standard.imageForKey(key: "currentProfileImage")
            cell.nameLabel.text = UserDefaults.standard.string(forKey: "currentProfileName")
        }
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
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.optionLabel.text = self.items[indexPath.section][indexPath.row]
            
            return cell
            
        } else if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            
//            cell.profileImageView.image = UserDefaults.standard.imageForKey(key: "currentProfileImage")
//            cell.nameLabel.text = UserDefaults.standard.string(forKey: "currentProfileName")
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.nameLabel.text = self.items[indexPath.section][indexPath.row]
            
            return cell
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 1, indexPath.row == 0 {
//
//        } else if indexPath.section == 1, indexPath.row == 1 {
//
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "AdjustSegue" {
//            if let adjustVC = segue.destination as? AdjustSettingsViewController {
//                //넘어가기 전 설정
//            }
//        } else if segue.identifier == "AdjustSegue" {
//            if let adjustVC = segue.destination as? AdjustSettingsViewController {
//                //넘어가기 전 설정
//            }
//        }
//    }
}
