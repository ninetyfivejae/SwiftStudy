# Class / Struct / Enum

## Class

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

## Struct

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

## Enum

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

