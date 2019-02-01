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
        
        guard let title = sectionTitle else {
            return UITableViewCell()
        }
        guard let settingsSectionTitle = SettingsSectionTitle(rawValue: title) else {
            return UITableViewCell()
        }
        
        switch settingsSectionTitle {
        case .displaySectionTitle:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.displayAdjustTableViewCell.rawValue, for: indexPath) as? DisplayAdjustTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .soundSectionTitle:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.soundAdjustTableViewCell.rawValue, for: indexPath) as? SoundAdjustTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

extension AdjustSettingsViewController: SettingsDelegate {
    func setDisplayTitle() {
        sectionTitle = SettingsSectionTitle.displaySectionTitle.rawValue
    }
    
    func setSoundTitle() {
        sectionTitle = SettingsSectionTitle.soundSectionTitle.rawValue
    }
}
