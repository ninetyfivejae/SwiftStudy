//
//  ViewController.swift
//  RealmPractice
//
//  Created by 신재혁 on 26/02/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)

//        let genres = realm.objects(Genres.self)
//        let movies = realm.objects(Movie.self).sorted(byKeyPath: id, ascending: true)
//        for genre in genres {
//            let firstInThisGenre = movies.filter({ $0.genreId == genre.id }).first
//        }
        
        let newCharacter = Character(identifier: 1003, name: "Jae", realName: "Jay Hyuk", tagArray: ["여행", "음식"])
//        addCharacter(newCharacter: newCharacter)
        
        let allCharacters = realm.objects(CharacterObject.self).filter("name = '\(newCharacter.name)'")
        print(allCharacters)
        print(type(of: allCharacters))
    }
}

extension ViewController {
    func addCharacter(newCharacter: Character) {
        let container = try! Container()
        try! container.write { transaction in
            transaction.add(newCharacter, update: false)
        }
    }
    
    func updateCharacter(newCharacter: Character) {
        let container = try! Container()
        try! container.write { transaction in
            transaction.add(newCharacter, update: true)
        }
    }
    
    func isDuplicatedCharacter(realm: Realm, newCharacter: Character) -> Bool {
        let allCharacters = realm.objects(CharacterObject.self)
        for character in allCharacters {
            if character.identifier == newCharacter.identifier {
                return true
            }
        }
        return false
    }
}

public final class WriteTransaction {
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func add<T>(_ value: T, update: Bool) {
        realm.add(value.managedObject(), update: update)
    }
}

public final class Container {
    private let realm: Realm
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func write(_ block: (WriteTransaction) throws -> Void)
        throws {
            let transaction = WriteTransaction(realm: realm)
            try realm.write {
                try block(transaction)
            }
    }
}



final class CharacterObject: Object {
    @objc dynamic var identifier = 0
    @objc dynamic var name = ""
    @objc dynamic var realName = ""
    var tagList = List<String>()

    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    func listToArray(objectList: List<String>) -> [String] {
        var objectArray: [String] = []
        
        for object in objectList {
            objectArray.append(object)
        }
        
        return objectArray
    }
}

//struct Character {
//    public let identifier: Int
//    public let name: String
//    public let realName: String
//    public let tagArray: [String]
//
//    func arrayToList(objectArray: [String]) -> List<String> {
//        var objectList: List<String> = List<String>()
//
//        for object in objectArray {
//            objectList.append(object)
//        }
//
//        return objectList
//    }
//}
//
//public protocol Persistable {
//    associatedtype ManagedObject: RealmSwift.Object
//    init(managedObject: ManagedObject)
//    func managedObject() -> ManagedObject
//}
//
//extension Character: Persistable {
//    public init(managedObject: CharacterObject) {
//        identifier = managedObject.identifier
//        name = managedObject.name
//        realName = managedObject.realName
//        tagArray = managedObject.listToArray(objectList: managedObject.tagList)
//    }
//    public func managedObject() -> CharacterObject {
//        let character = CharacterObject()
//        character.identifier = identifier
//        character.name = name
//        character.realName = realName
//        character.tagList = arrayToList(objectArray: tagArray)
//        return character
//    }
//}
