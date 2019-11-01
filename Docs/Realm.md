# Realm

> ##### [How Reaml works](https://www.youtube.com/watch?v=PmsJW59rNY8)
> Realm Local DB, that means all of data that you create, store, retrieve, it's all locally on the device.
> How it's all store and managed is in this one file called Realm file.
> So when you creating data and you are saving it to your local database, what you are actually doing is opening up that Realm file and then you are putting data in there.
> And when you retrieve data, you also opening up this Realm file and you are grabbing data from there.

- 기본 사용 예제

  ```swift
  class ViewController: UIViewController {
  
      override func viewDidLoad() {
          super.viewDidLoad()
          
          let realm = try! Realm()
          //terminal에서 출력된 fileURL을 open 'fileURL' 입력하면 Realm Studio를 열 수 있음
          print(Realm.Configuration.defaultConfiguration.fileURL)
          
          var cat = Cat()
          cat.name = "Boss"
          cat.gender = "Male"
          cat.color = "Orange"
  
          try! realm.write {
              realm.add(cat)
          }
          
          let results = realm.objects(Cat.self).filter("color = 'Orange'")
          print(results.count)
      }
  }
  
  class Cat: Object {
      @objc dynamic var name: String?
      @objc dynamic var color: String?
      @objc dynamic var gender: String?
  }
  ```

- Realm 객체로 struct 데이터 타입을 사용하는 방법 및 array 타입 add 방법

  ```swift
  import UIKit
  import RealmSwift
  
  class ViewController: UIViewController {
  
      override func viewDidLoad() {
          super.viewDidLoad()
          
          let realm = try! Realm()
          print(Realm.Configuration.defaultConfiguration.fileURL)
          
          let newCharacter = Character(identifier: 1003, name: "Jay", realName: "Jay Hyuk", tagArray: ["여행", "음식"])
          addCharacter(newCharacter: newCharacter)
          
          var allCharacters = realm.objects(CharacterObject.self)
          print(allCharacters)
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
  
  struct Character {
      public let identifier: Int
      public let name: String
      public let realName: String
      public let tagArray: [String]
      
      func arrayToList(objectArray: [String]) -> List<String> {
          var objectList: List<String> = List<String>()
          
          for object in objectArray {
              objectList.append(object)
          }
          
          return objectList
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
  
  public protocol Persistable {
      associatedtype ManagedObject: RealmSwift.Object
      init(managedObject: ManagedObject)
      func managedObject() -> ManagedObject
  }
  
  extension Character: Persistable {
      public init(managedObject: CharacterObject) {
          identifier = managedObject.identifier
          name = managedObject.name
          realName = managedObject.realName
          tagArray = managedObject.listToArray(objectList: managedObject.tagList)
      }
      public func managedObject() -> CharacterObject {
          let character = CharacterObject()
          character.identifier = identifier
          character.name = name
          character.realName = realName
          character.tagList = arrayToList(objectArray: tagArray)
          return character
      }
  }
  
  public final class WriteTransaction {
      private let realm: Realm
      internal init(realm: Realm) {
          self.realm = realm
      }
      public func add<T: Persistable>(_ value: T, update: Bool) {
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
  ```
