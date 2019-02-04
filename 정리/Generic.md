# 제네릭

```
제네릭 함수
제네릭 타입
타입 제약
프로토콜의 연관 타입
제네릭 서브스크립트
```

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

## 제네릭 함수

- 타입에 상관없이 같은 타입인 두 변수의 값을 교환하기 위해서 제네릭 함수를 사용

- 실제 타입 이름을 써주는 대신, **플레이스홀더 T**를 사용함. `Dictionary<Key, Value>`, `Array<Element>` 와 같이 의미있는 이름 사용 가능

  ```swift
  func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
      let temporaryA: T = a
      a = b
      b = temporaryA
  }
  ```

## 제네릭 타입

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

## 타입 제약

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

## 프로토콜의 연관 타입

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

## 제네릭 서브스크립트

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

