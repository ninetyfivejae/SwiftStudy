## Week1. Swift에서 타입이란,

- 1주차
  - property 차이점 등등 자세하게, 자유롭게 정리해서 설명
    컬렉션 타입 3가지에 대한 차이점을 정리 설명
    값타입 참조타입 등등 차이점에 대해서
    optional / optional binding에 대한 설명
  - 토요일까지 과제
    - 상수와 변수, 함수 정의 및 사용법 (필수)
    - Property(Stored, Computed, Class) (필수)

    - 콜렉션(Array, Dictionary, Set) (필수)
    - Class / Struct / Enum
    - Optional / Optional Binding
  - 다음 스터디 이번주 토요일 12시 서현역 토즈 분당서현점

## 상수와 변수

- let (this variable) X = (equal to) 10 이런 의미에서 고정된 값인 상수 keyword가 let으로 됨

- let 상수, var 변수

- 간단하게 초기화 후 값이 변경되면 변수, 안 바뀌면 상수

- 변수는 저장된 값을 마음대로 변경할 수 있지만 상수는 값을 저장한 후 새로운 값으로 변경할 수 없음.

- 스코프 변수와 상수의 사용 가능 범위, 메모리 효율적 사용과 관계가 있음

- NamingConvention

  - 변수의 이름 소문자로 시작. 영문자와 _문자로 시작할 수 있지만, 숫자나 다른 특수문자로 사용할 수 없음
  - swift는 유니코드로 표현할 수 있는 한글이나 이모티콘 등을 변수 이름으로 사용 가능하지만 가독성 측면에서 불리하여 사용 안 함
  - 헝가리언 표기법 사용 안 함. 가령 nAge, bSuccess, szNmae 등등
  - UpperCamelCase, lowerCamelCase 사용
    - UpperCamelCase: 클래스, 구조체, 블록, 열거형, 익스텐션, 프로토콜
    - lowerCamelCase: 변수, 메소드, 속성, 파라미터
    - bookStore, userName, age, _internalName 등등 사용 가능

- 상수, 변수 초기화

  - 선언과 동시에 변수 초기화

  - ```swift
    var a: Int = 0
    let a: Int = 100
    ```

  - 선언하고 나중에 초기화

  - ```swift
    var a: Int
    a = 0
    
    let a: Int
    a = 100
    ```

  - 상수는 선언 후에 최초 한 번에 한해서 초기값을 할당할 수 있도록 개선됐음.

- 예제

  ```swift
  var 변수이름: 자료형
  
  var num: Int
  var str: String
  var a,b,c: Int
  var a: Int, b: Float, c: String
  ```

## 함수 정의 및 사용법

### 기본 예제

- func 키워드, 함수이름, (parameter name: 데이터 타입), return arrow, 반환타입

```swift
func hello(name: String) -> String{
    return "Hello~ " + name
}

//반환값이 없으면 생략하거나 void로 명시
func hello2(name: String) -> Void{
    
}

//안 적어줘도 상관 없음
func hello3(name: String){
    
}

let message = hello(name: "jae")
```

- 함수는 코드의 최상위 레벨에 선언, 메소드는 특정 형식 내부에 선언. 그래서 함수는 이름만으로 호출 가능, 메소드는 반드시 연관된 형식 이름이나 인스턴스 이름을 통해 호출해야 함

  ```
  변수 상수 함수는 클래스 안에 있으면 불리는 이름이 달라짐
  변수 상수는 클래스 안에 들어가면 property, 함수는 클래스의 method라고 불림
  instance는 전통적으로 object라고도 하지만, swift 공식문서에 보면 기능적인 측면에 초점을 맞춰서 객체object라는 단어보다는 instance라는 단어를 사용한다는 언급이 있음
  그래서 instance라는 단어를 자주 사용함
  ```

- 함수도 변수와 상수처럼 lowerCamelCase로, log, write, read와 같이 자주 사용되는 단어는 지양. 구체적인 함수 이름을 사용

### Formal Parameter와 Argument

- Argument(or Actual Parameter): 함수를 호출할 때 전달되는 value

- Formal Parameter: 함수 내부에서 사용되는 x

  ```swift
  func plusOne(x: Int) -> Int{
      return x + 1
  }
  
  let value = 7
  let result = plusOne(x: value)
  ```

- Swift 함수의 파라미터는 상수임. 함수 내부에서 파라미터의 값을 새로운 값으로 변경할 수 없음. 파라미터로 전달되는 값이 의도와 다르게 변경되는 오류를 사전에 방지할 수 있으나 코드의 유연성은 떨어짐

  ```swift
  //error: MyPlayground.playground:6:7: error: cannot assign to value: 'x' is a 'let' constant
  
  func test(_ x: Int) -> Int{
      x = x + 1
      return x
  }
  
  test(1)
  ```

### Argument Label & Parameter Name

- argument label

  - argument label을 통해서 입력값에 대한 설명을 명시해줄 수 있다
  - 함수를 외부에 노출할 때 argument label을 통해서 입력값에 대한 설명을 보여줄 수 있음
  - 함수 내부에서는 간략한 parameter naming을 가지고 간결하게 구현할 수 있음
  - Argument label은 길고 자세하게 작성, parameter는 짧고 간결하게 작성하는 경우가 많다고 함
  - Argument label을 명시하지 않은 경우 변수명과 같은 것으로 설정이 된다. 그래서 생략하려고 하면 _ underscore로 표시하면 된다.
  - argument label이 달라도 함수 오버로딩이 된다. argument label이 있는 함수는 같이 써줘야 함수를 사용할 수 있기 때문.

  ```swift
  func calculate(multiflyFirstNumber num1: Int, bySecondNumber num2: Int) -> Int{
      return num1 + num2
  }
  
  func calculate(_ num1: Int, _ num2: Int) -> Int{
      return num1 * num2
  }
  
  //argument label이 달라도 함수 오버로딩이 된다
  //함수의 이름이 같더라도 argument label이나 parament label으로 구분 가능하면 따로 사용 가능함
  calculate(1, 2)
  calculate(multiflyFirstNumber: 1, bySecondNumber: 10)
  ```

### 파라미터 기본 값 설정

- 기본 값이 지정된 파라미터는 함수 호출 시 생략 가능함

- 기본 값으로 설정하는 파라미터는 가능한 파라미터 목록 마지막에 위치하는 것이 좋음

- 상수를 선언하는 것과 달리 형식 추론을 사용할 수 없으니 자료형을 생략할 수 없다

- 함수 호출할 때 모호함을 방지하기 위해 argument label을 명시해줘야한다

  ```swift
  //기본값을 적용하는 경우
  func addTwoNumbers(num1: Int, num2: Int = 100) -> Int {
      return num1 + num2
  }
  
  addTwoNumbers(num1: 5, num2: 10)
  addTwoNumbers(num1: 5)
  ```

### 가변 파라미터 ...

- ...을 사용하면 여러개의 파라미터를 받겠다는 의미

- 함수는 단 하나의 가변 파라미터를 선언할 수 있음. 호출 시 모호함을 피하기 위해 파라미터 마지막에 선언해야함

- 가변 파라미터는 함수 내부에 배열로 전달된다

  ```swift
  func addNumbers(numbers: Int...) -> Int{
      var sum = 0
      for num in numbers{
          sum += num
      }
      return sum
  }
  
  addNumbers(numbers: 1,2,3,4,5)
  
  //다른 변수랑도 사용 가능
  func test(number x: Int, numbers list: Int...) -> Int{
      return list[0]
  }
  
  test(number: 1, numbers: 1,2,3,4,5)
  ```

### 입출력 파라미터 inout

- 함수 파라미터들은 상수로 설정이 되어 함수 내부에서 값을 변경할 수 없음. 그래서 값을 변경하고 싶다면 임시 변수를 선언한 후 이 변수를 변경해야 하는데,

- inout keyword를 사용하면 값을 변경할 수 있음.

  - 그냥 파라미터는 함수 밖의 변수의 값이 복사가 되어 상수변수로 함수 내부로 전달이 되는데: call by value
  - inout 파라미터는 바깥의 변수 메모리 주소를 참조하게 되어: call by reference
  - 값이 변경이 가능하게 된다.

- inout 파라미터를 가진 함수를 호출 시 함수 인자로 &문자를 공백 없이 붙여 사용해야함

  ```swift
  //매개변수들은 let키워드로 상수임을 알 수 있다.
  //함수 인자로 전달해준 값들을 실수로 함수 안에서 값을 변경하지 못하게 하기 위해서이다
  func addTwoNumber(num1: Int, num2: inout Int) -> Int{
      num2 = 7
      return num1 + num2
  }
  
  var test1 = 1
  var test2 = 2
  
  //test1에 저장돼있는 값이 복사되어서 넘어감. call by value
  //test2 변수 자체가 넘어가서(변수의 메모리 주소를 넘겨줌) 값이 변경되면 똑같이 test2 변수도 변함. call by reference
  addTwoNumber(num1: test1, num2: &test2)
  print(test2)
  ```

### 복합 Return 값

- 함수는 두 개 이상의 값을 동시에 반환할 수 없기 때문에, 반환 값을 하나로 묶는 구조체나 클래스를 구현하여 문제를 해결함

  ```swift
  //구조체 타입으로 반환
  struct Stat{
      let sum: Double
      let avg: Double
  }
  
  func statistics(_ numbers: Int...) -> Stat{
      for n in numbers{
          sum += n
      }
      return Stat(sum: Double(sum), avg: Double(sum) / Double(numbers.count))
  }
  
  let result = statistics(1,2,3,4,5)
  print(result.sum)
  print(result.avg)
  
  //반환값이 여러개인 함수, 튜플 타입으로 반환
  func myInfo() -> (name: String, weight: Int){
      return ("jae", 70)
  }
  
  let info = myInfo()
  print(info.name)
  print(info)
  ```

### Function Types

- 모든 함수는 파라미터의 자료형과 리턴형으로 구성된 function type으로 표현할 수 있음

- Function type은 c의 함수 포인터와 유사한 개념

- 사용 예제

  ```swift
  let firstOperand = 2
  let secondOperand = 3
  let op = "*"
  
  var function: ((Int, Int) -> Int)?
  
  switch op{
      case "+":
      	function = add
      case "-":
      	function = substract
      case "*":
      	function = multiply
      case "/":
      	function = divide
      default:
      	break
  }
  
  func processResult(function f: (Int, Int) -> Int, lhs: Int, rhs: Int) -> Int{
      return f(lhs, rhs)
  }
  
  if let calc = function{
      let result = processResult(function: calc, lhs: firstOperand, rhs: secondOperand)
      print("\(firstOperand) \(op) \(secondOperand) = \(result)")
  }else{
      print("not supported")
  }
  ```

### Nested Functions

- 함수 내부에 함수를 구현할 수 있음.

- 내포된 함수의 사용 범위는 자신을 포함하고 있는 함수의 범위로 제한된다

- 하지만 selectOperator 함수와 같이 함수 형식을 반환하는 경우에는 반환되는 함수를 통해 내포된 함수를 간접적으로 호출할 수 있다

  ```swift
  func selectOperator(operator op: String) -> ((Int, Int) -> Int)?{
      func add(_ a: Int, _ b: Int) -> Int{
          print(#function)
          return a+b
      }
      func subtract(_ a: Int, _ b: Int) -> Int{
          print(#function)
          return a-b
      }
      
      switch op{
          case "+":
          	return add
          case "-":
          	return subtract
          default:
          	return nil
      }
  }
  ```

### 참고

- 참고로 코드 스니핏 기능 있어서 코드 블록들 쉽게 사용 가능

- separator, terminator

  - separator : 사이사이 구분하는 문자, 기본은 빈칸 하나
  - terminator : 마지막을 알려주는 문자, \n으로 끝내고 싶지 않다 하면 terminator: "" 이렇게 써주면된다
  - print(123, "Hello", true, 123.456, separator: "---", terminator: "")

  ```swift
  func print(_ items: Any..., separator: String = default, terminator: String = default)
  print("Hi~~")
  print(123)
  print(message)
  ```

## Property(Stored, Computed, Class)

- property 속성 lowerCamelCase
- 간단히
  - Stored Property(저장 프로퍼티)는 상수와 변수 값을 인스턴스의 일부로 저장함. 클래스와 구조체에서만 사용
  - 반면에 Computed Property(연산 프로퍼티)는 값을 연산함(저장(store)하기 보다는) 그때그때 특정 연산은 수행하여 값을 반환함. 클래스, 구조체 그리고 **열거형**에서 사용
  - 이렇게 Stored Property(저장 프로퍼티)와  Computed Property(연산 프로퍼티)는 일반적으로 특정 타입의 인스턴스와 연결된다. 그러나 프로퍼티를 타입 자체와 연결할 수도 있음. 이러한 프로퍼티를 Type Property(타입 프로퍼티)라고 한다.

### Stored Property

- 클래스와 구조체의 인스턴스의 일부가 되는 상수, 변수

- 변수 저장 프로퍼티: 변수를 저장하는 저장 프로퍼티

- 상수 저장 프로퍼티: 상수를 저장하는 저장프로퍼티

- 구조체 사용 예제

  ```swift
  struct FixedLengthRange {
      var firstValue: Int
      let length: Int
  }
  
  var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
  
  rangeOfThreeItems.firstValue = 6
  rangeOfThreeItems.length = 10//error!
  ```
  - 구조체의 인스턴스가 var로 선언되면 해당 구조체의 프로퍼티들을 변경할 수 있지만, let으로 선언되면 모든 프로퍼티가 let으로 선언된 것 같이 되니까 주의.
  - 구조체는 Value type이기 때문

  ```swift
  struct FixedLengthRange {
      var firstValue: Int
      let length: Int
  }
  
  let rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
  
  rangeOfThreeItems.firstValue = 6//error!
  rangeOfThreeItems.length = 10//error!
  ```

- 클래스 사용 예제

  ```swift
  class FixedLengthRange {
      var firstValue: Int
      let length: Int
      init(firstValue : Int, length:Int) {
          self.firstValue = firstValue
          self.length = length
      }
  }
  
  var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
  
  rangeOfThreeItems.firstValue = 3
  rangeOfThreeItems.length = 10//error!
  ```

  - Reference type인 클래스도 let으로 선언된 length의 값을 바꾸진 못함
  - 위 구조체에서는 rangeOfThreeItems를 let으로 바꾸자마자 rangeOfThreeItems의 firstValue를 바꾸는 코드가 에러가 났었는데, 클래스는 에러가 나지 않음.
  - 클래스는 Reference type이기 때문에, 원본에 바로 접근하기 때문에 상수 인스턴스로도 변수 변경 가능
  - 원본의 firstValue는 var였기 때문에 **여전히 값의 변경이 가능**하지만, 원본의 length는 let으로 선언되어있기때문에 값을 바꾸지 못하는 것임

  ```swift
  class FixedLengthRange {
      var firstValue: Int
      let length: Int
      init(firstValue : Int, length:Int) {
          self.firstValue = firstValue
          self.length = length
      }
  }
  
  let rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
  
  rangeOfThreeItems.firstValue = 3
  rangeOfThreeItems.length = 10//error!
  ```

### Lazy Stored Property

- 값이 사용되기 전까지는 값이 계산되지 않는 프로퍼티.

- lazy 키워드 사용하여 선언함

- 모든 저장 속성은 인스턴스의 초기화가 완료된 시점에 적절한 값으로 초기화되어야 한다. 만약 파일에 저장되어 있는 값으로 초기화해야하는 속성이 있다면 다른 속성에 비해 많은 메모리 공간이 필요하고 초기화에 소요되는 시간이 길어질 수 있음. 그리고 프로그램 실행되는 동안 이 속성을 한 번도 사용하지 않으면 불필요한 메모리 낭비가 된다

- 그래서 Lazy stored property를 사용하면, 초기화 과정에서 초기화되지 않고 속성에 처음 접근하는 시점에 초기화된다. 큰 값을 저장하거나 속성의 값이 초기화 이후에 결정되는 값에 의존적인 경우 활용할 수 있음

- 주의: 여러 스레드에서 동시에 접근하는 경우 속성이 두 번 이상 초기화될 가능성이 있으므로 조심해야함 

  ```swift
  struct Contact{
      var email: String?
      var mobile: String?
      var fax: String?
      
      init(){
          print("new Contact instance")
      }
  }
  
  class Person{
      var name = ""
      var age = 0
      
      lazy var contacts = Contact() //*****************************
      
      init(){
          print("new Person instance")
      }
  }
  
  let james = Person()
  //new person instance
  //여기에서 contacts 인스턴스가 생성이 안 되고, 이 시점까지 contact 속성은 초기화되지 않은 상태이며 메모리 공간도 생성되지 않은 상태임
  
  print(james.name)
  print(james.age)
  
  james.contacts.email = "james@example.com"
  //new Contact instance
  //여기에서 처음 contacts 인스턴스에 접근을 하기 때문에 이 시점에서 생성됨
  ```

### Computed Property

- stored property처럼 값을 직접 저장하지 않고, 값들을 연산하여 stored property에 전달해주는 역할

- getter, setter

- 클래스, 구조체, 열거형에 사용된다

- var로 선언해야한다

- 클래스, 구조체, 열거형에 값을 저장할 저장 프로퍼티가 하나 있어야한다. 연산 프로퍼티 자기 자신을 리턴하거나 값을 지정할 수 없음

- get, set을 동시에 구현 가능, get만 구현하는 것도 가능(read-only computed property), 하지만 set만 구현하는 것은 안 된다

- set의 파라미터를 생략할 수 있으나 생략 시, newValue라는 키워드를 사용해야한다.

  ```swift
  class Point {
      var tempX : Int = 1
      var x: Int {
          get {
              return tempX
          }
          set(newValue) {
              tempX = newValue * 2
          }
      }
  }
  //p.x = 12를 하면 x에 값이 저장되는 것이 아니라, tempX에 12를 두배한 24가 저장이 되는 것임
  var p: Point = Point()
  p.x = 12
  ```

- newValue를 사용하여 간략하게 작성한 코드를 Shorthand Setter Declaration라고 함

  ```swift
  struct AlternativeRect {
      var origin = Point()
      var size = Size()
      var center: Point {
          get {
              let centerX = origin.x + (size.width / 2)
              let centerY = origin.y + (size.height / 2)
              return Point(x: centerX, y: centerY)
          }
          set {
              origin.x = newValue.x - (size.width / 2)
              origin.y = newValue.y - (size.height / 2)
          }
      }
  }
  ```

### Type Property

- 인스턴스 프로퍼티는 특정 인스턴스에 속한 프로퍼티를 말한다. 이 프로퍼티는 새로운 인스턴스가 생성될 때마다 새로운 프로퍼티도 같이 생성된다.

- 프토퍼티를 타입 자체에 연결할 수 있음. 타입 프로퍼티는 특정 타입에 속한 프로퍼티로 그 타입에 해당하는 단 하나의 프로퍼티만 생성된다.

  - 타입 프로퍼티는 모든 타입이 사용할 수 있는 상수 프로퍼티(constants property) (ex : C의 static 상수)
  - 또는 글로번 변수 프로퍼티와 같이 특정 타입의 모든 인스턴스에 공통적인 값을 정의하는 데 유용함. ( ex: C의 static 변수)

- 타입프로퍼티에는,  저장 타입 프로퍼티와 연산 타입 프로퍼티가 있음

  - Stored type Property는 상수/변수 일 수 있음

  - Stored instance property와 달리 Stored type Property에는 항상 기본값을 줘야한다. 왜냐하면 초기화 시에, 타입 자체에는 Stored type Property에 값을 할당할 initializer가 없기 때문.

  - Stored type Property는 Lazy Stored Property처럼 최초 접근 시점에 초기화된다. 굳이 lazy 키워드를 명시적으로 추가할 필요 없음. 다수의 쓰레드에 의해 동시에 엑세드 되고 있어도 한 번만 초기화되는 것이 보장되기 때문에 사용할 필요 없음

    ```swift
    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }
    ```

    - 타입 프로퍼티를 선언을 위해서는 `static` 키워드를 사용함.
    - static이 사용되지 않았으면 그냥 저장 인스턴스 프로퍼티, 연산 인스턴스 프로퍼티일텐데, static이라는 키워드가 붙었으니 타입 프로퍼티인 것을 알 수 있다

    ```swift
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 6
        }
    }
    ```

    - 열거형에서도 사용 가능

    ```swift
    class SomeClass {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 27
        }
        
        class var overrideableComputedTypeProperty: Int {
            return 107
        }
    }
    ```

    ```swift
    class ChildSomeClass : SomeClass{
        override static var overrideableComputedTypeProperty: Int{
            return 2222
        }
    }
    ```

    - 클래스에서는 `static`과 `class` 이렇게 2가지 형태로 타입 프로퍼티를 선언할 수 있는데 두 가지 경우의 차이는서브클래스에서 `overriding`가능 여부입니다.
    -  `class`로 선언된 프로퍼티는 서브클래스에서 오버라이드 가능합니다.

- 타입 프로퍼티의 접근과 설정 (Querying and Setting Type Properties)

  - 인스턴스 프로퍼티와 마찬가지로 타입 프로퍼티도 점연산자(dot operator)로 프로퍼티의 값을 가져오고 할당할 수 있음

    ```swift
    print(SomeStructure.storedTypeProperty)
    // Prints "Some value."
    SomeStructure.storedTypeProperty = "Another value."
    print(SomeStructure.storedTypeProperty)
    // Prints "Another value."
    print(SomeEnumeration.computedTypeProperty)
    // Prints "6"
    print(SomeClass.computedTypeProperty)
    // Prints "27"
    ```

### Property Observer

- property observer는 속성 값의 갱신 전후에 특정 코드를 실행하는 수단을 제공. 다른 언어에서 observer pattern 또는 notification pattern, delegate pattern을 구현하여 유사한 기능을 제공함

- Property Observers를 정의해서 프로퍼티 값의 변경을 모니터링 할 수 있음. 프로퍼티 옵저버는 자신이 정의한 "저장 프로퍼티"에 추가 할 수 있으며, 부모클래스를 상속한 프로퍼티에도 추가 할 수 있다.

- 프로퍼티 옵저버는 새로운 값이 프로퍼티의 현재값과 동일하더라도 속성의 값이 설정될 때 마다 호출

- lazy 저장 프로퍼티를 제외하고, 정의된 저장 프로퍼티에 프로퍼티 옵저버를 추가할 수 있음

- 또한, 하위 클래스 내의 프로퍼티를 재정의하여, 상속된 프로퍼티(저장프로퍼티 or 연산프로퍼티 어느것이든)에도 프로퍼티 옵저버를 추가할 수 있습니다.

  - `willSet` : 값이 저장되기 바로 직전에 호출 됨

  - `didSet` : 새 값이 저장되고 난 직후에 호출 됨

  - `willSet`에서는 새 값의 파라미터명을 지정할 수 있는데, 지정하지 않으면 기본 값으로 `newValue`를 사용

    `didSet`에서는 바뀌기 전의 값의 파라미터명을 지정할 수 있는데, 지정하지 않으면 기본 값으로 `oldValue`를 사용

  ```swift
  class StepCounter {
      var totalSteps: Int = 0 {
          willSet(newTotalSteps) {
              print("About to set totalSteps to \(newTotalSteps)")
          }
          didSet {
              if totalSteps > oldValue  {
                  print("Added \(totalSteps - oldValue) steps")
              }
          }
      }
  }
  let stepCounter = StepCounter()
  stepCounter.totalSteps = 200
  // About to set totalSteps to 200
  // Added 200 steps
  stepCounter.totalSteps = 360
  // About to set totalSteps to 360
  // Added 160 steps
  stepCounter.totalSteps = 896
  // About to set totalSteps to 896
  // Added 536 steps
  ```

  - 파라미터를 사용하지 않은 경우, 지정된 키워드를 사용해주면 된다.

  ```swift
  class StepCounter {
      var totalSteps: Int = 0 {
          willSet {
              print("totalSteps을 \(newValue)로 설정하려고 합니다")
          }
          didSet {
              if totalSteps > oldValue  {
                  print("\(totalSteps - oldValue)걸음이 추가되었습니다.")
              }
          }
      }
  }
  ```

### 전역변수와 지역변수

- 프로퍼티를 계산하고 관찰하기 위해서 위에서 설명한 프로퍼티 옵저버 기능은 전역변수와 지역변수에서도 사용할 수 있음

  - 전역변수: 함수, 메소드, 클로저 또는 type context외부에 정의되는 변수

  - 지역변수: 함수, 메소드 또는 closure context내에서 정의되는 변수
    - 전역상수와 전역변수는 항상 게으르게 연산된다. 즉, 필요할 때 초기화해줘야함
    - 전역상수와 전역변수는 연산 프로퍼티와는 다르게 lazy키워드가 필요없다
    - 지역상수와 지역변수는 게으르게 연산되지 않는다

## 콜렉션(Array, Dictionary, Set)

- 