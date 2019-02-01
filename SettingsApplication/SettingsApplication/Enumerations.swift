//
//  Enumerations.swift
//  SettingsApplication
//
//  Created by 신재혁 on 01/02/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import Foundation

enum SegueIdentifier: String {
    case configureProfileSegue = "ProfileSegue"
    case adjustSettingsSegue = "AdjustSegue"
    case friendProfileSegue = "FriendSegue"
}

enum Section: Int {
    case profileSection = 0
    case settingsSection = 1
    case friendSection = 2
}

enum Row: Int {
    case firstRow = 0
    case secondRow = 1
}

enum SettingsSectionTitle: String {
    case displaySectionTitle = "밝기"
    case soundSectionTitle = "소리"
}

enum ImageName: String {
    case displayIconImage = "displayIcon"
    case soundIconImage = "soundIcon"
    case defaultProfileImage = "defaultProfileImage"
}

enum CellIdentifier: String {
    case profileTableViewCell = "ProfileCell"
    case settingsTableViewCell = "SettingsCell"
    case displayAdjustTableViewCell = "DisplayAdjustTableViewCell"
    case soundAdjustTableViewCell = "SoundAdjustTableViewCell"
}
