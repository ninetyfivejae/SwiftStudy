## Week3. POP 개요

- 3주차: 22일 화요일 저녁 서현역 카페 시간은 미정

```
3주차 - POP 개요
- 상속에 관한 이야기
- Protocol 과 Extension
- 타입 캐스팅
- 제네릭 개요
+ Swift 기본 패턴
- Delegate
- KVO

실습
- UITableView, UICollectionView
- UINavigation 및 화면 transition
```

```
공통
- 프로토콜, 익스텐션
- 제네릭 개요 및 타입 캐스팅, as 키워드

지호
- segue란?
- show, show detail, present modally, pop over presentation, custom

재혁
- 테이블뷰, 콜렉션뷰 셀 재사용, dequeueResusable ~~
- 장점 및 주의할 점

복습 및 형이 보내준 링크 공부. 오토 레이아웃 디멘션
```

## Type Casting

### 기존 언어의 타입 변환 vs 스위프트의 타입 변환

- C언어

  - 타입 변환: 부동소수 타입인 double에서 정수 타입인 int로 데이터 타입을 변경

  ```swift
  #include<stdio.h>
    
  int main(int argc, char **argv){
          double value = 3.3;
          int convertedValue = (int)value;
          printf("%d ", convertedValue);
          convertedValue = 5.5; //암시적인 데이터 타입 변환
          printf("%d ", convertedValue);
          return 0;
  }
  //3 5
  ```

- Swift

  - 스위프트에서는 이를 타입 변환 혹은 타입캐스팅이라고 칭하지 않음
  - 이니셜라이저를 통해 새로운 인스턴스를 생성하는 과정이라고 본다

  ```swift
  var value: Double = 3.3
  var convertedValue: Int = Int(value)
  convertedValue = 5.5
  ```

### 스위프트 타입캐스팅

- 스위프트 타입캐스팅: 인스턴스의 타입을 확인하거나 자신을 다른 타입의 인스턴스인양 행세를 할 수 있는 방법을 사용할 수 있다

- is와 as 연산자: 이 두 연산자로 값의 타입을 확인하거나 다른 타입으로 전환할 수 있음. 또한 타입캐스팅을 통해 프로토콜을 준수하는지도 확인해볼 수 있음

- Coffee 클래스와 Coffee클래스를 상속받은 Latte, Americano 클래스

  - Latte나 Americano는 Coffee인 척할 수 있음. Latte나 Americano는 Coffee가 갖는 특성을 모두 갖기 때문

  ```swift
  class Coffee {
      let name: String
      let shot: Int
      
      var description: String {
          return "\(shot) shots \(name)"
      }
      
      init(shot: Int) {
          self.shot = shot
          self.name = "coffee"
      }
  }
  
  class Latte: Coffee {
      var flavor: String
      
      override var description: String {
          return "\(shot) shots \(flavor) latte"
      }
      
      init(flavor: String, shot: Int) {
          self.flavor = flavor
          super.init(shot: shot)
      }
  }
  
  class Americano: Coffee {
      let iced: Bool
      
      override var description: String {
          return "\(shot) shots \(iced ? "iced" : "hot") americano"
      }
      
      init(shot: Int, iced: Bool) {
          self.iced = iced
          super.init(shot: shot)
      }
  }
  ```

### 데이터 타입 확인 연산자 is

- 인스턴스가 해당 클래스의 인스턴스거나 그 자식클래스의 인스턴스라면 true를 반환하고, 그렇지 않다면 false를 반환함

- is 연산자는 클래스의 인스턴스뿐만 아니라 모든 데이터 타입에 사용할 수 있음

- 데이터 타입 확인

  ```swift
  let coffee: Coffee = Coffee(shot: 1)
  print(coffee.description)	//1 shots coffee
  
  let myCoffee: Americano = Americano(shot: 2, iced: false)
  print(myCoffee.description)	//2 shots hot americano
  
  let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
  print(yourCoffee.description)	//3 shots green tea latte
  
  print(coffee is Coffee)		//true
  print(coffee is Americano)	//false
  print(coffee is Latte)		//false
  
  print(myCoffee is Coffee)	//true
  print(yourCoffee is Coffee)	//true
  
  print(myCoffee is Latte)	//false
  print(yourCoffee is Latte)	//true
  ```

### Metatype Type. 메타타입 타입

- 타입의 타입

- 클래스 타입, 구조체 타입, 열거형 타입, 프로토콜 타입 등의 타입의 타입

- 타입의 이름 뒤에 .Type을 붙이면 메타 타입을 나타냄

- 프로토콜 타입 뒤에 .Protocol을 붙이면 프로토콜 타입의 메타 타입을 나타냄

- self를 사용하여 타입을 값처럼 표현할 수 있음

- 정의된 SomeClass, SomeProtocol 등의 메타 타입이 하나의 값으로 취급되어 someType 변수에 할당될 수 있음

- 인스턴스 self와 타입 self의 의미

  - .self 표현을 값 뒤에 써주면 그 값 자신을 표현함. "stringValue".self는 "stringValue" 그 자체를 나타냄
  - .self 표현을 타입 이름 뒤에 써주면 타입을 표현하는 값을 반환함. String.self는 String 타입을 나타내는 값

  ```swift
  protocol SomeProtocol {}
  class SomeClass: SomeProtocol {}
  
  let intType: Int.Type = Int.self
  let stringType: String.Type = String.self
  let classType: SomeClass.Type = SomeClass.self
  let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self
  
  var someType: Any.Type = intType
  someType = intType
  print(someType)			//Int
  
  someType = stringType
  print(someType)			//String
  
  someType = classType
  print(someType)			//SomeClass
  
  someType = protocolProtocol
  print(someType)			//SomeProtocol
  ```

  ```swift
  print(type(of: coffee) == Coffee.self)		//true
  print(type(of: coffee) == Americano.self)
  print(type(of: coffee) == Latte.self)
  
  print(type(of: coffee) == Americano.self)
  print(type(of: myCoffee) == Americano.self)	//true
  print(type(of: yourCoffee) == Americano.self)
  
  print(type(of: coffee) == Latte.self)
  print(type(of: myCoffee) == Latte.self)
  print(type(of: yourCoffee) == Latte.self)	//true
  ```

### 다운캐스팅

- 아래와 같은 상황에서 actingConstant가 참조하는 인스턴스를 진짜 타입인 Latte 타입으로 사용해야할 때가 있음. 가령 Latte 타입에 정의되어 있는 메소드를 사용하거나 프로퍼티에 접근해야 할 때 Latte 타입으로 변수의 타입을 변환해주어야함

  ```swift
  let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
  print(actingConstant.description)
  ```

- 자식클래스보다 더 상위에 있는 부모클래스의 타입을 자식클래스의 타입으로 캐스팅한다고 해서 다운캐스팅이라고함

- 클래스의 인스턴스뿐만 아니라, Any 타입 등에서 다른 타입으로 캐스팅할 때도 다운캐스팅을 사용함.

- as?

  - 다운캐스팅 실패의 여지가 충분히 있기 때문에 사용하고 실패했을 경우 nil을 반환. 옵셔널 반환 타입

- as!

  - 다운캐스팅에 실패할 경우 런타임 오류 발생

  ```swift
  //let coffee: Coffee = Coffee(shot: 1)
  //let myCoffee: Americano = Americano(shot: 2, iced: false)
  //let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
  
  if let actingOne: Americano = coffee as? Americano {
      print("This is Americano")
  } else {
      print(coffee.description)
  }
  //1 shots coffee
  
  if let actingOne: Latte = coffee as? Latte {
      print("This is Latte")
  } else {
      print(coffee.description)
  }
  //1 shots coffee
  
  if let actingOne: Coffee = coffee as? Coffee {
      print("This is Just Coffee")
  } else {
      print(coffee.description)
  }
  //This is Just Coffee
  
  if let actingOne: Americano = myCoffee as? Americano {
      print("This is Americano")
  } else {
      print(coffee.description)
  }
  //This is Americano
  
  if let actingOne: Latte = myCoffee as? Latte {
      print("This is Latte")
  } else {
      print(coffee.description)
  }
  //1 shots coffee
  
  if let actingOne: Coffee = myCoffee as? Coffee {
      print("This is Just Coffee")
  } else {
      print(coffee.description)
  }
  //This is Just Coffee
  ```

  ```swift
  let castedCoffee: Coffee = yourCoffee as! Coffee
  
  //let castedAmericano: Americano = coffee as! Americano //런타임 오류
  ```

- 이런 캐스팅 작업은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아님. 인스턴스는 메모리에 똑같이 남아있음. 다만 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할지 판단할 수 있도록 컴퓨터에 힌트를 주는 것뿐

### Any, AnyObject의 타임캐스팅

- 스위프트에 특정 타입을 지정하지 않고 여러 타입의 값을 할당할 수 있는 Any와 AnyObject 타입이 있음

- Any는 함수 타입을 포함한 모든 타입

- AnyObject는 클래스 타입만을 뜻함

  ```swift
  func checkType(of item: AnyObject) {
      if item is Latte {
          print("item is Latte")
      } else if item is Americano {
          print("item is Americano")
      } else {
          print("Unknown Type")
      }
  }
  
  checkType(of: myCoffee)
  checkType(of: yourCoffee)
  ```

  ```swift
  func castTypeToAppropriate(item: AnyObject) {
      if let castedItem: Latte = item as? Latte {
          print(castedItem.description)
      } else if let castedItem: Americano = item as? Americano {
          print(castedItem.description)
      } else {
          print("Unknown Type")
      }
  }
  
  castTypeToAppropriate(item: myCoffee)
  castTypeToAppropriate(item: yourCoffee)
  ```

- Any 타입은 모든 값 타입을 표현함. 더불어 옵셔널 타입도 표현할 수 있음. 근데 Any타입의 값이 들어와야할 자리에 옵셔널 타입의 값이 위치한다면 스위프트 컴파일러는 경고를 함. 의도적으로 옵셔널 값을 Any 타입의 값으로 사용하고자 한다면 as 연산자를 사용하여 명시적 타입 캐스팅을 해주면 경고 메세지를 받지 않음

  ```swift
  let optionalValue: Int? = 100
  print(optionalValue)		//컴파일러 경고 발생
  print(optionalValue as Any)	//경고 없음
  ```

## Protocol

- 프로토콜은 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의함

- 해당 프로토콜을 준수한다고 표현함

- 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야함. 즉, 프로토콜은 정의를 하고 제시를 할 뿐이지 스스로 기능을 구현하지는 않음

  ```swift
  class SomeClass: SuperClass, AProtocol, AnotherProtocol {
      //SomeClass는 SuperClass를 상속받았으며 동시에 AProtocol과 AnotherProtocol 프로토콜을 채택한 클래스 이다.
  }
  ```

- 프로토콜은 타입이 특정 기능을 실행하기 위해 필요한 프로퍼티나 메서드와 같은 기능들을 요구함

### 프로퍼티 요구

- 프로토콜의 프로퍼티 요구사항은 항상 var 키워드를 사용한 변수 프로퍼티로 정의한다

- 읽기와 쓰기가 모두 가능한 프로퍼티는 프로퍼티의 정의 뒤에 { get set }이라고 명시한다

- 읽기 전용 프로퍼티는 프로퍼티의 정의 뒤에 { get }이라고 명시한다. 이런 경우, 읽기만 가능하다면 읽기, 쓰기 다 가능해도 문제가 되지 않음

- 타입 프로퍼티를 요구하려면 static 키워드를 사용하면 된다. 클래스에서는 상속가능한 class와 상속불가능한 static으로 나뉘지만, protocol에서는 두 타입 프로퍼티를 따로 구분하지 않고 모두 static 키워드를 사용함

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

### 메소드 요구

- 프로토콜은 특정 인스턴스 메소드나 타입 메소드를 요구할 수 있음

- 메소드의 이름, 매개변수, 반환 타입, 가변 매개변수 등을 명시할 수 있으나, 매개변수 기본값은 지정할 수 없음

- 메소드를 요구할 때 타입 메소드를 명시하는 경우, static과 class 키워드 구분 가능함

- 프로토콜에서는 static 키워드를 통해서 타입 메소드를 요구했지만 클래스에서 실제로 구현할 때 class 타입 메소드로 구현할지, static 타입 메소드로 구현할지는 프로토콜을 채택하여 사용하는 클래스의 특성에 따라 골라 사용하면 된다

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

### 가변 메소드 요구

- 프로토콜이 어떤 타입이든 간에 인스턴스 내부의 값을 변경해야 하는 메소드를 요구하려면 프로토콜의 메소드 정의 앞에 mutating 키워드를 명시해야함

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

- 만약 Resettable 프로토콜에서 가변 메소드를 요구하지 않는다면, 값 타입의 인스턴스 내부 값을 변경하는 mutating 메소드는 구현이 불가능함

### 이니셜라이저 요구

- 이니셜라이저도 특별하게 요구할 수 있음

- 이니셜라이저 매개변수를 지정하기만 할 뿐 구현은 하지 않음

- 구조체는 프로토콜을 채택하여 요구 프로퍼티와 이니셜라이저를 모두 구현하면 되는데, 클래스의 경우에는 required 식별자를 붙인 요구 이니셜라이저로 구현해야한다. 클래스를 상속받는 모든 클래스는 프로토콜을 준수하고 이니셜라이저를 구현해야하기 때문

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

  - 클래스 자체가 상속받을 수 없는 final 클래스이면 required 식별자를 붙여줄 필요가 없음

- 특정 클래스에 프로토콜이 요구하는 이니셜라이저가 이미 구현되어 있는 상황에서 그 클래스를 상속받은 클래스가 있다면, required와 override 식별자를 모두 명시해야함

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

- 실패가능한 이니셜라이저

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

### 프로토콜의 상속과 클래스 전용 프로토콜

- 프로토콜은 하나 이상의 프로토콜을 상속받아 기존 프로토콜의 요구사항보다 더 많은 요구사항을 추가할 수 있음

- 프로토콜의 상속 리스트에 class 키워드를 추가해 프로토콜이 클래스 타입에만 채택될 수 있도록 제한할 수도 있음. 프로토콜의 상속 리스트의 맨 처음에 class 키워드가 위치해야함

  ```swift
  protocol ClassOnlyProtocol: class, Readable, Writeable {
      //요구사항
  }
  
  class SomeClass: ClassOnlyProtocol {
      func read() {}
      func write() {}
  }
  
  //이거는 오류가 남
  struct SomeStruct: ClassOnlyProtocol {
      func read() {}
      func write() {}
  }
  ```

### 프로토콜 조합과 프로토콜 준수 확인

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

### 프로토콜의 선택적 요구

- 프로토콜의 요구사항 중 일부를 선택적 요구사항으로 지정할 수 있음

- 가령, UIApplicationDelegate의 메소드들은 옵셔널이라 구현을 하든 안 하든 상관이 없다

- 선택적 요구사항을 정의하고 싶은 프로토콜은 @objc 속성이 부여된 프로토콜이어야 한다

  - @objc 속성은 해당 프로토콜을 Objective-C 코드에서 사용할 수 있도록 만드는 역할
  - Objective-C 코드와 공유하고 싶지 않더라도 @objc 속성이 부여되어야만 선택적 요구사항을 정의할 수 있음
  - 그래서 @objc 속성이 부여되는 프로토콜은 Objective-C 클래스를 상속받은 클래스에서만 채택할 수 있음. 애플의 Foundation 프레임워크 모듈을 import해야함

- Optional 식별자를 요구사항의 정의 앞에 붙여주면 된다. 그러면 메소드 자체의 타입이 옵셔널이 된다

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

### 프로토콜 변수와 상수

- 프로토콜 이름을 타입으로 갖는 변수 또는 상수에는, 그 프로토콜을 준수하는 타입의 어떤 인스턴스라도 할당 가능함

- Pet, Person, School 타입은 모두 Named 프로토콜을 준수하기 때문에 Named 프로토콜을 타입으로 갖는 변수 someNamed에 Pet, Person, School 타입의 인스턴스가 할당 가능함

  ```swift
  var someNamed: Named = Animal(name: "Animal")
  someNamed = Pet(name: "Pet")
  someNamed = Person(name: "Person")
  someNamed = School(name: "School")
  ```

### 위임을 위한 프로토콜

- Delegation, 위임은 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 디자인 패턴이다
  - UITableView 타입의 인스턴스가 해야하는 일을 위임받아 처리하는 인스턴스는 UITableViewDelegate 프로토콜을 준수하면 된다.
  - UITableViewDelegate 프로토콜을 준수하는 인스턴스는, UITableView의 인스턴스가 해야하는 일을 대신 처리해줄 수 있음

## Extension

- extension으로 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가할 수 있음. 타입만 알고 있다면 타입의 기능을 확장할 수 있음
- extension은 타입에 새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없음
- 클래스의 상속은 특정 타입을 물려받아 하나의 새로운 타입을 정의하고 추가 기능을 구현하는 수직 확장이지만, 익스텐션은 기존의 타입에 기능을 추가하는 수평 확장이다. 상속은 재정의가 가능하지만, 익스텐션은 안 된다
- 스위프트의 extension이 타입에 추가할 수 있는 기능
  - 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
  - 타입 메소드 / 인스턴스 메소드
  - 이니셜라이저
  - 서브스크립트
  - 중첩 타입
  - 특정 프로토콜을 준수할 수 있도록 기능 추가

### 연산 프로퍼티 추가

- 저장 프로퍼티는 추가할 수 없음.

- 타입에 정의되어 있는 기존의 프로퍼티에 프로퍼티 감시자를 추가할 수도 없음

  ```swift
  extension Int {
      var isEven: Bool {
          return self % 2 == 0
      }
      
      var isOdd: Bool {
          return self % 1 == 0
      }
  }
  
  1.isEven	//false
  2.isEven	//true
  
  var number: Int = 3
  number.isEven	//false
  number.isOdd	//true
  ```

### 메소드 추가

- ```swift
  extension Int {
      func multiply(by n: Int) -> Int {
          return self * n
      }
      //가변 메소드
      mutating func multiplySelf(by n: Int) {
          self = self.multiply(by: n)
      }
      
      static func isIntTyeInstance(_ instance: Any) -> Bool {
          return instance is Int
      }
  }
  
  3.multiply(by: 2)
  4.multiply(by: 5)
  
  var number: Int = 3
  
  number.multiplySelf(by: 2)
  print(number)
  
  number.multiplySelf(by: 3)
  print(number)
  
  Int.isIntTyeInstance(number)
  Int.isIntTyeInstance(3)
  Int.isIntTyeInstance(3.0)
  Int.isIntTyeInstance("3")
  ```

### 이니셜라이저 추가

- 여러 종류의 이니셜라이저를 만들 수 있음. 타입 정의 부분에 이니셜라이저를 추가하지 않다라도 익스텐션을 통해 이니셜라이저를 추가할 수 있음

- 익스텐션으로 클래스는 편의 이니셜라이즈는 추가할 수 있지만, 지정 이니셜라이저를 추가할 수 없음. 값 타입은 상관이 없음

  ```swift
  extension String {
      init(intTypeNumber: Int) {
          self = "\(intTypeNumber)"
      }
      
      init(doubleTypeNumber: Double) {
          self = "\(doubleTypeNumber)"
      }
  }
  
  let stringFromInt: String = String(intTypeNumber: 100)
  let stringFromDouble: String = String(doubleTypeNumber: 100.0)
  
  class Person {
      var name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  extension Person {
      convenience init() {
          self.init(name: "Unknown")
      }
  }
  
  let someOne: Person = Person()
  print(someOne.name)
  ```

- 익스텐션으로 값 타입에 이니셜라이저를 추가했을 때, 해당 값 타입이 다음 조건을 모두 성립한다면 익스텐션으로 사용자정의 이니셜라이저를 추가한 이후에도 해당 타입의 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 호출할 수 있음

  1. 모든 저장 프로퍼티에 기본값이 있음

  2. 타입에 기본 이니셜라이저와 멤버와이즈 이니셜라이저 외에 추가 사용자 정의 이니셜라이저가 없음

  - 아래 Size와 Point 구조체의 모든 저장 프로퍼티는 기본값을 가지며, 추가로 사용자 정의 이니셜라이저를 구현하지 않았기 때문에 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 사용할 수 있음

  ```swift
  struct Size {
      var width: Double = 0.0
      var height: Double = 0.0
  }
  
  struct Point {
      var x: Double = 0.0
      var y: Double = 0.0
  }
  
  struct Rect {
      var origin: Point = Point()
      var size: Size = Size()
  }
  
  let defaultRect: Rect = Rect()
  let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
  
  extension Rect {
      init(center: Point, size: Size) {
          let originX: Double = center.x - (size.width / 2)
          let originY: Double = center.y - (size.height / 2)
          self.init(origin: Point(x: originX, y: originY), size: size)
      }
  }
  
  let centerRect: Rect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
  ```

### 서브스크립트 추가

- ```swift
  extension String {
      subscript(appedValue: String) -> String {
          return self + appedValue
      }
      
      subscript(repeatCount: UInt) -> String {
          var str: String = ""
          
          for _ in 0..<repeatCount {
              str += self
          }
          
          return str
      }
  }
  
  print("abc"["def"])		//abcdef
  print("abc"[3])			//abcabcabc
  ```

### 중첩 데이터 삽입

- Nested Types

  ```swift
  extension Int {
      enum Kind {
          case negative, zero, positive
      }
      
      var kind: Kind {
          switch self {
          case 0:
              return .zero
          case let x where x > 0:
              return .positive
          default:
              return .negative
          }
      }
  }
  
  print(1.kind)
  print(0.kind)
  print((-1).kind)
  
  func printIntegerKinds(numbers: [Int]) {
      for number in numbers {
          switch number.kind {
          case .negative:
              print("- ", terminator: "")
          case .zero:
              print("0 ", terminator: "")
          case .positive:
              print("+ ", terminator: "")
          }
      }
      print()
  }
  
  printIntegerKinds(numbers: [3, 19, -27, 0, -6, 0, 7])
  ```

## Segue

- 

## UITableView, UICollectionView

- 셀 재사용에 대하여
- 장점 및 주의할 점

## 추가 정리

### 인스턴스 생성 및 소멸

- 정리는 나중에, 책 읽고 먼저 이해하기

### 상속

- 정리는 나중에, 책 읽고 먼저 이해하기

### 옵셔널 체이닝

- 

### 빠른종료. guard

- `guard`도 `if`나 `switch` 같은 조건문을 만드는 데 쓰인다. 독특한 점은 항상 `else`를 동반한다
- 

### KVO

- 