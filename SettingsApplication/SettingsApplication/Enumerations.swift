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

enum SectionTitle: String {
    case profileSectionTitle = "프로필"
    case settingsSectionTitle = "설정"
    case friendSectionTitle = "친구 추가"
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

enum UserDefaultsKey: String {
    case currentProfileImageURL = "currentProfileImageURL"
    case currentProfileName = "currentProfileName"
    case currentBrightness = "currentBrightness"
    case currentVolume = "currentVolume"
}

enum ActionSheetTitle: String {
    case optionMenuTitle = "프로필 사진 선택"
    case takePhotoTitle = "사진 찍기"
    case selectPhotoTitle = "사진 선택"
    case cancelTitle = "취소"
}

struct GlobalConstants {
    static let defaultProfileName: String = "사용자"
    static let hexPointColor: String = "7DB9CA"
}
