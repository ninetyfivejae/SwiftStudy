# let / var / func

## 1. 상수와 변수

### let 상수, var 변수

- let (this variable) X = (equal to) 10 이런 의미에서 고정된 값인 상수 keyword가 let으로 된다
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
  var num: Int
  var str: String
  var a,b,c: Int
  var a: Int, b: Float, c: String
  ```

## 2. 함수 정의 및 사용법

> - Formal Parameter와 Argument
> - Argument Label & Parameter Name
> - 파라미터 기본 값 설정
> - 가변 파라미터 ...
> - 입출력 파라미터 inout
> - 복합 Return 값
> - Function Types
> - Nested Functions

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

- 함수는 코드의 최상위 레벨에 선언, 메소드는 특정 형식 내부에 선언.
  그래서 함수는 이름만으로 호출 가능, 메소드는 반드시 연관된 형식 이름이나 인스턴스 이름을 통해 호출해야 함

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

- Swift 함수의 파라미터는 상수임. 함수 내부에서 파라미터의 값을 새로운 값으로 변경할 수 없음.
  파라미터로 전달되는 값이 의도와 다르게 변경되는 오류를 사전에 방지할 수 있으나 코드의 유연성은 떨어짐

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

- 함수 파라미터들은 상수로 설정이 되어 함수 내부에서 값을 변경할 수 없음. 
  그래서 값을 변경하고 싶다면 임시 변수를 선언한 후 이 변수를 변경해야 하는데,

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

