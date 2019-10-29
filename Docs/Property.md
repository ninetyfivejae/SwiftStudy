# Property(Stored, Computed, Class)

> - Stored Property
> - Lazy Stored Property
> - Computed Property
> - Type Property
> - Property Observer
> - 전역변수와 지역변수
>
> ---
>
> - **Stored Property**(저장 프로퍼티): 상수와 변수 값을 인스턴스의 일부로 저장함.
>   클래스와 구조체에서만 사용
> - **Computed Property**(연산 프로퍼티): 값을 연산함(저장(store)하기 보다는) 그때그때 특정 연산은 수행하여 값을 반환함.
>   클래스, 구조체 그리고 **열거형**에서 사용
> - **Type Property**(타입 프로퍼티): Stored Property(저장 프로퍼티)와  Computed Property(연산 프로퍼티)는 일반적으로 특정 타입의 인스턴스와 연결된다. 그러나 프로퍼티를 타입 자체와 연결할 수도 있음.

## Stored Property

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

## Lazy Stored Property

- 값이 사용되기 전까지는 값이 계산되지 않는 프로퍼티

- lazy 키워드 사용하여 선언함

- 모든 저장 속성은 인스턴스의 초기화가 완료된 시점에 적절한 값으로 초기화되어야 한다.
  만약 파일에 저장되어 있는 값으로 초기화해야하는 속성이 있다면 다른 속성에 비해 많은 메모리 공간이 필요하고 초기화에 소요되는 시간이 길어질 수 있음.
  그리고 프로그램 실행되는 동안 이 속성을 한 번도 사용하지 않으면 불필요한 메모리 낭비가 된다

- 그래서 Lazy stored property를 사용하면, 초기화 과정에서 초기화되지 않고 속성에 처음 접근하는 시점에 초기화된다.
  큰 값을 저장하거나 속성의 값이 초기화 이후에 결정되는 값에 의존적인 경우 활용할 수 있음

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

## Computed Property

- stored property처럼 값을 직접 저장하지 않고, 값들을 연산하여 stored property에 전달해주는 역할

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

## Type Property

- 인스턴스 프로퍼티는 특정 인스턴스에 속한 프로퍼티를 말한다. 이 프로퍼티는 새로운 인스턴스가 생성될 때마다 새로운 프로퍼티도 같이 생성된다.

- 프토퍼티를 타입 자체에 연결할 수 있음. 타입 프로퍼티는 특정 타입에 속한 프로퍼티로 그 타입에 해당하는 단 하나의 프로퍼티만 생성된다.

  - 타입 프로퍼티는 모든 타입이 사용할 수 있는 상수 프로퍼티(constants property) (ex : C의 static 상수)
  - 또는 글로번 변수 프로퍼티와 같이 특정 타입의 모든 인스턴스에 공통적인 값을 정의하는 데 유용함. ( ex: C의 static 변수)

- 타입프로퍼티에는, Stored Type Property(저장 타입 프로퍼티)와 Computed Type Property(연산 타입 프로퍼티)가 있음

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

## Property Observer

- property observer는 속성 값의 갱신 전후에 특정 코드를 실행하는 수단을 제공.
  다른 언어에서 observer pattern 또는 notification pattern, delegate pattern을 구현하여 유사한 기능을 제공함

- Property Observers를 정의해서 프로퍼티 값의 변경을 모니터링 할 수 있음.
  프로퍼티 옵저버는 자신이 정의한 "저장 프로퍼티"에 추가 할 수 있으며, 부모클래스를 상속한 프로퍼티에도 추가 할 수 있다.

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

## 전역변수와 지역변수

- 프로퍼티를 계산하고 관찰하기 위해서 위에서 설명한 프로퍼티 옵저버 기능은 전역변수와 지역변수에서도 사용할 수 있음
  - 전역변수: 함수, 메소드, 클로저 또는 type context외부에 정의되는 변수
  - 지역변수: 함수, 메소드 또는 closure context내에서 정의되는 변수
    - **전역상수와 전역변수는 항상 게으르게 연산된다. 즉, 필요할 때 초기화해줘야함**
    - **전역상수와 전역변수는 연산 프로퍼티와는 다르게 lazy키워드가 필요없다**
    - **지역상수와 지역변수는 게으르게 연산되지 않는다**

