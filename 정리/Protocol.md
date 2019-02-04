# Protocol

```
프로퍼티 / 메소드 / 가변 메소드 / 이니셜라이저 요구
프로토콜의 상속과 클래스 전용 프로토콜
프로토콜 조합과 프로토콜 준수 확인
프로토콜의 선택적 요구
프로토콜 변수와 상수
위임을 위한 프로토콜
```

- 프로토콜은 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의함

- **해당 프로토콜을 준수한다**고 표현함

- 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야함. 즉, 프로토콜은 정의를 하고 제시를 할 뿐이지 스스로 기능을 구현하지는 않음

  ```swift
  class SomeClass: SuperClass, AProtocol, AnotherProtocol {
      //SomeClass는 SuperClass를 상속받았으며 동시에 AProtocol과 AnotherProtocol 프로토콜을 채택한 클래스 이다.
  }
  ```

- 프로토콜은 타입이 특정 기능을 실행하기 위해 필요한 프로퍼티나 메서드와 같은 기능들을 요구함

## 프로퍼티 요구

- 프로토콜의 **프로퍼티 요구사항은 항상 var 키워드를 사용한 변수 프로퍼티로 정의**한다

- 읽기와 쓰기가 모두 가능한 프로퍼티는 프로퍼티의 정의 뒤에 { get set }이라고 명시한다

- 읽기 전용 프로퍼티는 프로퍼티의 정의 뒤에 { get }이라고 명시한다. 이런 경우, 읽기만 가능하다면 읽기, 쓰기 다 가능하게 구현해도 문제 되지 않음

- **타입 프로퍼티를 요구하려면 static 키워드를 사용하면 된다**. 클래스에서는 상속가능한 class와 상속불가능한 static으로 나뉘지만, **protocol에서는 두 타입 프로퍼티를 따로 구분하지 않고 모두 static 키워드를 사용함**

  ```swift
  protocol SomeProtocol {
      var settableProperty: String { get set }
      var notNeedToBeSettableProperty: String { get }
  }
  protocol AnotherProtocol {
      static var someTypeProperty: Int { get set }
      static var anotherTypeProperty: Int { get }
  }
  ```

- Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스

  ```swift
  protocol Sendable {
      var from: String { get }
      var to: String { get }
  }
  
  class Message: Sendable {
      var sender: String
      //read-only
      var from: String {
          return self.sender
      }
      
      var to: String
      
      init(sender: String, receiver: String) {
          self.sender = sender
          self.to = receiver
      }
  }
  
  class Mail: Sendable {
      var from: String
      var to: String
      
      init(sender: String, receiver: String) {
          self.from = sender
          self.to = receiver
      }
  }
  ```

## 메소드 요구

- 프로토콜은 특정 인스턴스 메소드나 타입 메소드를 요구할 수 있음

- 메소드의 이름, 매개변수, 반환 타입, 가변 매개변수 등을 명시할 수 있으나 **매개변수 기본값은 지정할 수 없음**

- 메소드를 요구할 때 **타입 메소드**를 명시하는 경우, **static과 class 키워드 구분 가능함**

- **프로토콜에서는 static 키워드를 통해서 타입 메소드를 요구했지만, 클래스에서 실제로 구현할 때 class 타입 메소드로 구현할지, static 타입 메소드로 구현할지는 프로토콜을 채택하여 사용하는 클래스의 특성에 따라 골라 사용하면 된다**

  ```swift
  protocol Receivable {
      func received(data: Any, from: Sendable)
  }
  
  protocol Sendable {
      var from: Sendable { get }
      var to: Receivable? { get }
      func send(data: Any)
      static func isSendableInstance(_ instance: Any) -> Bool
  }
  
  class Message: Sendable, Receivable {
      var from: Sendable {
          return self
      }
      
      //프로토콜은 프로퍼티, 변수, 상수 등의 타입으로 사용될 수 있음
      var to: Receivable?
      
      func send(data: Any) {
          guard let receiver: Receivable = self.to else {
              print("Message has no receiver")
              return
          }
          receiver.received(data: data, from: self.from)
      }
      
      func received(data: Any, from: Sendable) {
          print("Message received \(data) from \(from)")
      }
      
      class func isSendableInstance(_ instance: Any) -> Bool {
          if let sendableInstance: Sendable = instance as? Sendable {
              return sendableInstance.to != nil
          }
          return false
      }
  }
  ```

  ```swift
  let myPhoneMessage: Message = Message()
  let yourPhoneMessage: Message = Message()
  
  myPhoneMessage.send(data: "Hello")	//Message has no receiver
  
  //수신받을 Receivable 프로토콜을 준수하는 인스턴스 설정
  myPhoneMessage.to = yourPhoneMessage
  myPhoneMessage.send(data: "Hello")	//Message received Hello from Message
  
  //String은 Sendable 프로토콜을 준수하지 않음
  Message.isSendableInstance("Hello")	//false
  
  //Message는 Sendable 프로토콜을 준수함
  Message.isSendableInstance(myPhoneMessage)	//true
  ```

- 타입으로서의 프로토콜

  - 프로토콜은 요구만 하고 스스로 기능을 구현하지 않음. 하지만 프로토콜은 코드에서 완전한 하나의 타입으로 사용되기에 여러 위치에서 프로토콜을 타입으로 사용할 수 있음
  - 함수, 메소드, 이니셜라이저에서 매개변수 타입이나 반환 타입으로 사용될 수 있음
  - 프로퍼티, 변수, 상수 등의 타입으로 사용될 수 있음
  - 배열, 딕셔너리 등 컨테이너 요소의 타입으로 사용될 수 있음

## 가변 메소드 요구

- 프로토콜이 어떤 타입이든 간에 **인스턴스 내부의 값을 변경해야 하는 메소드를 요구**하려면 프로토콜의 메소드 정의 앞에 **mutating 키워드**를 명시해야함

- 참조 타입인 클래스의 메소드 앞에는 mutating 키워드를 명시하지 않아도 문제 없음

- 값 타입인 구조체와 열거형의 메소드 앞에는 mutating 키워드를 붙여야함

  ```swift
  protocol Resettable {
      mutating func resut()
  }
  
  class Person: Resettable {
      var name: String?
      var age: Int?
      
      func reset() {
          self.name = nil
          self.age = nil
      }
  }
  
  struct Point: Resettable {
      var x: Int = 0
      var y: Int = 0
      
      mutating func reset() {
          self.x = 1
          self.y = 1
      }
  }
  
  enum Direction: Resettable {
      case east, west, south, north, unknown
      
      mutating func reset() {
          self = Direction.unknown
      }
  }
  ```

- **만약 Resettable 프로토콜에서 가변 메소드를 요구하지 않는다면, 값 타입의 인스턴스 내부 값을 변경하는 mutating 메소드는 구현이 불가능함**

## 이니셜라이저 요구

- 이니셜라이저도 특별하게 요구할 수 있음

- 이니셜라이저 매개변수를 지정하기만 할 뿐 구현은 하지 않음

- 구조체는 프로토콜을 채택하여 요구 프로퍼티와 이니셜라이저를 모두 구현하면 되는데,

- **클래스의 경우에는 required 식별자를 붙인 요구 이니셜라이저로 구현해야한다. 클래스를 상속받는 모든 클래스는 프로토콜을 준수하고 이니셜라이저를 구현해야하기 때문**

  ```swift
  protocol Named {
      var name: String { get }
      init(name: String)
  }
  
  struct Pet: Named {
      var name: String
      init(name: String) {
          self.name = name
      }
  }
  ```

  ```swift
  class Person: Named {
      var name: String
      
      required init(name: String) {
          self.name = name
      }
  }
  ```

  - **클래스 자체가 상속받을 수 없는 final 클래스이면 required 식별자를 붙여줄 필요가 없음**

- **특정 클래스에 프로토콜이 요구하는 이니셜라이저가 이미 구현되어 있는 상황에서 그 클래스를 상속받은 클래스가 있다면, required와 override 식별자를 모두 명시해야함**

  - School 클래스의 이니셜라이저를 재정의해야하고, 동시에 Named 프로토콜의 이니셜라이저 요구를 만족해야하는 경우

  ```swift
  class School {
      var name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  class MiddleSchool: School, Named {
      required override init(name: String) {
          super.init(name: name)
      }
  }
  ```

- 실패가능한 이니셜라이저: 실패 가능한 이니셜라이저를 요구하는 프로토콜을 준수하는 타입은 해당 이니셜라이저를 구현할 때 실패 가능한 이니셜라이저로 구현해도, 일반적인 이니셜라이저로 구현해도 무방하다.

  ```swift
  protocol Named {
      var name: String { get }
      init?(name: String)
  }
  
  struct Animal: Named {
      var name: String
      
      init!(name: String) {
          self.name = name
      }
  }
  
  struct Pet: Named {
      var name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  class School: Named {
      var name: String
      
      required init?(name: String) {
          self.name = name
      }
  }
  ```

## 프로토콜의 상속과 클래스 전용 프로토콜

- 프로토콜은 하나 이상의 프로토콜을 상속받아 기존 프로토콜의 요구사항보다 더 많은 요구사항을 추가할 수 있음

- 프로토콜의 상속 리스트에 class 키워드를 추가해 프로토콜이 **클래스 타입에만 채택될 수 있도록 제한**할 수도 있음. 프로토콜의 상속 리스트의 맨 처음에 class 키워드가 위치해야함

  ```swift
  protocol ClassOnlyProtocol: class, Readable, Writeable {
      //요구사항
  }
  
  class SomeClass: ClassOnlyProtocol {
      func read() {}
      func write() {}
  }
  
  //class 타입에만 채택될 수 있기 때문에, 이거는 오류가 남
  struct SomeStruct: ClassOnlyProtocol {
      func read() {}
      func write() {}
  }
  ```

## 프로토콜 조합과 프로토콜 준수 확인

- 하나의 매개변수가 **여러 프로토콜을 모두 준수하는 타입**이어야 한다면, 하나의 매개변수에 여러 프로토콜을 한 번에 조합(Composition)하여 요구할 수 있음

- SomeProtocol & AnotherProtocol

- 하나의 매개변수가 프로토콜을 둘 이상 요구할 수도 있음

  ```swift
  protocol Named {
      var name: String { get }
  }
  
  protocol Aged {
      var age: Int { get }
  }
  
  struct Person: Named, Aged {
      var name: String
      var age: Int
  }
  
  class Car: Named {
      var name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  class Truck: Car, Aged {
      var age: Int
      
      init(name: String, age: Int) {
          self.age = age
          super.init(name: name)
      }
  }
  
  func celebrateBirthday(to celebrator: Named & Aged) {
      print("Happy birthday \(celebrator.name), Now you are \(celebrator.age)")
  }
  
  let yagom: Person = Person(name: "yagom", age: 99)
  celebrateBirthday(to: yagom)
  
  let myCar: Car = Car(name: "Boong Boong")
  //celebrateBirthday(to: myCar) //오류. Aged 프로토콜을 채택하지 않기 때문
  
  //오류, 클래스 & 프로토콜 조합에서 클래스 타입은 한 타입만 조합할 수 있음
  //var someVariable: Car & Truck & Aged
  
  //Car클래스 인스턴스이며 Aged 프로토콜을 준수하는 인스턴스만 할당 가능
  var someVariable: Car & Aged
  someVariable = Truck(name: "Truck", age: 5)
  ```

- 프로토콜 또한 하나의 타입이므로 is와 as연산자 사용 가능

  - is 연산자를 통해 해당 인스턴스가 특정 프로토콜을 준수하는지 확인

  - as? 다운캐스팅 연산자를 통해 다른 프로토콜로 다운캐스팅을 시도할 수 있음

  - as! 다운캐스팅 연산자를 통해 다른 프로토콜로 강제 다운캐스팅을 할 수 있음

    ```swift
    yagom is Named	//인스턴스가 준수하고 있으면 true
    yagom is Aged	//인스턴스가 준수하고 있으면 true
    
    if let castedInstance: Named = yagom as? Named {
        print("\(castedInstance) is Named")
    }
    ```

## 프로토콜의 선택적 요구

- 프로토콜의 요구사항 중 일부를 **선택적 요구사항으로 지정**할 수 있음.
  가령, UIApplicationDelegate의 메소드들은 옵셔널이라 구현을 하든 안 하든 상관이 없다

- 선택적 요구사항을 정의하고 싶은 프로토콜은 **@objc 속성**이 부여된 프로토콜이어야 한다

  - @objc 속성은 해당 프로토콜을 Objective-C 코드에서 사용할 수 있도록 만드는 역할
  - Objective-C 코드와 공유하고 싶지 않더라도 @objc 속성이 부여되어야만 선택적 요구사항을 정의할 수 있음
  - 그래서 @objc 속성이 부여되는 프로토콜은 Objective-C 클래스를 상속받은 클래스에서만 채택할 수 있음. 애플의 Foundation 프레임워크 모듈을 import해야함

- **Optional 식별자**를 요구사항의 정의 앞에 붙여주면 된다. 그러면 메소드 자체의 타입이 옵셔널이 된다

  - Tiger, Bird 클래스는 각각 Objective-C의 클래스인 NSObject를 상속 받음
  - Movable 프로토콜 변수에 할당되었을 때는 인스턴스의 타입에 실제로 fly() 메소드가 구현 되어 있는지 알 수 없으므로, 옵셔널 체인을 이용하여 fly() 메소드 호출을 시도함
  - 옵셔널 체인을 사용할 때는 메소드 이름 뒤에 물음표를 붙여 표현한다

  ```swift
  import Foundation
  
  @objc protocol Moveable {
      func walk()
      @objc optional func fly()
  }
  
  class Tiger: NSObject, Moveable {
      func walk() {
          print("Tiger walks")
      }
  }
  
  class Bird: NSObject, Moveable {
      func walk() {
          print("Bird walks")
      }
      
      func fly() {
          print("Bird flys")
      }
  }
  
  let tiger: Tiger = Tiger()
  let bird: Bird = Bird()
  
  tiger.walk()
  bird.walk()
  bird.fly()
  
  var movableInstance: Moveable = tiger
  movableInstance.fly?()	//nil
  
  movableInstance = bird
  movableInstance.fly?()	//Bird flys
  ```

## 프로토콜 변수와 상수

- 프로토콜 이름을 타입으로 갖는 변수 또는 상수에는, 그 프로토콜을 준수하는 타입의 어떤 인스턴스라도 할당 가능함

- Pet, Person, School 타입은 모두 Named 프로토콜을 준수하기 때문에 Named 프로토콜을 타입으로 갖는 변수 someNamed에 Pet, Person, School 타입의 인스턴스가 할당 가능함

  ```swift
  var someNamed: Named = Animal(name: "Animal")
  someNamed = Pet(name: "Pet")
  someNamed = Person(name: "Person")
  someNamed = School(name: "School")
  ```

## 위임을 위한 프로토콜

- Delegation, 위임은 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 디자인 패턴이다
  - UITableView 타입의 인스턴스가 해야하는 일을 위임받아 처리하는 인스턴스는 UITableViewDelegate 프로토콜을 준수하면 된다.
  - UITableViewDelegate 프로토콜을 준수하는 인스턴스는, UITableView의 인스턴스가 해야하는 일을 대신 처리해줄 수 있음

