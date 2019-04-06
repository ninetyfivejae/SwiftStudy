# Closure

- 클로저는 c언어 objective c의 블록, 다른 프로그래밍 언어의 람다와 유사
- 클로저는 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것. 사실 함수는 클로저의 한 형태
- 클로저는 변수나 상수가 선언된 위치에서 참조를 획득하고 저장할 수 있음. 이를 변수나 상수의 클로징이라고 하며 클로저는 여기서 착안된 이름이다
- 클로저 형태
  - 이름이 있으면서, 어떤 값도 획득하지 않는 전역함수의 형태
  - 이름이 있으면서, 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태
  - 이름이 없고, 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성한 형태
- 클로저는 매개변수와 반환 값의 타입을 문맥을 통해 유추할 수 있기 때문에 매개변수와 반환 값의 타입을 생략할 수 있음
- 클로저에 단 한 줄의 표현만 들어있다면 암시적으로 이를 반환값으로 취급
- 함수를 메서드의 전달인자로 보내는 일. 함수형 프로그래밍 패러다임에서는 아주 당연한 것.

### 예제

```swift
//배열의 타입과 같은 두 개의 매개변수를 가지며 Bool 타입을 반환하는 클로저를 전달인자로 받고 있음
public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]

let names: [String] = ["wizplan", "eric", "yagom", "jenny"]
```

- 함수로만 표현했을 시

```swift
func backwards(first: String, second: String) -> Bool {
    print("\(first) \(second) 비교 중")
    return first > second
}
let firstReversed: [String] = names.sorted(by: backwards)
```

- 클로저 적용
  - 함수 따로 만들어서 전달하지 않고, 메소드 전달인자로 직접 클로저 전달
  - 함수가 어디에 있는지 어떻게 구현됐는지 찾아보지 않아도 되는 장점.
  - 근데 반복해서 같은 기능을 사용하려면 함수로 구현해두는 것도 나쁘지 않음

```swift
let secondReversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
    return first > second
})
```

- 후행 클로저 적용
  - 후행 클로저는 맨 마지막 전달인자로 전달되는 클로저에만 해당되므로, 전달인자로 클러저 여러 개를 전달할 때는 맨 마지막 클로저만 후행 클로저로 사용할 수 있음
  - 단 하나의 클로저만 전달인자로 전달하는 경우 소괄호를 생략할 수 있음

```swift
let thirdReversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first > second
}
```

```swift
let fourthReversed: [String] = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}
```

- 클로저 표현 간소화
  - 문맥을 이용한 타입 유추
  - 메소드의 전달인자로 전달하는 클로저는 메소드에서 요구하는 형태로 전달해야한다. 즉, 매개변수의 타입이나 개수, 반환 타입 등이 같아야 전달인자로서 전달할 수 있다.
  - 전달인자로 전달할 클로저는 이미 적합한 타입을 준수하고 있다고 유추할 수 있음
  - 그래서 문맥에 따라 적절히 타입을 유추할 수 있는 것임. 그래서 전달인자로 전달하는 클로저를 구현할 때는 매개변수의 타입이나 반환값의 타입을 굳이 표현해주지 않고 생략하더라도 문제가 없음

```swift
let fifthReversed: [String] = names.sorted{ (first, second) in
	return first > second
}
```

- 단축 인자 이름
  - 첫 번째 전달인자부터 `$0, $1, $2` ... 순서로 표현
  - 단축 인자 표현을 사용하게 되면 매개변수 및 반환 타입과 실행 코드를 구분하기 위해 사용했던 키워드 in을 사용할 필요가 없어짐

```swift
let fifthReversed: [String] = names.sorted() {
    return $0 > $1
}
```

- 암시적 반환 표현
  - 만약 클로저가 반환하는 값을 갖는 클로저이고 클로저 내부의 실행문이 단 한 줄이라면, 암시적으로 그 실행문을 반환값으로 사용할 수 있음

```swift
let sixthReversed: [String] = names.sorted { $0 > $1 }
```

```
["yagom", "wizplan", "jenny", "eric"]
["yagom", "wizplan", "jenny", "eric"]
["yagom", "wizplan", "jenny", "eric"]
["yagom", "wizplan", "jenny", "eric"]
["yagom", "wizplan", "jenny", "eric"]
["yagom", "wizplan", "jenny", "eric"]
```

### 연산자 함수

- 비교 연산자는 두 개의 피연산자를 통해 Bool 타입의 반환을 준다

- 클로저는, 매개변수의 타입과 반환 타입이 연산자를 구현한 함수의 모양과 동일하다면, 연산자만 표기하더라도 알아서 연산하고 반환해준다

  ```swift
  // > 이거 자체가 함수 이름
  public func ><T: Comparable>(lhs: T, rhs: T) -> Bool
  ```

- 클로저로서의 연산자 함수 사용

  ```swift
  let reversed: [String] = names.sorted(by: >)
  ```

### 값 획득

- 클로저는 자신이 정의된 위치의 주변 문맥을 통해 상수나 변수를 획득할 수 있음

- 값 획득을 통해 클로저는 주변에 정의한 상수나 변수가 더 이상 존재하지 않더라도 해당 상수나 변수의 값을 자신 내무에서 참조하거나 수정할 수 있다

- 클로저는 비동기 작업에 많이 사용된다. 클로저를 통해 비동기 콜백을 작성하는 경우, 현재 상태를 미리 획득해두지 않으면 실제로 클로저의 기능을 실행하는 순간에는 주변의 상수나 변수가 이미 메모리에 존재하지 않는 경우가 발생한다

- 중첩함수도 하나의 클로저 형태인데, 이 중첩 함수 주변의 변수나 상수를 획득해 놓을 수도 있다

- 즉, 자신을 포함하는 함수의 지역변수나 지역상수를 획득할 수 있다

  ```swift
  func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
      var runningTotal = 0
      func incrementer() -> Int {
          runningTotal += amount
          return runningTotal
      }
      return incrementer
  }
  ```

  - 중첩함수인 incrementer()는 자신 주변에 있는 runningTotal과 amount라는 두 값을 획득한다
  - 두 값을 획득한 후에 incrementer는 클로저로서 makeIncrementer함수에 의해 반환된다
  - makeIncrementer 함수의 반환 타입은 () -> Int로, 함수 객체를 반환한다는 의미이다
  - 반환하는 함수는 매개변수를 받지 않고 반환 타입은 Int인 함수로, 호출할 때마다 Int 타입의 값을 반환해준다
  - incrementer() 함수 주변에 runningTotal과 amount변수가 있다면 incrementer() 함수는 두 변수의 참조를 획득할 수 있다
  - 참조를 획득하면 runningTotal과 amount는 makeIncrementer 함수의 실행이 끝나도 사라지지 않는다. incrementer가 호출될 때마다 계속해서 사용할 수 있다
  - 각각의 incremented 함수는 언제 호출이 되더라도 자신만의 runningTotal 변수를 갖고 카운트하게 된다. 각각 자신만의 runningTotal의 참조를 미리 획득했기 때문에 다른 함수의 영향도 전혀 받지 않는다

  ```swift
  let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
  let incrementByTwo2: (() -> Int) = makeIncrementer(forIncrement: 2)
  let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)
  
  let first: Int = incrementByTwo()		//2
  let second: Int = incrementByTwo()		//4
  let third: Int = incrementByTwo()		//6
  
  let first2: Int = incrementByTwo2()		//2
  let second2: Int = incrementByTwo2()	//4
  let third2: Int = incrementByTwo2()		//6
  
  let ten: Int = incrementByTen()			//10
  let twenty: Int = incrementByTen()		//20
  let thirty: Int = incrementByTen()s		//30
  ```

### 클로저는 참조 타입

- 함수와 클로저는 참조타입이기 때문에 상수 타입인 incrementByTwo와 incrementByTen은 값 획득을 통해 runningTotal 변수를 계속해서 증가시킬 수 있었음

- 함수나 클로저를 상수나 변수에 할당할 때마다 사실은 상수나 변수에 함수나 클로저의 참조를 설정하는 것이다

- 즉 incrementByTwo라는 상수에 클로저를 할당한다는 것은 클로저의 내용물, 즉 값을 할당하는 것이 아니라 해당 클로저의 참조를 할당하는 것이다

- 결국 클로저의 참조를 다른 상수에 할당해준다면 이는 두 상수가 모두 같은 클로저를 가리킨다는 뜻이다

  ```swift
  let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
  let sameWithIncrementByTwo: (() -> Int) = incrementByTwo
  
  //같은 클로저를 참조하기 때문에 동일한 클로저가 동작하는 것을 확인할 수 있음
  let first: Int = incrementByTwo()			//2
  let second: Int = sameWithIncrementByTwo()	//4
  ```

### 탈출 클로저

- 함수의 전달인자로 전달한 클로저가 함수 종료 후에 호출될 때 클로저가 함수를 탈출한다고 표현한다

- 클로저를 매개변수로 갖는 함수를 선언할 때 매개변수 이름의 콜론(:) 뒤에 @escaping 키워드를 사용하여 클로저가 탈출하는 것을 허용한다고 명시해줄 수 있다

  - 예를 들어, 비동기 작업을 실행하는 함수들은 클로저를 컴플리션 핸들러 전달인자로 받아온다
  - 비동기 작업으로 함수가 종료되고 난 후 작업이 끝나고 호출할 필요가 있는 클로저를 사용해야할 때 탈출 클로저가 필요하다
  - @escaping 키워드를 따로 명시하지 않는다면 매개변수로 사용되는 클로저는 기본으로 비탈출 클로저이다. 비탈출 클로저는 함수의 동작이 끝난 후 전달된 클로저가 필요 없을 때 사용

- 클로저가 함수를 탈출할 수 있는 경우 중 하나는 함수 외부에 정의된 변수나 상수에 저장되어 함수가 종료된 후에 사용하는 경우가 있다

  ```swift
  var completionHandlers: [() -> Void] = []
  func someFunctionWithEscapingClosure(completionHandler: @escaping() -> Void) {
      completionHandlers.append(completionHandler)
  }
  ```

  ```swift
  typealias VoidVoidClosure = () -> Void
  let firstClosure: VoidVoidClosure = {
      print("Closure A")
  }
  let secondClosure: VoidVoidClosure = {
      print("Closure B")
  }
  
  //first와 second 매개변수 클로저는 함수의 반환값으로 사용될 수 있으므로 탈출 클로저이다
  func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
      return shouldReturnFirstClosure ? first : second
  }
  
  //함수에서 반환한 클로저가 함수 외부의 상수에 저장됨
  let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)
  
  returnedClosure()
  
  var closures: [VoidVoidClosure] = []
  
  //closure 매개변수 클로저는 함수 외부 변수에 저장될 수 있으므로 탈출 클로저이다
  func appendClosure(closure: @escaping VoidVoidClosure) {
      closures.append(closure)
  }
  ```

- @escaping 키워드를 사용하여 탈출 클로저임을 명시해주어야한다

- 클로저 모두가 탈출할 수 있는 조건이 명확하기 때문에 @escaping 키워드를 사용하여 탈출 클로저임을 명시하지 않으면 컴파일 오류가 발생함

- @escaping 키워드를 사용하여 탈출 클로저임을 명시한 경우, 클로저 내부에서 해당 타입의 프로퍼티나 메소드, 서브스크립트 등에 접근하려면 self 키워드를 명시적으로 사용해야한다

  ```swift
  typealias VoidVoidClosure = () -> Void
  
  func functionWithNoescapeClosure(closure: VoidVoidClosure) {
      closure()
  }
  
  func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
      return completionHandler
  }
  
  class SomeClass {
      var x = 10
      
      func runNoescapeClosure() {
          functionWithNoescapeClosure { x = 200 }
      }
      
      func runEscapingClosure() -> VoidVoidClosure {
          return functionWithEscapingClosure { self.x = 100 }
      }
  }
  
  let instance: SomeClass = SomeClass()
  instance.runNoescapeClosure()
  //instance.x ==> 200
  
  let returnedClosure: VoidVoidClosure = instance.runEscapingClosure()
  returnedClosure()
  //instance.x ==> 100
  ```

### withoutActuallyEscaping

- 실제로 탈출하지 않는데 다른함수에서 탈출 클로저를 요구하는 상황

  - hasElement(in:match:) 함수는 @escaping 키워드가 없으므로 비탈출 클로저를 전달받게 된다
  - 그리고 내부에서 배열의 lazy 컬렉션에 있는 filter 메소드의 매개변수로 비탈출 클로저를 전달한다
  - 그런데 lazy 컬렉션은 비동기 작업을 할 때 사용하기 때문에 filter메소드가 요구하는 클로저는 탈출 클로저이다
  - 그래서 탈출 클로저 자리에 비탈출 클로저를 전달할 수 없다는 오류와 마주하게 된다

  ```swift
  func hasElement(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
      return (array.lazy.filter { predicate($0) }.isEmpty == false)
  }
  ```

- 그런데 함수 전체를 보면, match 클로저가 탈출할 필요가 없음. 이때 해당 클로저를 탈출 클로저인양 사용할 수 있게 돕는 withoutActuallyEscaping(_:do:) 함수가 있다

  ```swift
  let numbers: [Int] = [2,4,6,8]
  
  let evenNumberPredicate = { (number: int) -> Bool in 
  	return number % 2 == 0
  }
  
  let oddNumberPredicate = { (number: Int) -> Bool in
  	return number % 2 != 0
  }
  
  func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
      return withoutActuallyEscaping(predicate, do: { escapablePredicate in
  		return (array.lazy.filter { escapablePredicate($0) }.isEmpty == false)
  	})
  }
  
  let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)	//true
  let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)		//false
  ```

### 자동 클로저

- 함수의 전달인자로 전달하는 표현을 자동으로 변환해주는 클로저를 자동클로저라고 한다

- 자동클로저는 전달인자를 갖지 않는다

- 자동클로저는 호출되었을 때 자신이 감싸고 있는 코드의 결과값을 반환한다

- 자동클로저는 함수로 전달하는 클로저를 (소괄호와 중괄호를 겹쳐서 써야하는) 어려운 클로저 문법을 사용하지 않고도 클로저로 사용할 수 있도록 문법적 편의를 제공한다

- 스위프트 표준 라이브러리에는 자동클로저를 호출하는 함수가 구현되어 있어 이를 사용하는 일이 종종 있다. 하지만 직접 자동클로저를 호출하는 함수를 구현하는 일은 흔치 않다. 예를 들어, 스위프트 표준 라이브러리에 구현되어 있는 assert(condition:message:file:line:) 함수는 condition과 message 매개변수가 자동클로저이다. Condition 매개변수는 디버그용 빌드에서만 실행되고, message 매개변수는 condition 매개변수가 false일 때만 실행된다

- 자동 클로저는 클로저가 호출되기 전까지 클로저 내부의 코드가 동작하지 않아서 연산을 지연시킬 수 있음. 이 과정은 연산에 자원을 많이 소모한다거나 부작용이 우려될 때 유용하게 사용할 수 있음. 코드의 실행을 제어하기 좋기 때문

  ```swift
  var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
  print(customerInLine.count)					//4
  
  //클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있음
  let customerProvider: () -> String = {
      return customerInLine.removeFirst()
  }
  print(customerInLine.count)					//4
  
  //실제로 실행
  print("Now serving \(customerProvider())")	//4
  print(customerInLine.count)					//3
  ```

  ```swift
  //함수 전달인자로 직접 클로저를 작성하여 전달. 클로저의 암시적 반환 표현
  func serveCustomer(_ customerProvider: () -> String) {
      print("Now serving \(customerProvider())")
  }
  
  serveCustomer( { customersInLine.removeFirst() })
  ```

- 자동클로저 사용 예제

  ```swift
  func serveCustomer(_ customerProvider: @autoclosure () -> String) {
      print("Now serving \(customerProvider())")
  }
  
  serveCustomer(customersInLine.removeFirst())
  ```

  - 기존의 serveCustomer(_:) 함수와 동일한 역할을 하지만 매개변수에 @autoclosure 속성을 주었기 때문에 자동클로저 기능을 사용한다
  - 자동클로저 속성을 부여한 매개변수는 클로저 대신에 customersInLine.removeFirst() 코드의 실행 결과인 String 타입의 문자열을 전달인자로 받게 된다
  - String 타입의 값이 자동 클로저 매개변수에 전달되면 String값을 매개변수가 없는 String값을 반환하는 클로저로 변환해준다
  - String 타입의 값을 전달 받는 이유는 자동클로저의 반환 타입이 String이기 때문이다
  - 자동클로저는 전달인자를 갖지 않기 때문에 반환 타입의 값이 자동클로저의 매개변수로 전달되면 이를 클로저로 바꿔줄 수 있는 것이다
  - 이렇게 String값으로 전달된 전달인자가 자동으로 클로저로 변환되기 때문에 자동클로저라고 부른다
  - 자동클로저를 사용하면 기존의 사용방법처럼 클로저를 전달인자로 넘겨줄 수 없음

- 기본적으로 @autoclosure 속성은 @noescape 속성을 포함한다. 즉, @autoclosure 속성을 사용하면 @noescape 속성도 부여됨을 암시하는 것이다

- 만약 자동 클로저를 탈출하는 클로저를 사용하고 싶다면 @autoclosure 속성 뒤에 @escaping 속성을 덧붙여서 @autuclosure @escaping처럼 사용하면 된다

  ```swift
  func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
      return customerProvider
  }
  
  let customerProvider: () -> String = return Provider(customersInLine.removeFirst())
  print("Now serving \(customerProvider())") //Now serving YoangWha
  ```

