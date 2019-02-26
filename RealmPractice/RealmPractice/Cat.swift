//
//  Cat.swift
//  RealmPractice
//
//  Created by 신재혁 on 26/02/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import Foundation
import RealmSwift

class Cat: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var color: String?
    @objc dynamic var gender: String?
    
}
