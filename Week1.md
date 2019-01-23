# Week1. Swift에서 타입이란,

- 1주차
  - property 차이점 등등 자세하게, 자유롭게 정리해서 설명
    컬렉션 타입 3가지에 대한 차이점을 정리 설명
    값타입 참조타입 등등 차이점에 대해서
    optional / optional binding에 대한 설명
  - 토요일까지 과제
    - 상수와 변수, 함수 정의 및 사용법
    - Property(Stored, Computed, Class)

    - 콜렉션(Array, Dictionary, Set)
    - Class / Struct / Enum
    - Optional / Optional Binding
  - 다음 스터디 이번주 토요일 12시 서현역 토즈 분당서현점

```
함수
    Formal Parameter와 Argument
    Argument Label & Parameter Name
    파라미터 기본 값 설정
    가변 파라미터 ...
    입출력 파라미터 inout
    복합 Return 값
    Function Types
    Nested Functions
Property(Stored, Computed, Class)
	Stored Property
	Lazy Stored Property
	Computed Property
	Type Property
	Property Observer
	전역변수와 지역변수
Collection (Array, Dictionary, Set)
	Array
	Dictionary
	Set
```

## 상수와 변수

### let 상수, var 변수

- let (this variable) X = (equal to) 10 이런 의미에서 고정된 값인 상수 keyword가 let으로 됨
- 간단하게 초기화 후 값이 변경되면 변수, 안 바뀌면 상수
- 변수는 저장된 값을 마음대로 변경할 수 있지만 상수는 값을 저장한 후 새로운 값으로 변경할 수 없음.
- 스코프 변수와 상수의 사용 가능 범위, 메모리 효율적 사용과 관계가 있음

### NamingConvention

- 변수의 이름 소문자로 시작. 영문자와 _문자로 시작할 수 있지만, 숫자나 다른 특수문자로 사용할 수 없음
- swift는 유니코드로 표현할 수 있는 한글이나 이모티콘 등을 변수 이름으로 사용 가능하지만 가독성 측면에서 불리하여 사용 안 함
- 헝가리언 표기법 사용 안 함. 가령 nAge, bSuccess, szNmae 등등
- UpperCamelCase, lowerCamelCase 사용
  - UpperCamelCase: 클래스, 구조체, 블록, 열거형, 익스텐션, 프로토콜
  - lowerCamelCase: 변수, 메소드, 속성, 파라미터
  - bookStore, userName, age, _internalName 등등 사용 가능

### 상수, 변수 초기화

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

- func 키워드 / 함수이름 / (parameter name: 데이터 타입) / return arrow 반환타입

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

- 함수도 변수와 상수처럼 lowerCamelCase로 하고 구체적인 함수 이름을 사용하면 되고, log, write, read와 같이 자주 사용되는 단어는 지양

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

- 구체적인 예시로 print함수 separator, terminator

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

- 함수 내부에 함수를 구현할 수 있음

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

- lowerCamelCase
- 간단히
  - Stored Property(저장 프로퍼티)는 상수와 변수 값을 인스턴스의 일부로 저장함. 클래스와 구조체에서만 사용
  - 반면에 Computed Property(연산 프로퍼티)는 값을 연산함(저장(store)하기 보다는) 그때그때 특정 연산은 수행하여 값을 반환함. 클래스, 구조체 그리고 **열거형**에서 사용
  - 이렇게 Stored Property(저장 프로퍼티)와  Computed Property(연산 프로퍼티)는 일반적으로 특정 타입의 인스턴스와 연결된다. 그러나 프로퍼티를 타입 자체와 연결할 수도 있음. 이러한 프로퍼티를 **Type Property**(타입 프로퍼티)라고 한다.

### Stored Property

- 클래스와 구조체의 인스턴스의 일부가 되는 상수, 변수

- **변수 저장 프로퍼티**: 변수를 저장하는 저장 프로퍼티

- **상수 저장 프로퍼티**: 상수를 저장하는 저장프로퍼티

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
  - 원본의 firstValue는 var였기 때문에 여전히 값의 변경이 가능하지만, 원본의 length는 let으로 선언되어있기때문에 값을 바꾸지 못하는 것임

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

- **var로 선언해야한다**

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

- 타입프로퍼티에는,  **Stored Type Property(저장 타입 프로퍼티)**와 **Computed Type Property(연산 타입 프로퍼티)**가 있음

  - Stored Type Property는 상수/변수 일 수 있음

  - Stored instance property와 달리 **Stored Type Property에는 항상 기본값을 줘야한다. 왜냐하면 초기화 시에, 타입 자체에는 Stored type Property에 값을 할당할 initializer가 없기 때문**

  - **Computed Type property는 변수로만 선언 가능**

  - **Stored type Property는 Lazy Stored Property처럼 최초 접근 시점에 초기화된다**. 굳이 lazy 키워드를 명시적으로 추가할 필요 없음. 다수의 쓰레드에 의해 동시에 엑세드 되고 있어도 한 번만 초기화되는 것이 보장되기 때문에 사용할 필요 없음

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

    - 클래스에서는 `static`과 `class` 이렇게 2가지 형태로 타입 프로퍼티를 선언할 수 있는데 두 가지 경우의 차이는서브클래스에서 `overriding`가능 여부이다.
    - **`class`로 선언된 프로퍼티는 서브클래스에서 오버라이드 가능**

    ```swift
    class Account{
        static let dollarExchangeRate: Double = 1000.0
        
        var credit: Int = 0
        var dollarValue: Double{
            get{
                return Double(credit) / Account.dollarExchangeRate
            }
            set{
                credit = Int(newValue * Account.dollarExchangeRate)
                print("잔액을 \(newValue) 달러로 변경 중입니다")
            }
        }
    }
    ```

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

- **lazy 저장 프로퍼티를 제외하고, 정의된 저장 프로퍼티에 프로퍼티 옵저버를 추가할 수 있음**

- **또한, 하위 클래스 내의 프로퍼티를 재정의하여, 상속된 프로퍼티(저장프로퍼티 or 연산프로퍼티 어느것이든)에도 프로퍼티 옵저버를 추가할 수 있습니다**

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
    - **전역상수와 전역변수는 항상 게으르게 연산된다. 즉, 필요할 때 초기화해줘야함**
    - **전역상수와 전역변수는 연산 프로퍼티와는 다르게 lazy키워드가 필요없다**
    - **지역상수와 지역변수는 게으르게 연산되지 않는다**

## Collection (Array, Dictionary, Set)

- 구조체로 구현된 값 형식

  - Array: 순서가 있는 리스트 컬렉션
  - Dictionary: key와 value의 쌍으로 이뤄진 컬렉션
  - Set: 순서가 없고 멤버가 유일한 컬렉션

- Swift 컬렉션은 별도의 자료형으로 구분하지 않고 let, var 키워드를 통해 컬렉션의 가변셩을 결정함
  - 불변 컬렉션에 가변 문자열이 저장되어 있으면, 컬렉션에 새로운 가변 문자열을 추가하는 것은 불가능하지만 물자열 자체의 내용을 변경하는 것은 가능
  - 가변 컬렉션에 불변 문자열이 저장되어 있으면, 컬렉션에 새로운 문자열을 추가할 수 있지만 문자열의 내용은 변경할 수 없음
  - 이렇게 가변형과 불변형으로 나누는 이유는 스레드의 안정성을 얻기 위함. 불변 컬렉션은 동시에 여러 스레드에서 접근해도 안전. 가변 컬렉션은 여러 스레드가 동시에 값을 변경하는 경우 오류가 발생하거나 의도하지 않는 결과를 가져올 수 있음

- 참고: 튜플

  - 이름이 따로 지정되어 있지 않은 마음대로 만드는 타입. 지정된 데이터의 묶음

  - 각 요소를 이름 대신 숫자로 표시하거나, 요소마다 이름을 붙여줄 수 있음

  - 사용 예제

    ```swift
    var person: (String, Int, Double) = ("yagom", 100, 182.5)
    print("\(person.0), \(person.1), \(person.2)")
    
    var person2: (name: String, age: Int, height: Double) = ("yagom", 100, 182.5)
    print("\(person2.name), \(person2.age), \(person2.height)")
    
    //일일이 타입을 명시해가면서 튜플을 사용하기 번거로워서, typealias를 사용하여 튜플에 별칭 부여
    typealias PersonTuple = (name: String, age: Int, height: Double)
    let yagom: PersonTuple = ("yagom", 100, 178.5)
    let eric: PersonTuple = ("eric", 100, 178.5)
    
    print("\(yagom.name), \(yagom.age), \(yagom.height)")
    ```

### Array

- element 요소를 순서대로 정렬하는 컬렉션

- 배열이지만 버퍼 크기가 고정되어 있는 것이 아니라, 자동으로 버퍼의 크기를 조절해주므로 요소 삽입, 삭제가 자유롭다

- **가변 배열인데 크기가 정해져있다**

  - 초기 할당 가능 크기 100인데 (할당가능 공간을 초과한 사이즈인)101 사이즈만큼 들어오면, (초기 할당 가능 크기)100만큼 더 공간을 만들어서 기존에 있던 값과 새로 들어오는 값을 복사하여 값을 할당해준다
  - 이 초기 할당 가능 크기를 설정할 수 있음
  - 배열 자체가 Struct 타입이라 값 복사를 해주게 된다

- Hashable protocol, equatable protocol 준수하면 == 함수를 구현해야함

- 예제

  ```swift
  //배열 리터럴, 이 경우에는 빈 배열 생성 불가
  let stringArray = ["one", "two", "three"]
  //생성자
  let stringArray = Array<Int>(["one", "two", "three"])
  
  //빈 array 생성
  var integers: Array<Int> = Array<Int>()
  integers.append(1)
  integers.append(100)
  integers.append(100)
  //integers.append(101.1) 다른 타입을 넣게 되면 오류남
  
  integers.contains(100)
  integers.contains(99)
  
  integers.remove(at: 0)
  integers.removeFirst()
  integers.removeLast()
  integers.removeAll()
  integers.popLast() //런타임 중 배열의 길이를 정확히 판단할 수 없는 상황에서 마지막 요소 삭제하는 경우 사용. 삭제된 요소를 옵셔널로 반환해서 배열 비어있어서 nil반환하여 오류 안 남
  //1
  //100
  //100
  //[]
  //nil
  
  integers.removeAll(keepingCapacity: true) //요소를 모두 삭제를 하지만 메모리공간을 할당 해제를 하지 않음. 삭제 후 요소들을 다시 채우게 되는 경우 사용하면 불필요한 메모리 할당해제가 일어나지 않아서 좋음
  
  integers.count
  //0
  
  if !integers.isEmpty{
      print("\(integers.count) element(s)")
  }else{
      print("Empty array")
  }
  
  //integers[0]
  //지금 array에 아무것도 없기 때문에 잘못된 접근이라 오류남
  
  //첫번째 요소 인덱스, 마지막 요소 다음 인덱스 반환
  integers.startIndex
  integers.endIndex
  
  //맨 처음 요소, 맨 마지막 요소 가져오기
  integers.first
  integers.last
  
  //요소의 인덱스를 옵셔널로 반환
  integers.index(of: 1)
  
  //==연산자로 두 array비교 가능.
  let alphabet = ["A", "B", "C"]
  let lower = ["a", "b", "c"]
  if alphabet == lower{
      print("alphabet == lower")
  }else{
      print("alphabet != lower")
  }
  //요소의 비교 조건을 상세하게 지정할 때 사용. 비교 조건은 클로저로 전달. 이 클로저는 두 개의 요소를 비교한 결과를 Bool로 반환함
  if alphabet.elementsEqual(lower, by: {$0.lowercased() == $1.lowercased()}){
      print("alphabet == lower")
  }else{
      print("alphabet != lower")
  }
  
  //append, insert at
  var alphabet = [String]()
  alphabet.append("B")
  alphabet.insert("A", at: 0)
  
  alphabet.replaceSubrange(0..<2, with: ["X", "Y"])
  alphabet.replaceSubrange(alphabet.startIndex..<alphabet.endIndex.advanced(by: -1), with: ["X", "Y"])
  alphabet[alphabet.startIndex..<alphabet.endIndex.advanced(by: -1)] = ["X", "Y"]
  
  alphabet.sorted() //배열을 변경하지는 않음
  alphabet
  alphabet.sort() //새롭게 정렬한 배열로 변경
  alphabet
  
  alphabet.reverse()
  alphabet.reverse()
  alphabet.reversed()
  var result2: [String] = alphabet.reversed()
  result2
  ```

  ```swift
  //Array<Double>와 [Double]은 같은 표현
  var doubles: Array<Double> = [Double]()
  var strings: [String] = [String]()
  
  //빈 Array 만드는데 타입을 그냥 생략해줘도 됨
  var characters: [Character] = []
  
  //let 사용하여 Array 만들면 변경 불가능한 Array로 설정됨
  let immutableArray = [1,2,3]
  
  immutableArray.append(4) //error
  immutableArray.removeAll() //error
  ```

### Dictionary

- key: value.

- 하나의 Dictionary 안에서 key는 중복해서 사용할 수 없음. 키는 값을 대변하는 유일한 식별자

- Let 사용하여 상수로 선언을 하면 변경불가, var 사용하여 변수로 선언하면 변경 가능. 불변/가변 컬렉션

- 배열과 다르게 dictionary 내부에 없는 키로 접근해도 오류가 발생하지 않음. Nil 반환함

- 예제

  ```swift
  //key가 string 타입이고 value가 any인 빈 Dictionary 생성
  var anyDictionary: Dictionary<String, Any> = [String: Any]()
  anyDictionary["someKey"] = "value"
  anyDictionary["anotherKey"] = 100
  anyDictionary //["someKey": "value", "anotherKey": 100]
  
  anyDictionary["someKey"] = "dictionary"
  anyDictionary //["someKey": "dictionary", "anotherKey": 100]
  
  //삭제
  anyDictionary.removeValue(forKey: "anotherKey")
  anyDictionary["someKey"] = nil
  anyDictionary.removeAll()
  anyDictionary.removeAll(keepingCapacity: true)
  anyDictionary //[:]
  
  let emptyDictionary: [String: String] = [:]
  let initializedDictionary: [String: String] = ["name": "yagom", "gender": "male"]
  
  let someValue: String = initializedDictionary["name"] //오류나는 코드. Dictionary에 "name"이라는 키에 해당하는 값이 있을 수도 있고 없을 수도 있기 때문에 상수변수에 값을 할당하지 못하는 불확실성 때문에 오류남
  ```

  ```swift
  let words = ["A": "Apple", "B": "Banana", "C": "City"]
  let anotherWords = ["B": "Banana", "C": "City", "A": "Apple"]
  let countryCodes = ["KR": "South Korea", "US": "United States"]
  let upperWords = ["A": "APPLE", "B": "BANANA", "C": "CITY"]
  
  let countOfWords = words.count
  
  if !words.isEmpty{
      print("\(countOfWords) element(s)")
  }else{
      print("empty dictionary")
  }
  
  let keys = Array(words.keys)
  print(keys)
  
  let values = Array(words.values)
  print(values)
  
  if words.contains(where: {(key, value) -> Bool in return key == "A"}){
      print("contains A key.")
  }
  
  if words.contains(where: {$0.1 == "City"}){
      print("contains City value.")
  }
  
  if words == anotherWords{
      print("words == anotherWords")
  }else{
      print("word != anotherWords")
  }
  
  if words == countryCodes{
      print("words == countryCodes")
  }else{
      print("word != countryCodes")
  }
  
  let equals = words.elementsEqual(upperWords){(lhs, rhs) -> Bool in
      return lhs.0.lowercased() == rhs.0.lowercased()
          && lhs.1.lowercased() == rhs.1.lowercased()
  }
  
  print(equals)
  ```

### Set

- 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장하는 형태의 컬렉션 타입

- 세트 내의 값은 모두 유일한 값이 존재하고, 중복된 값이 존재하지 않음

- 그래서 세트는 보통 순서가 중요하지 않거나 각 요소가 유일한 값이어야 하는 경우에 사용

- 배열과 달리 축약형이 없음

- 예제

  ```swift
  //set은 축약문법이 없음
  var integerSet: Set<Int> = Set<Int>()
  integerSet.insert(1)
  integerSet.insert(100)
  integerSet.insert(99)
  integerSet.insert(99)
  integerSet.insert(99)
  
  integerSet //{100,99,1} 이렇게 나오고, 99는 중복된 값이라 inserted false라고 출력이 된다
  
  //요소 있는지 없는지 확인
  integerSet.contains(1)
  integerSet.contains(2)
  
  integerSet.remove(100)
  integerSet.removeFirst()
  
  integerSet.count
  
  let setA: Set<Int> = [1,2,3,4,5]
  let setB: Set<Int> = [3,4,5,6,7]
  
  let union: Set<Int> = setA.union(setB) //합집합
  let sortedUnion: [Int] = union.sorted() //자동정렬 안 되니, 정렬 기능 사용. 정렬된 항목들을 배열로 반환
  let intersection: Set<Int> = setA.intersection(setB) //교집합
  let subtracting: Set<Int> = setA.subtracting(setB) //차집합
  ```

  ```swift
  let englishClassStudents: Set<String> = ["john", "chulsoo", "yagom"]
  let koreanClassStudents: Set<String> = ["jenny", "yagom", "chulsoo", "haha", "minsoo"]
  
  let intersectSet: Set<String> = englishClassStudents.intersection(koreanClassStudents)
  let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents)
  let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents)
  let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents)
  
  print(unionSet.sorted())
  
  let 새: Set<String> = ["비둘기", "닭", "기러기"]
  let 포유류: Set<String> = ["사자", "호랑이", "곰"]
  let 동물: Set<String> = 새.union(포유류)
  
  print(새.isDisjoint(with: 포유류))
  print(새.isSubset(of: 동물))
  print(동물.isSuperset(of: 포유류))
  print(동물.isSuperset(of: 새))
  ```

  ```swift
  let fruits: Set<String> = ["Apple", "Orange", "Melon"]
  var countOfFruits = fruits.count
  
  if !fruit.isEmpty{
      print("\(countOfFruits) element(s)")
  }else{
      print("empty set")
  }
  
  let favoriteFruits = Set(["Apple", "Orange", "Melon"])
  let tropicalFruits = Set(["Banana", "Papaya", "Kiwi", "Pineapple"])
  let yellowFruits = Set(["Banana"])
  
  if favoriteFruits == tropicalFruits{
      print("favoriteFruits == tropicalFruits")
  }else{
      print("favoriteFruits != tropicalFruits")
  }
  
  if favoriteFruits.elementsEqual(tropicalFruits){
      print("favoriteFruits == tropicalFruits")
  }else{
      print("favoriteFruits != tropicalFruits")
  }
  ```

### Fast Enumeration

- ```swift
  let array = ["Apple", "Orange", "Melon"]
  for value in array {
      if let index = array.index(of: value){
          print("\(index) ~ \(value)")
      }
  }
  
  let set = Set(array)
  for value in set{
      print(value)
  }
  
  //enumerate() 메소드를 사용하면 순회의 각 단계마다 인덱스와 값으로 구성된 튜플을 얻을 수 있다. 배열을 순회할 때마다 인덱스를 사용할 때 유용
  for t in alphabet.enumerated(){
      print("\(t.0) - \(t.1)")
  }
  
  for (index, char) in alphabet.enumerated(){
      print("\(index) - \(char)")
  }
  ```

## Class / Struct / Enum

### Class

- 클래스에 초기값을 설정을 안 해주면 에러가 발생함 초기값 설정시 변수는 선언만 하고 생성자에서 값을 넣어줘도 된다 생성자는 기본 생성자 이외에 여러개의 생성자 생성 가능

  ```swift
  class Circle {
      var radius: Double
      let pi = 3.1415926535
      
      init() {
          radius = 10.0
      }
      
      init(radius: Double) {
          self.radius = radius
      }
      
      func area() -> Double {
          return radius * radius * pi
      }
  }
  
  //Circle 클래스의 circle instance
  let circle = Circle()
  circle.area()
  
  //이런식으로 직접 생성자메소드를 불러올 수 있지만 Circle() 생성하면 자동으로 불려지기 때문에 굳이 이렇게 사용 안 함
  let circle2 = Circle.init()
  ```

- inheritance, overriding

  ```swift
  class Notebook {
      var name = ""
      
      func turnOn(){
          print("Booting")
      }
  }
  
  class MacBook: Notebook {
      var hasTouchBar = true
      var macOSVersion = "10.13"
      
      func turnOnTouchBar() {
  
      }
      
      override func turnOn() {
          super.turnOn()
          print("\(name)'s current macOSVersion is \(macOSVersion)")
      }
  }
  
  let macBook = MacBook()
  macBook.name = "MacBook Pro"
  macBook.turnOn()
  ```

- 소멸자

  ```swift
  //소멸자 예제, class 말고 struct로 하면 소멸자 사용 못함
  class Circle2{
      var radius = 0
      
      init(){
          print("Initializer called")
      }
      
      deinit{
          print("Deinitializer called")
      }
  }
  
  if true{
      var circleTest = Circle2()
  }
  ```

### Struct

- [클래스와 구조체 공통점]

  - 속성(property)정의
  - 메소드(method) 정의
  - 생성자를 통한 초기 설정
  - extension, protocol 사용 가능

- [클래스만의 추가적인 특징]

  - inheritance. swift에서 다중상속은 안 된다. 하지만 프로토콜은 엄청 많이 따를 수 있다. 구조체는 상속이 안 됨.
  - type casting
  - 소멸자를 통한 리소스 관리
  - 참조 타입(reference type) : class는 변수나 상수에 할당이 되거나 함수 인자로 넘길 때 참조 횟수만 증가하는 reference 타입, 구조체는 변수나 상수에 할당이 되거나 함수 인자로 넘길 때 복사가 되는 value 타입

- [struct만의 특징]

  - 값(Value)이다. 정확히, 값의 타입을 정의하기 위해 사용한다. 객체(Object) 레퍼런스 타입을 정의하는 class 와는 다르다. Object가 아니기 때문에 AnyObject로의 캐스팅이 되지 않는다.
  - 대입 명령 시 내용이 복사된다. (단 데이터 변동이 없으면 레퍼런스 대입 형태로 동작한다)
  - 참조 카운트가 없어서 메모리 관리에 안전하다.
  - 레퍼런스 형태가 아니기 때문에 공유가 불가능하다.
  - 불변성(Immutable) 구현에 유리하다.
  - 상속이 불가능하다. 하지만 프로토콜은 사용 할 수 있다.
  - 멀티스레딩에 안전하다.

- [struct를 사용하면 좋은 경우]

  - 불변성(Immutable)이 필요한 데이터 타입
  - 적은 데이터, 즉 멤버 프로퍼티의 갯수나 차지하는 메모리 용량이 적은 타입
  - 대입 보다는 생성되는 경우가 많은 타입
  - 공유될 필요가 없는 타입
  - 클래스 타입 등 레퍼런스에 기반한 자료형을 저장용 프로퍼티로 쓰지 않는 경우

- [참고: 언제 class 대신 struct를 사용하는가](http://seorenn.blogspot.com/2016/04/swift-class-struct.html)

- 값 타입, 참조 타입

  - class로 했을 때와 struct로 했을 때, struct는 circleTwo를 하나 더 따로 만들지만 / class는 같은 circleOne 객체를 참조함
  - 클래스 구조체 선택 기준 공식 문서 참고해서 보면 일반적인 구조체 선택 기준은
    1. 몇가지 간단한 데이터 값을 캡슐화, 사각형의 너비 등등
    2. 할당 및 전달 시 복사가 합리적일 때
    3. 모든 속성도 값 타입 - 복사가 맞을 때
    4. 상속이 필요 없을 때

  ```swift
  struct Circle { 
      var radius = 0
  }
  
  var circleOne = Circle()
  var circleTwo = circleOne
  circleTwo.radius = 10
  
  print(circleTwo.radius)
  print(circleOne.radius)
  ```

### [Choosing Between Structures and Classes](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes)

- document에서 명시한 5가지
  - Choose structures by default
    - 구조체는 값 타입이기 때문에, using stuctures makes it easier to reason about a portion of your code without needing to consider the whole state of your app
    - 변경 되는 부분을 명확하게 알 수 있다
  - Use classes when you need Objective-C interoperability(상호 운용)
  - Use classes when you need to control identity
    - 앱 전역에서 접근가능한 instance identity를 사용하려면 use classes
    - 참조 타입이니까
  - Use structures when you don't control identity
    - 안전하게 데이터 복사 전달 가능. 불변성이 필요한 데이터 타입에 struct 사용
    - 값 타입이니까
  - Use stuctures and protocols to model inheritance and share behavior. 상속이나 공유를 하게 되는 모델을 구성할 때 structure and protocol을
    - 구조체는 protocol 상속만 가능, 클래스 상속은 클래스만 가능. 근데 클래스 상속은 protocol 상속 구조로도 구현가능
    - 그래서 우선적으로는 protocol 상속 구조로 구현을 해라

### Enum

- 정의한 항목 값 이외에는 추가/수정이 불가함. 정해진 값만 열거형 값에 속할 수 있음

  - 제한된 선택지를 주고 싶을 때
  - 정해진 값 외에는 입력받고 싶지 않을 때
  - 예상된 입력 값이 한정되어 있을 때

- 열거형(Enumeration) - naming 대문자로 시작

- 데이터타입이 String Int 등 여러 타입 가능

- enum도 타입이라 메소드, 타입프로퍼티가 들어갈 수 있음

  - 어떤 데이터들이 있는지 알 수 있는 all cases 기능같은 것들 추가 가능

- 데이터타입에 맞는 rawValue를 설정해줄 수 있음. 항목들이 값을 가질 수도 있고 안 가질 수도 있음. 스위프트 열거형은 각 항목이 그 자체로 고유의 값이 될 수 있음

- 사용 예제

  ```swift
  enum Weekday{
      case mon
      case tue
      case wed
      case thu
      case fri
      case sat
      case sun
  }
  print(Weekday.mon.hashValue)
  //"6858333308270053046\n"
  
  //한 줄에 표현 다 가능
  enum Weekday{
      case mon, tue, wed, thu, fri, sat, sun
  }
  ```

- 자동 원시값 지정

  - 문자열 형식의 원시 값을 지정해줬다면 각 항목 이름을 그대로 원시 값으로 갖게 된다.
  - 정수 타입이라면 첫 항목을 기준으로 0부터 1씩 늘어난 값을 갖게 된다.
  - 열거형이 원시 값을 갖는 열거형일 때, 열거형의 원시 값 정보를 안다면 원시 값을 통해 열거형 변수 또는 상수를 생성해줄 수도 있음.

  ```swift
  enum School: String {
      case primary = "유치원"
      case elementary = "초등학교"
      case middle = "중학교"
      case high = "고등학교"
      case college
      case university
      case graduate
  }
  
  let highestEducationalLevel: School = School.university
  print("저의 최종학력은 \(highestEducationalLevel.rawValue) 졸업입니다.")
  //저의 최종학력은 university 졸업입니다.
  
  print(School.elementary.rawValue) //초등학교
  
  enum Numbers: Int {
      case zero
      case one
      case two
      case ten = 10
  }
  
  print("\(Numbers.zero.rawValue), \(Numbers.one.rawValue), \(Numbers.two.rawValue), \(Numbers.ten.rawVAlue)")
  //0,1,2,10
  
  let primary = School(rawValue: "유치원") //primary
  let graduate = School(rawValue: "석박사") //원시 값이 없으니까 nil로 설정
  ```

- AssociateValue 연관 값

  - 열거형 내 항목들이 자신과 연관된 값을 가질 수 있음
  - 연관 값은 각 항목 옆에 소괄호로 묶어 표현함
  - 다른 항목이 연관 값을 갖는다고 모든 항목이 연관 값을 가질 필요는 없음

  ```swift
  enum PastaTaste {
      case cream, tomato
  }
  
  enum PizzaDough {
      case cheeseCrust, thin, original
  }
  
  enum PizzaTopping {
      case pepperoni, cheese, bacon
  }
  
  enum MainDish {
      case pasta(taste: PastaTaste)
      case pizza(dough: PizzaDough, topping: PizzaTopping)
      case chicken(withSauce: Bool)
      case rice
  }
  
  var dinner: MainDish = MainDish.pasta(taste: PastaTaste.tomato)
  dinner = MainDish.pizza(dough: PizzaDough.cheeseCrust, topping: PizzaTopping.bacon)
  ```

- 순환 열거형

  - 순환 열거형은 열거형 항목의 연관 값이 열거형 자신의 값이고자 할 때 사용
  - Indirect 키워드를 사용하여 순환 열거형을 명시
  - 특정 항목에만 한정하고 싶다면 case 키워드 앞에 indirect, 열거형 전체에 적용하고 싶다면 enum 키워드 앞에 indirect
  - indirect 키워드는 이진 탐색 트리 등의 순환 알고리즘을 구현할 때 유용하게 사용 가능

  ```swift
  enum ArithmeticExpression {
      case number(Int)
      indirect case addition(ArithmeticExpression, ArithmeticExpression)
      indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
  }
  
  indirect enum ArithmeticExpression {
      case number(Int)
      case addition(ArithmeticExpression, ArithmeticExpression)
      case multiplication(ArithmeticExpression, ArithmeticExpression)
  }
  ```

  ```swift
  let five = ArithmeticExpression.number(5)
  let four = ArithmeticExpression.number(4)
  let sum = ArithmeticExpression.addition(five, four)
  let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
  
  func evaluate(_ expression: ArithmeticExpression) -> Int {
      switch expression {
          case .number(let value):
          	return value
          case .addition(let left, let right):
          	return evaluate(left)+ evaluate(right)
          case .multiplication(let left, let right):
          	return evaluate(left) * evaluate(right)
      }
  }
  
  let result: Int = evaluate(final)
  print("(5 + 4) * 2 = \(result)")
  //(5 + 4) * 2 = 18
  ```

## Optional / Optional Binding

### Optional

- 스위프트에서 안전성을 문법으로 담보하는 기능

- 변수나 상수 등에 꼭 값이 있다는 것을 보장할 수 없다. 변수 또는 상수의 값이 nil일 수도 있다는 것을 의미

- 옵셔널과 옵셔널이 아닌 값은 철저히 다른 타입으로 인식하기 때문에 컴파일할 때 바로 오류를 걸러낼 수 있음

  - 전달인자로 NULL이 전달되어도 되는지 문서를 봐야 알 수 있는 다른 언어와 다르게, 스위프트에서는 옵셔널 문법적 표현만으로 이 의미를 충분히 표현 가능함.
  - 매개변수를 굳이 넘기지 않아도 된다는 뜻으로 매개변수의 타입을 옵셔널로 정의함. 물음표 하나로 암묵적인 커뮤니케이션 가능

- 옵셔널 정의

  - 옵셔널은 제네릭이 적용된 열거형
  - 옵셔널이 값을 갖는 케이스와 그렇지 못한 케이스 두 가지로 정의
  - nil일때는 none 케이스, 값이 있는 경우 some 케이스 with 연관 값 Wrapped. 옵셔널에 값이 있으면 연관값인 Wrapped에 값이 할당된다. 그래서 옵셔널 값 print하면 Optional("jae") 이렇게 출력된다.

  ```swift
  public enum Optional<Wrapped> : ExpressibleByNilLiteral {
      case none
      case some(Wrapped)
      public init(_ some: Wrapped)
      //중략
  }
  ```

  ```swift
  let numbers: [Int?] = [2, nil, -4, nil, 100]
  
  for number in numbers {
      switch number {
          case .some(let value) where value < 0:
          	print("Negative value!! \(value)")
          case .some(let value) where value > 10:
          	print("Large value!! \(value)")
          case .some(let value):
          	print("Value \(value)")
          case .none:
          	print("nil")
      }
  }
  
  //Value 2
  //nil
  //Negative value!! -4
  //nil
  //Large Value!! 100
  ```

### 옵셔널 추출

- 열거형의 case some에 숨어있는 옵셔널의 값을 옵셔널이 아닌 값으로 추출하는 optional unwrapping

- 옵셔널 강제 추출방식은 옵셔널의 값을 추출하는 가장 간단하지만 가장 위험한 방법. 런타임 오류가 일어날 가능성이 가장 높기 때문

  ```swift
  var myName: String? = "yagom"
  //옵셔널이 아닌 yagom 변수에 옵셔널 값이 들어갈 수 없으니 !강제 추출하여 할당함
  var yagom: String = myName!
  //값이 존재하여 오류가 나지 않지만 나중에 nil 값을 넣으면 오류가 나니까 위험함
  myName = nil
  yagom = myName! //오류
  ```

### 옵셔널 바인딩

- if 구문을 통해 myName이 nil인지 먼저 확인하고 옵셔널 값을 강제 추출하는 방법은 다른 언어에서 NULL값을 체크하는 방식과 비슷

- 만약 옵셔널 값이 있다면 옵셔널에서 추출한 값을 일정 블록 안에서 사용할 수 있는 상수나 변수로 할당해서 옵셔널이 아닌 형태로 사용할 수 있도록 해줌

  ```swift
  var myName: String? = "yagom"
  
  if let name = myName {
      print("My name is \(name)")
  } else {
      print("myName == nil")
  }
  //My name is yagom
  
  if var name = myName {
      name = "wizplan"
      print("My name is \(name)")
  } else {
      print("myName == nil")
  }
  //My name is wizplan
  ```

  - Optional로 Wrapped 값이 나오기때문에, Optional binding으로 값을 추출하여 사용

  ```swift
  var yourName: String? = "jae"
  print(yourName)
  //"Optional("jae")\n" ==> Optional로 Wrapped 값이 나오기때문에
  
  if let name = yourName {
      print(name)
  }
  //"jae\n" ==> Optional binding으로 값을 추출하여 사용
  ```

- if 구문을 실행하는 블록 안 쪽에서만 name이라는 임시 상수를 사용할 수 있음

- 쉼표를 사용해 바인딩할 옵셔널을 나열 가능

  ```swift
  var myName: String? = "yagom"
  var yourName: String? = nil
  
  //friend에 바인딩이 되지 않으므로 실행 안 됨
  if let name = myName, let friend = yourName {
      print("We are friend!")
  }
  
  yourName = "eric"
  
  if let name = myName, let friend = yourName {
      print("We are friend! \(name) & \(friend)")
  }
  //We are friend! yagom & eric
  ```

### 암시적 추출 옵셔널

- 암시적 추출 옵셔널로 지정된 타입은 일반 값처럼 사용가능하고 여전히 옵셔널이기 때문에 nil도 할당 가능

- 그러나 nil이 할당되어 있을 때 접근을 시도하면 런타임 오류 발생

  ```swift
  var myName: String! = "yagom"
  print(myName) //yagom
  myName = nil
  
  myName.isEmpty //오류
  ```

### 추가 설명

- 옵셔널을 사용할 때는 강제 추출 또는 암시적 추출 옵셔널을 사용하기보다는 옵셔널 바인딩, nil 병합 연산자, 옵셔널 체이닝 등의 방법을 사용하는 편이 훨씬 안전함
- Class person 이름 성별 나이는 무조건 있지만, 애인 차 집 없을 수 있음 이게 옵셔널. 무조건 있어야하는거는 옵셔널로 하지 않는게 좋다
- Person.car.carNumber

## 추가 설명들

- Typealias는 static 으로 설정이 된다

- 도큐먼트 맨 마지막 conform to(준수하다) 많이 참고하게 될 것
- protocol document에 required 표시 돼있으면 필수 구현해야하는 것들이 있음