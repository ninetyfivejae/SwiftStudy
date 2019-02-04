# Extension

```
연산 프로퍼티
메소드
이니셜라이저
서브스크립트
중첩 데이터 추가
```

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

## 연산 프로퍼티 추가

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

## 메소드 추가

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

## 이니셜라이저 추가

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

## 서브스크립트 추가

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

## 중첩 데이터 삽입

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

