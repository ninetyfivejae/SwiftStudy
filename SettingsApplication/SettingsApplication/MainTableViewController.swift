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
    var items = [["신재혁"], ["디스플레이 및 밝기", "사운드"], []]
    
    var profileImage: UIImage?
    var profileName: String?
    
    //친구 리스트 따로 관리하기
    
    var settingsDelegate: SettingsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
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
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.optionLabel.text = self.items[indexPath.section][indexPath.row]
            
            if indexPath.row == 0 {
                cell.optionIconImageView.image = UIImage(named: "displayIcon")
            } else if indexPath.row == 1 {
                cell.optionIconImageView.image = UIImage(named: "soundIcon")
            }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.nameLabel.text = self.items[indexPath.section][indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1, indexPath.row == 0 {
            settingsDelegate?.setDisplayTitle()
        } else if indexPath.section == 1, indexPath.row == 1 {
            settingsDelegate?.setSoundTitle()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIButton? {
        if section == 2 {
            let button = UIButton(type: .system)
            button.setTitle("친구 추가", for: .normal)
            button.tintColor = .black
            button.backgroundColor = UIColor(hexFromString: "7DB9CA")
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

            return button
        } else {
            return nil
        }
    }

    @objc func buttonClicked(sender : UIButton){
        items[2].append("test")
        
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdjustSegue" {
            if let adjustVC = segue.destination as? AdjustSettingsViewController {
                //넘어가기 전 설정
                settingsDelegate = adjustVC
            }
        } else if segue.identifier == "ProfileSegue" {
            if let profileVC = segue.destination as? ConfigureProfileViewController {
                //넘어가기 전 설정
                profileVC.updateDelegate = self
            }
        }
    }
}

extension MainTableViewController: UpdateDelegate {
    
    func updateProfile() {
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? ProfileTableViewCell {
            if let imageURL = UserDefaults.standard.url(forKey: "currentProfileImage") {
                cell.profileImageView.image = UIImage(url: imageURL)
            } else {
                cell.profileImageView.image = UIImage(named: "defaultProfileImage")
            }
            
            if let name = UserDefaults.standard.string(forKey: "currentProfileName") {
                cell.nameLabel.text = name
            } else {
                cell.nameLabel.text = "이름 지정하지 않음"
            }
        }
    }
}
