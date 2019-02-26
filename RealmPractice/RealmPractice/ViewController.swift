//
//  ViewController.swift
//  RealmPractice
//
//  Created by 신재혁 on 26/02/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit
import RealmSwift

//https://www.youtube.com/watch?v=PmsJW59rNY8
//How Reaml works
//Realm Local DB, that means all of data that you create, store, retrieve, it's all locally on the device.
//How it's all store and managed is in this one file called Realm file.
//So when you creating data and you are saving it to your local database, what you are actually doing is opening up that Realm file and then you are putting data in there.
//And when you retrieve data, you also opening up this Realm file and you are grabbing data from there.

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //sort 또한 가능
        let results = realm.objects(Cat.self).filter("color = 'Orange'")
        
        print(results.count)
    }
    
    func add() {
        let realm = try! Realm()
        var cat = Cat()
        cat.name = "Boss"
        cat.gender = "Male"
        cat.color = "Orange"
        
        try! realm.write {
            realm.add(cat)
        }
    }
}
