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
    
    let sections: [String] = ["프로필", "설정", "친구"]
    var rowArray = [["사용자"], ["디스플레이 및 밝기", "사운드"]]
    var friendArray: [String] = []
    
//    var profileImage: UIImage?
//    var profileName: String?
    
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
        //section 0,1은 rowArray에서, section 2는 frientArray에서 값 가져와 사용
        guard let sectionCase = Section(rawValue: section) else {
            return 0
        }
        switch sectionCase {
        case .profileSection, .settingsSection:
            return self.rowArray[section].count
        case .friendSection:
            return self.friendArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionCase = Section(rawValue: indexPath.section), let rowCase = Row(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch sectionCase {
        case .profileSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.profileTableViewCell.rawValue, for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .settingsSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.settingsTableViewCell.rawValue, for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.optionLabel.text = self.rowArray[indexPath.section][indexPath.row]
            
            switch rowCase {
            case .firstRow:
                cell.optionIconImageView.image = UIImage(named: ImageName.displayIconImage.rawValue)
            case .secondRow:
                cell.optionIconImageView.image = UIImage(named: ImageName.soundIconImage.rawValue)
            }
            
            return cell
        case .friendSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.profileTableViewCell.rawValue, for: indexPath) as? ProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.nameLabel.text = self.friendArray[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowCase = Row(rawValue: indexPath.row) else {
            return
        }
        
        if indexPath.section == Section.settingsSection.rawValue {
            switch rowCase {
            case .firstRow:
                settingsDelegate?.setDisplayTitle()
            case .secondRow:
                settingsDelegate?.setSoundTitle()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIButton? {
        if section == Section.friendSection.rawValue {
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
        friendArray.append("test")
        self.tableView.reloadData()
        
        performSegue(withIdentifier: SegueIdentifier.friendProfileSegue.rawValue, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            let identifierCase = SegueIdentifier(rawValue: identifier) else {
                return
        }
        
        switch identifierCase {
        case .configureProfileSegue:
            if let profileVC = segue.destination as? ConfigureProfileViewController {
                //화면전환 전 설정
                profileVC.updateDelegate = self
            }
        case .adjustSettingsSegue:
            if let adjustVC = segue.destination as? AdjustSettingsViewController {
                //화면전환 전 설정
                settingsDelegate = adjustVC
            }
        default:
            return
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
                cell.profileImageView.image = UIImage(named: ImageName.defaultProfileImage.rawValue)
            }
            
            if let name = UserDefaults.standard.string(forKey: "currentProfileName") {
                cell.nameLabel.text = name
            } else {
                cell.nameLabel.text = "이름 지정하지 않음"
            }
        }
    }
}
