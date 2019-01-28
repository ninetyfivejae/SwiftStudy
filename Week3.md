# Week3. POP 개요

- 3주차: 22일 화요일 저녁 서현역 카페 시간은 미정

```
3주차 - Protocol Oriented Programming 개요
- 상속에 관한 이야기
- Protocol 과 Extension
- 타입 캐스팅
- 제네릭 개요
```

```
Type Casting
- 기존 언어의 타입 변환 vs 스위프트의 타입 변환
- 데이터 타입 확인 연산자 is
- Metatype Type. 메타타입 타입
- 다운캐스팅
- Any, AnyObject의 타임캐스팅

제네릭
- 제네릭 함수
- 제네릭 타입
- 타입 제약
- 프로토콜의 연관 타입
- 제네릭 서브스크립트

Protocol
- 프로퍼티 / 메소드 / 가변 메소드 / 이니셜라이저 요구
- 프로토콜의 상속과 클래스 전용 프로토콜
- 프로토콜 조합과 프로토콜 준수 확인
- 프로토콜의 선택적 요구
- 프로토콜 변수와 상수
- 위임을 위한 프로토콜

Extension
- 연산 프로퍼티 / 메소드 / 이니셜라이저 / 서브스크립트 / 중첩 데이터 추가

UITableView / UICollectionView
- dequeueReusableCell 사용 이유
- Cell 재사용 시 주의사항

Segue
- performSegueWithIdentifer
- instantiateViewController
- Custom Segue
... 더 정리해야함
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
  - **이니셜라이저를 통해 새로운 인스턴스를 생성하는 과정**이라고 본다

  ```swift
  var value: Double = 3.3
  var convertedValue: Int = Int(value)
  convertedValue = 5.5
  ```

### 스위프트 타입캐스팅

- 스위프트 타입캐스팅: **인스턴스의 타입을 확인**하거나 **다른 타입의 인스턴스인양 행세를 할 수 있는 방법**을 사용할 수 있다

- **is와 as 연산자**: 이 두 연산자로 값의 타입을 확인하거나 다른 타입으로 전환할 수 있음. 또한 타입캐스팅을 통해 프로토콜을 준수하는지도 확인해볼 수 있음

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
  let coffee: Coffee = Coffee(shot: 1)
  let myCoffee: Americano = Americano(shot: 2, iced: false)
  let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
  
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

- **이런 캐스팅 작업은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아님. 인스턴스는 메모리에 똑같이 남아있지만, 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할지 판단할 수 있도록 컴퓨터에 힌트를 주는 것뿐이다.**

### Any, AnyObject의 타입캐스팅

- 스위프트에 특정 타입을 지정하지 않고 여러 타입의 값을 할당할 수 있는 Any와 AnyObject 타입이 있음

- **Any: 함수 타입을 포함한 모든 타입**

- **AnyObject: 클래스 타입만을 뜻함**

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

## 제네릭

- Array, Dictionary, Set 등의 타입 모두 제네릭 컬렉션

- 제네릭을 사용하는 이유

  - Any 타입을 사용하면 **매개변수의 타입이 Any인 경우에만** 값을 변경할 수 있음
  - Any 이외의 타입은 Any 타입 변수에 할당 후 변경해줘야한다
  - 그래서, String 타입의 변수 2개를 Any 타입의 변수에 값 복사 하여 값을 교환하기 때문에 **실제 변경하려는 String 변수의 값은 변하지 않는다.**

  ```swift
  var stringOne: String = "A"
  var stringTwo: String = "B"
  
  func swapTwoValues(_ a: inout Any, _ b: inout Any) {
      let temporaryA: Any = a
      a = b
      b = temporaryA
  }
  
  var anyOne: Any = 1
  var anyTwo: Any = "Two"
  swapTwoValues(&anyOne, &anyTwo)
  print("\(anyOne), \(anyTwo)")
  
  anyOne = stringOne
  anyTwo = stringTwo
  swapTwoValues(&anyOne, &anyTwo)
  print("\(anyOne), \(anyTwo)")
  print("\(stringOne), \(stringTwo)")
  
  //오류
  //swapTwoValues(&stringOne, &stringTwo)
  ```

### 제네릭 함수

- 타입에 상관없이 같은 타입인 두 변수의 값을 교환하기 위해서 제네릭 함수를 사용

- 실제 타입 이름을 써주는 대신, **플레이스홀더 T**를 사용함. `Dictionary<Key, Value>`, `Array<Element>` 와 같이 의미있는 이름 사용 가능

  ```swift
  func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
      let temporaryA: T = a
      a = b
      b = temporaryA
  }
  ```

### 제네릭 타입

- 제네릭 타입을 구현하면 사용자정의 타입인 구조체, 클래스, 열거형 등이 어떤 타입과도 연관되어 동작할 수 있음. Array와 Dictionary 타입이 자신의 요소로 모든 타입을 대상으로 동작할 수 있는 것과 유사함

  - 타입 매개변수를 Element로 두고 제네릭 구조체 Stack을 구현하게되면, 지정한 타입으로 계속 스택이 동작할 수 있음. Element 타입을 Any로도 설정을 할 수 있어서 유연하고 광범위하게 사용할 수 있음

  ```swift
  struct Stack<Element> {
      var items = [Element]()
      mutating func push(_ item: Element) {
          items.append(item)
      }
      mutating func pop() -> Element {
          return items.removeLast()
      }
  }
  
  var doubleStack: Stack<Double> = Stack<Double>()
  var stringStack: Stack<String> = Stack<String>()
  var anyStack: Stack<Any> = Stack<Any>()
  ```

- 제네릭 타입 확장

  - 제네릭을 사용하는 타입에 **익스텐션을 통해 기능을 추가하고자 한다면 익스텐션 정의에 타입 매개변수를 명시하지 않아야함**

  - 대신 원래의 제네릭 정의에 명시한 타입 매개변수를 익스텐션에서 사용할 수 있음

    ```swift
    extension Stack {
        var topElement: Element? {
            return self.items.last
        }
    }
    
    print(anyStack.topElement) //optional("test")
    ```

### 타입 제약

- 제네릭 기능의 타입 매개변수는 아무런 제약 없이 사용할 수 있다

  - 하지만 제네릭 함수가 처리해야 하는 기능이 특정 타입에 한정되어야하거나,
  - 제네릭 타입을 특정 프로토콜을 따르는 타입만 사용할 수 있도록 제약을 두어야하는 상황이 발생함

- 그래서 타입 매개변수가 가져야할 제약사항을 지정할 수 있도록 **타입 제약**을 줄 수 있음

  - **특정 클래스를 상속 받는 타입으로 지정하거나, 특정 프로토콜을 준수하는 타입으로 지정하는 제약을 줄 수 있음**
  - **타입 제약은 클래스 타입 또는 프로토콜로만 줄 수 있음**. 즉, 열거형, 구조체 등의 타입은 타입 제약의 타입으로 사용할 수 없음

  ```swift
  //매개변수 Key 타입은 Hashable 프로토콜을 준수해야한다는 뜻
  public struct Dictionary<Key: Hashable, Value>: Collection, ExpressibleByDictionaryLiteral {
      ...
  }
  ```

  ```swift
  //Element는 Hashable 프로토콜을 준수하기 때문에, Any 타입은 사용할 수 없음
  struct Stack<Element: Hashable> {
      ...
  }
  ```

  ```swift
  //여러 제약을 추가하고 싶다면 where절을 사용하여 추가하면 된다
  func swapTwoValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) where T: FloatingPoint, T: Equatable {
      ...
  }
  ```

  ```swift
  //프로토콜 타입 제약을 명시하지 않으면, (Binary operator '-' cannot be applied to two 'T' operands) 이런 오류가 난다
  func substractTwoValue<T: BinaryInteger>(_ a: T, _ b: T) -> T {
      return a - b
  }
  ```

### 프로토콜의 연관 타입

- **연관 타입은 프로토콜에서 사용할 수 있는 플레이스홀더 이름이다**

- 즉, 제네릭에서는 어떤 타입이 들어올지 모를 때, 타입 매개변수를 통해 '종료는 알 수 없지만, 어떤 타입이 여기에 쓰일 것이다'라고 표현해주었다면 연관 타입은 타입 매개변수의 그 역할을 프로토콜에서 실행할 수 있도록 만들어진 기능이다

  ```swift
  protocol Container {
      associatedtype ItemType
      var count: Int { get }
      mutating func append(_ item: ItemType)
      subscript(i: Int) -> ItemType { get }
  }
  ```

  - 컨테이너의 새로운 아이템을 append 메소드를 통해 추가할 수 있어야한다
  - 아이템 개수를 확인할 수 있도록 Int 타입을 갖는 count 프로퍼티를 구현해야한다
  - Int 타입의 인텍스 값으로 특정 인덱스에 해당하는 아이템을 가져올 수 있는 서브스크립트를 구현해야한다
  - 연관값 ItemType은 어떤 타입을 가져야하는지 명시하지 않아도 상관없음. 위 세 가지 조건만 충족하면 큰 문제 없음

  ```swift
  struct IntStack: Container {
      //ItemType을 어떤 타입으로 사용할지 더 명확히 지정해줌
      typealias ItemType = Int
      
      //기존 IntStack 구조체 구현
      var items = [ItemType]()
      mutating func push(_ item: ItemType) {
          items.append(item)
      }
      mutating func pop() -> ItemType {
          return items.removeLast()
      }
      
      //Container 프로토콜 준수를 위한 구현
      mutating func append(_ item: ItemType) {
          self.push(item)
      }
      var count: ItemType {
          return items.count
      }
      subscript(i: ItemType) -> ItemType {
          return items[i]
      }
  }
  ```

- 연관 타입과 타입 매개변수를 대응시킬 수 있음. Container의 ItemType 대신 Element를 사용하여 구현했음

  ```swift
  struct Stack<Element>: Container {
      var items = [Element]()
      mutating func push(_ item: Element) {
          items.append(item)
      }
      mutating func pop() -> Element {
          return items.removeLast()
      }
      
      //Container 프로토콜 준수를 위한 코드
      mutating func append(_ item: Element) {
          self.push(item)
      }
      var count: Int {
          retrn items.count
      }
      subscript(i: Int) -> Element {
          return items[i]
      }
  }
  ```

### 제네릭 서브스크립트

- 서브스크립트도 제네릭을 활용하여 타입에 큰 제한 없이 유연하게 구현할 수 있음

  - 서브스크립트는 Indices라는 플레이스홀더를 사용하여 매개변수를 제네릭하게 받아들일 수 있음
  - Indices는 Sequence 프로토콜을 준수하는 타입
  - `where Indices.Iterator.Element == Int`: Indices 타입 Iterator의 Element 타입이 Int 타입이어야하는 제약

  ```swift
  extension Stack {
      //여기서 ItemType은 Stack의 연관 타입이다
      //Indices는 subscript의 제네릭 타입
      subscript<Indices: Sequence>(indices: Indices) -> [ItemType] where Indices.Iterator.Element == Int {
          var result = [ItemType]()
          for index in indices {
              result.append(self[index])
          }
          return result
      }
  }
  
  var integerStack: Stack<Int> = Stack<Int>()
  integerStack.append(1)
  integerStack.append(2)
  integerStack.append(3)
  integerStack.append(4)
  integerStack.append(5)
  print(integerSTack[0...2])  //[1,2,3]
  ```

## Protocol

- 프로토콜은 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의함

- **해당 프로토콜을 준수한다**고 표현함

- 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야함. 즉, 프로토콜은 정의를 하고 제시를 할 뿐이지 스스로 기능을 구현하지는 않음

  ```swift
  class SomeClass: SuperClass, AProtocol, AnotherProtocol {
      //SomeClass는 SuperClass를 상속받았으며 동시에 AProtocol과 AnotherProtocol 프로토콜을 채택한 클래스 이다.
  }
  ```

- 프로토콜은 타입이 특정 기능을 실행하기 위해 필요한 프로퍼티나 메서드와 같은 기능들을 요구함

### 프로퍼티 요구

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

### 메소드 요구

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

### 가변 메소드 요구

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

### 이니셜라이저 요구

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

### 프로토콜의 상속과 클래스 전용 프로토콜

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

- extension으로 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가할 수 있음.
  타입만 알고 있다면 타입의 기능을 확장할 수 있음
- extension은 타입에 **새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없음**
- 클래스의 상속은 특정 타입을 물려받아 하나의 새로운 타입을 정의하고 추가 기능을 구현하는 수직 확장이지만, 익스텐션은 기존의 타입에 기능을 추가하는 수평 확장이다.
  상속은 재정의가 가능하지만, 익스텐션은 안 된다
- 스위프트의 extension이 타입에 추가할 수 있는 기능
  - 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
  - 타입 메소드 / 인스턴스 메소드
  - 이니셜라이저
  - 서브스크립트
  - 중첩 타입
  - 특정 프로토콜을 준수할 수 있도록 기능 추가

### 연산 프로퍼티 추가

- 저장 프로퍼티는 추가할 수 없음.

- 타입에 정의되어 있는 기존의 프로퍼티에 **프로퍼티 감시자를 추가할 수도 없음**

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
      
      static func isIntTypeInstance(_ instance: Any) -> Bool {
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

- 여러 종류의 이니셜라이저를 만들 수 있음.
  타입 정의 부분에 이니셜라이저를 추가하지 않다라도 익스텐션을 통해 이니셜라이저를 추가할 수 있음

- **익스텐션으로 클래스는 편의 이니셜라이즈는 추가할 수 있지만, 지정 이니셜라이저를 추가할 수 없음. 값 타입은 상관이 없음**

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

- 익스텐션으로 값 타입에 이니셜라이저를 추가했을 때, 해당 값 타입이 다음 조건을 모두 성립한다면 익스텐션으로 사용자정의 이니셜라이저를 추가한 이후에도 해당 타입의 **기본 이니셜라이저와 멤버와이즈 이니셜라이저**를 호출할 수 있음

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

## UITableView

1. ViewController에 TableView를 얹은 다음, UITableViewDelegate와 UITableViewDatasource 프로토콜을 채택하여 구현하는 방법

   - 스토리보드의 테이블뷰를 코드로 끌어와서 IBOutlet 프로퍼티로 지정해야함

   - ViewController 클래스가 UITableViewDelegate/Datasource 프로토콜을 준수해야함

   - 테이블뷰의 delegate, datasource가 ViewController 자신(self)임을 지정해야함

     - 저번시간 예제 코드

     ```swift
     import UIKit
     
     class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
         @IBOutlet weak var tableView: UITableView!
         
         var models: [Person] = [Person(profile: "Blah Blah", name: "Name 1", age: Int.random(in: 1...100), description: String.randomString()]
         
         override func viewDidLoad() {
             super.viewDidLoad()
             self.tableView.delegate = self
             self.tableView.dataSource = self
             
             //테이블뷰의 높이를 내용에 맞게 제각각으로 설정
             self.tableView.rowHeight = UITableView.automaticDimension
             self.tableView.estimatedRowHeight = 20
         }
         
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             //모델 배열에 있는 Person 객체만큼 section 생성
             return self.models.count
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             //CustomTableViewCell로 타입 변경하여 가져옴
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
                 return UITableViewCell()
             }
             
             cell.profileImageView.backgroundColor = .green
             cell.nameLabel.text = self.models[indexPath.row].name
             cell.ageLabel.text = String(self.models[indexPath.row].age)
             cell.descriptionLabel.text = self.models[indexPath.row].description
             
             return cell
         }
     }
     ...
     ```

2. 스토리보드에서 TableViewController와 새로 만든 UITableViewController 클래스를 연결시키는 방법

   - 스토리보드의 테이블뷰와 연결된 tableView 프로퍼티가 기본적으로 제공됨

   - 해당 TableViewController를 UITableViewController 클래스에 연결하면 delegate, datasource 자동으로 지정된다

     ```swift
     import UIKit
     
     class TableViewController: UITableViewController {
         
         @IBOutlet weak var numberOfObjectsLabel: UILabel!
         
         var data = ["First", "Second", "Third"]
     
         override func viewDidLoad() {
             super.viewDidLoad()
             
             numberOfObjectsLabel.text = "\(data.count)"
         }
     
         override func numberOfSections(in tableView: UITableView) -> Int {
             return 1
         }
     
         override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return data.count
         }
     
         override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
             let selectedItem = data[indexPath.row]
             print("Item \(selectedItem) selected")
         }
         
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
                 return UITableViewCell()
             }
             
             let cellData = data[indexPath.row]
             cell.customTextField.text = cellData
             print("Function call \(indexPath)")
     
             return cell
         }
     }
     ```

- override func tableView(_ tableView: UITableView, **cellForRowAt** indexPath: IndexPath) -> UITableViewCell {...}
  - 이 함수가 몇 번 호출되는지 확인해보면, **테이블뷰의 셀 갯수만큼 호출**이 되는 것을 알 수 있음
  - **또 화면에서 사라졌다가 다시 화면으로 셀이 보이게 되면 그때 다시 호출이 된다**
  - indexPath는 [section, row]로 이루어져 있는 행을 식별하는 상대적인 경로이다

### dequeueReusableCell 사용 이유

- dequeueReusableCell(withIdentifier:for:): Returns a reusable table-view cell object for the specified reuse identifier(TableViewCell의 identifier) and adds it to the table.

- 천 개, 만 개 이상의 항목(엔트리)을 가지는 테이블이 있을 때, 천 개의 엔트리를 셀마다 만들고 모든 테이블 뷰 셀에 대해 메모리 할당이 이루어지게된다. 이렇게 되면 메모리 낭비가 되기 때문에 효과적으로 메모리를 사용하기 위해서 dequeueReusableCell 사용한다.
- 이 dequeueReusableCell을 사용하게 되면 화면에서 보이는 테이블 뷰 셀만 메모리에 할당하면 된다. 그리고 스크롤하면 화면에는 여전히 동일한 셀이 사용되지만, 데이터소스(DataSource)를 기반으로 셀 내용이 바뀌게 된다. 셀이 스크롤 화면 밖으로 밀려나면, 이 셀은 reuse pool에 들어가게 되고, 우리가 dequeueReusableCell을 호출할 때 테이블 셀에 의해 반환이 된다.
- [Cell 재사용하는 경우와 그렇지 않은 경우 메모리 비교](https://medium.com/ios-seminar/why-we-use-dequeuereusablecellwithidentifier-ce7fd97cde8e)

### Cell 재사용 시 주의사항

- 말 그대로 Cell을 재사용하는 것이기 때문에 **이전에 사용하고 남은 흔적들**이 있을 수 있다.

- 이와 같은 문제를 방지하기 위해서는 **재사용될 때 속성 값이 초기화가 되어야한다**

- ![prepareForReuseImage](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/prepareReuseImage.png?raw=true)

- func tableView(**_** tableView: UITableView, cellForRowAt indexPath: IndexPath) 메소드는 Cell이 화면에 보여질 때마다 호출이 되는데, cell 재사용시 cell 객체가 재사용 가능하면 이 메소드 전에 prepareForReuse라는 메소드가 호출된다.

- 그래서 prepareForReuse 메소드에 cell 속성들을 재설정해주면 된다

  - If a `UITableViewCell` object is reusable, prepareForReuse method is invoked just before the object is returned from the `UITableView` method [`dequeueReusableCell(withIdentifier:)`](https://developer.apple.com/documentation/uikit/uitableview/1614891-dequeuereusablecell).
  - For performance reasons, you should only reset attributes of the cell that are not related to content, for example, alpha, editing, and selection state.
  - The table view's delegate in [`tableView(_:cellForRowAt:)`](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614861-tableview) should *always* reset all content when reusing a cell. If the cell object does not have an associated reuse identifier, this method is not called. If you override this method, you must be sure to invoke the superclass implementation.

  ```swift
  import UIKit
  
  class CustomTableViewCell: UITableViewCell {
  
      @IBOutlet weak var customTextField: UITextField!
      @IBOutlet weak var taskLabel: UILabel!
      @IBOutlet weak var checkLabel: UILabel!
      
      override func awakeFromNib() {
          super.awakeFromNib()
      }
  
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
      }
      
      override func prepareForReuse() {
          super.prepareForReuse()
          
          //Cell 초기화해주는 코드
          self.checkLabel.isHidden = false
      }
  }
  ```

- 출처: https://fluffy.es/solve-duplicated-cells/

## UICollectionView

- UITableView와 비슷함

  ```swift
  import UIKit
  
  private let reuseIdentifier = "Cell"
  
  class CollectionViewController: UICollectionViewController {
      
      var collectionData = ["1 🐶", "2 🐱", "3 🐭", "4 🐹", "5 🐰", "6 🦊", "7 🐻", "8 🐼", "9 🐨", "10 🐯"]
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      }
  
      override func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
  
      override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 100
      }
  
      override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionViewCell else {
              return UICollectionViewCell()
          }
          
          cell.customNameLabel.text = "✅"
  
          if indexPath.row % 2 == 0 {
              cell.customNameLabel.isHidden = true
          }
      
          return cell
      }
  }
  ```

  ```swift
  class CustomCollectionViewCell: UICollectionViewCell {
      
      @IBOutlet weak var customImageView: UIImageView!
      @IBOutlet weak var customNameLabel: UILabel!
      
      override func prepareForReuse() {
          super.prepareForReuse()
          
          self.customNameLabel.isHidden = false
      }
  }
  ```

- 마찬가지로 Cell 재사용 시 cell 속성 재설정해주는 부분 주의할 것

## Segue

- An object that prepares for and performs the visual transition between two view controllers.
- Segue: 화면 전환을 뜻함 / 세그웨이 사전적 의미: 하나에서 다른 것으로 부드럽게 넘어가다라는 뜻
- 종류
  - **show**: 화면에 보여지고 있는 마스터 또는 디테일 영역에 뷰를 로드한다. 마스터와 디테일 영역 모두 화면에 보여지고 있을 경우 로드되는 새로운 컨텐츠 뷰는 디테일 영역의 네비게이션 스택에 푸시된다. 마스터와 디테일 영역중 하나만 보여지고 있을 경우 현재 뷰컨트롤러 스택의 최상단에 푸시된다. 새 화면으로 이동하는데 Stack구조로서 새 화면이 원래 화면 위를 덮는 구조이다
  - **show detail**: show와 매우 비슷하지만 푸시가 아닌 교체(replace)된다는 점이 크게 다르다. 마스터와 디테일 영역 모두 화면에 보여지고 있을 경우 로드되는 뷰는 디테일 영역을 교체하게 되며 둘중 하나만 보여지고 있을 경우 현재 뷰컨트롤러 스택의 최상단 뷰를 교체하게 된다. SplitView 구조에서 원래 화면을 Master, 새 화면을 Detail로 표시한다. 아이폰에서는 똑같아 보이지만 아이패드로 보면 화면이 둘로 분할되서 보이게 된다.
  - **present modally**: 새로 로드하는 컨텐츠 뷰를 모달 형태로 띄운다. 원래 화면은 새 화면 뒤에 그대로 존재함. UIModalPresentationStyle 옵션을 이용하여 보여지는 스타일을 결정하거나 UIModalTransitionStyle 옵션을 사용하여 트랜지션 스타일을 설정할 수 있다.
  - **popover presentation**: iPad만 해당. 현재 보여지고 있는 뷰 위에 앵커를 가진 팝업 형태로 컨텐츠 뷰를 로드한다. UIPopoverArrowDirection 옵션을 사용하여 창에 붙어있는 엣지의 방향을 설정 할 수 있다.
  - **custom**: 사용자 정의 세그웨이를 만든다
- [참고, 가장 잘 정리해놓은 블로그 및 코드](https://digitalleaves.com/define-segues-programmatically/)
- [tip & tricks](https://medium.com/@biz84/ios-segues-tips-and-tricks-78847484d2ba)
- [segue trigger 되는 과정](https://soooprmx.com/archives/8873)

### [performSegueWithIdentifer](https://youtu.be/OZix7etsd8g)

- 메인 ViewController에서 이동할 ViewController swift 파일 생성. 여기에서는 SecondViewController.swift 파일 사용

  - 스토리보드에서 Custom class 파일 지정

- 스토리보드에서 드래그하여 segue 생성. Segue identifier 지정. SecondVCSegue & ThirdVCSegue라고 지정함

- 새로운 ViewController로 이동하기 위한 prepare 메소드 작성

  - segue identifier에 따라 이동할 ViewController와 작업 지정

  ```swift
  import UIKit
  class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
  
      ...
      
      override func viewDidLoad() {
          super.viewDidLoad()
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "SecondVCSegue" {
              if let secondVC = segue.destination as? SecondViewController {
                  secondVC.infoObject = "[Segue]: Hello, World!"
              }
          } else if segue.identifier == "ThirdVCSegue" {
              if let secondVC = segue.destination as? SecondViewController {
                  secondVC.infoObject = "Username: \(userNameField.text!)\nPassword: \(passwordField.text!)\nPhone Number: \(phoneNumberField.text!)"
              }
          }
      }
  }
  ```

- SecondViewController.swift / 두 번째 ViewController

  - 속성 변경하기 위한 설정

  ```swift
  import UIKit
  class SecondViewController: UIViewController {
      
      @IBOutlet weak var informationLabel: UILabel!
      var infoObject: String?
  
      @IBOutlet weak var dataTextView: UITextView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          if infoObject != nil {
              informationLabel.text = infoObject
              dataTextView.text = infoObject
          }
      }
  }
  ```

- 데이터 전달 시 주의사항

  - Prepare 메소드에서 생성되지 않은 view의 속성을 변경하려고 하면 오류가 난다.

  - infoObject라는 변수에 값을 담아두고 ViewController의 viewDidLoad 메소드 호출 시 할당을 해주면 된다

  - The order of the last steps might vary slightly. However, what never changes is that prepareForSegue: is always called after the destination view controller has been initialized, and just before its viewDidLoad method is invoked.

    Why is this important? Because if you are defining a property of the destination view controller, you will only be able to use it from viewDidLoad, not before. Thus, generally speaking, you can use a property passed through a segue in viewDidLoad, viewWillAppear and viewDidAppear safely.

    ![lifeCycleOfViewControllersDuringSegues](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/lifeCycleOfViewControllersDuringSegues.png?raw=true)

### [instantiateViewController](https://youtu.be/-Rsr3hoSRes)

- 메인 ViewController에서 이동할 ViewController swift 파일 생성. 여기에서는 SecondViewController.swift 파일 사용

  - 스토리보드에서 Custom class 파일 지정
  - ViewController의 storyboard id 지정. instantiateViewController메소드 사용 시 필요. instanSecondVC로 지정했음

- 새로운 ViewController를 present할 액션 생성

  - ViewController.swift / 첫 번째 ViewController의 present할 액션 메소드

  ```swift
  @IBAction func triggerOption(_ sender: Any) {
          let button = sender as! UIButton
          
          if button.titleLabel?.text == "Option1" {
              let sb = UIStoryboard(name: "Main", bundle: nil)
              if let secondVC = sb.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController {
                  secondVC.infoObject = "Hello, World!"
                  self.present(secondVC, animated: true, completion: nil)
                  //secondVC.informationLabel.text = "Hello, World!"
              }
          } else if button.tag == 2 {
              print("Option2 pressed")
          } else if button.tag == 3 {
              print("Option3 pressed")
          }
      }
  ```

- SecondViewController.swift / 두 번째 ViewController

  - 다시 이전 ViewController로 돌아갈 dismiss 수행을 위한 goBack 메소드 설정

  ```swift
  import UIKit
  class SecondViewController: UIViewController {
      
      @IBOutlet weak var informationLabel: UILabel!
      var infoObject: String?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          if infoObject != nil {
              informationLabel.text = infoObject
          }
      }
      
      @IBAction func goBack(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
      }
  }
  ```

- 데이터 전달 시 주의사항

  - present 하는 메소드에서 생성되지 않은 informationLabel의 text를 변경하려고 하면 오류가 난다.
  - 그래서 present메소드 이후에 속성을 변경하거나,
  - infoObject라는 변수에 값을 담아두고 ViewController의 viewDidLoad 메소드 호출 시 할당을 해주면 된다

- Segue를 이용한 ViewController 전환과 다른 점

  - asdf

### [Custom Segue](https://www.youtube.com/watch?v=jn-93qElOT4)

- CustomSegue클래스 생성

  - override	perform 메소드

  - Custom 액션 구현

    ```swift
    import UIKit
    class CustomScaleSegue: UIStoryboardSegue {
        override func perform() {
            scale()
        }
        
        func scale() {
            let toViewController = self.destination
            let fromViewController = self.source
            
            let containerView = fromViewController.view.superview
            let originalCenter = fromViewController.view.center
            
            toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            toViewController.view.center = originalCenter
            
            containerView?.addSubview(toViewController.view)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                toViewController.view.transform = CGAffineTransform.identity
            }, completion: { success in
                fromViewController.present(toViewController, animated: false, completion: nil)
            })
        }
    }
    ```

- 스토리보드에서 custom segue로 연결 후 직접 구현한 CustomSegue 클래스 설정

- 다시 돌아가는 CustomSegue도 구현하고 적용하기 위해서, 다시 돌아갈 ViewController클래스에 prepareForUnwind 함수 구현해줘야 액션을 ViewController exit과 연결시킬 수 있음.

- Unwind 메소드 override해서 직접 구현한 CustomUnwindSegue 메소드를 호출함

  ```swift
      @IBAction func prepareForUnwind (segue: UIStoryboardSegue) {
          
      }
      
      override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
          let segue = CustomUnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
          segue.perform()
      }
  ```

- 