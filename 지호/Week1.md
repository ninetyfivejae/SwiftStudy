# 스터디 1주차
---

# 상수와 변수

>상수 선언 키워드 **let**
변수 선언 키워드 **var**


**상수의 선언**
~~~
let 이름: 타입 = 값
~~~

**변수의 선언**
~~~
var 이름: 타입 = 값
~~~

**값의 타입이 명확하다면 타입은 생략 가능**
~~~
let 이름 = 값
var 이름 = 값
~~~
---
# 함수의 정의 및 사용법

**함수의 선언**
~~~
func 함수 이름(매개변수...) -> 반환 타입 {
    실행 구문
    return 반환 값
}
~~~
- 매개변수가 여러 개 필요한 경우 쉼표(,)로 구분

**매개변수 이름과 전달인자 레이블**
~~~
func 함수 이름 (전달인자 레이블 매개변수 이름: 매개변수 타입) -> 
	반환 타입 {
    실행구문
    return 반환 값
}
~~~
- 함수 내부에서 전달인자 레이블을 사용할 수 없으며, 함수를 호출할 때는 매개변수 이름을 사용할 수 없음
- 전달인자 레이블을 사용하고 싶지 않다면 와일드카드 식별자를 사용

---
- 전달인자 레이블을 변경하면 함수의 이름 자체가 변경
- 따라서 전달인자 레이블만 다르게 써주더라도 오버로드 동작할 수 있음
~~~
func sayHello(to name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
       result += "Hello\(name)!" + " "
    }
}
func sayHello(to name: String, repeatCount times: Int) -> 
	String {
    var result: String = ""
    
    for _ in 0..<times {
       result += "Hello\(name)!" + " "
    }
}
~~~

---

**매개변수 기본값**
~~~
func sayHello(_ name: String, times: Int = 3) -> String {
    var result: String = ""
    for _ in 0..<times {
    result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("Hana"))
print(sayHello("Joe", times: 2))
~~~
- 가변 매개변수는 "..."을 붙이면 사용 가능(함수당 한 개 사용가능)

---
**반환 값이 없는 함수**

~~~
func sayHelloWorld() {
    print("Hello, world!")
}

func sayHelloWorld() -> Void {
    print("Hello, world!")
}
~~~
---
**데이터 타입으로의 함수**
- 스위프트의 함수는 일급 객체이므로 하나의 데이터 타입으로 사용 가능
- 각 함수는 매개변수 타입과 반환 타입으로 구성된 하나의 타입으로 정의 가능

~~~
typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
print(mathFunction(2,5))	//7
mathFunction = multiplyTwoInts
print(mathFunction(2,5))	//10
~~~
---

**중첩 함수**
- 함수의 사용 범위를 한정하고자 함수를 하나의 함수 안쪽으로 배치
- 필요할 때만 외부에서 사용할 수 있음

~~~
typealias MoveFunc = (Int) -> Int

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }
    
    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft : goRight
}
var position: Int = -4
let moveToZero: MoveFunc = functionForMove(position > 0 )
position = moveToZero(position)
~~~

---
# 옵셔널 바인딩

> 옵셔널 : 값이 있을 수도 있고 없을 수도 있다는 뜻

상수에는 nil값을 할당할 수 없음

*옵셔널은 왜 필요할까?*
- nil의 가능성을 명시적으로 표현
- nil 가능성을 문서화하지 않아도 코드만으로 충분히 표현 가능
- 전달받은 값이 옵셔널이 아니라면 nil 체크를 하지 않더라도 안심하고 사용
~~~
func someFunction(someOptionalParam: Int?) {
    //...
}
func someFunction(someParam: Int) {
    //...
}
someFunction(someOptionalParam: nil)
someFunction(someParam: nil)		//오류남    
~~~
---
## Optional은 ?와 !를 사용

**!은 암시적 추출 옵셔널이라고 함**
~~~
var optionalValue {
    case .none:
        print("This Optional variable is nil")
    case .some(let value)
        print("Value is \(value)")
}
~~~
- 기존 변수처럼 사용 가능
~~~
optionalValue = optionalValue + 1
~~~
- nil 할당 가능
~~~
optionalValue = nil
~~~
- 할당은 가능하지만 nil값에 접근하면 런타임 오류 발생
~~~
optinalValue = optionalValue + 1	//오류 발생
~~~

---

**?는 일반적인 Optional**
~~~
var optionalValue: Int? = 100

switch optionalValue {
    case .none:
        print("This Optional variable is nil")
    case .some(let value)
        print("Value is \(value)")
}        
~~~
- nil 할당 가능
~~~
optionalValue = nil
~~~
- 옵셔널과 일반 값은 다른 타입이므로 기존 변수처럼 사용 불가
~~~
optionalValue = optionalValue + 1 	//오류
~~~

---

## 옵셔널 값 추출

> 옵셔널 바인딩
> 강제 추출


**옵셔널 바인딩**
- 상자에 값이 있는지 물어보는 것
- 있으면 꺼내오고 없으면 지나침

~~~
func printName(_ name: String) {
    print(name)
}
var myName: String? = nil

if let name: String = myName {
    printName(name)
}else {
    print("myName == nil")
}   
~~~

---

**한꺼번에 옵셔널 바인딩**
~~~
var myName: String? = "yagom"
var yourName: String? = nil

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}
//yourName이 nil이기 때문에 실행되지 않음

yourName = "hana"

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}
//yagom and hana
~~~

---

**Force Unwrapping - 옵셔널의 값을 강제로 추출**
- 노크해서 정중하게 값을 꺼내오던 방식과 다르게 옵셔널 보호막을 강ㅇ제로 깨부수고 가져오는 방식

~~~
func printName(_ name: String) {
    print(name)
}
var myName: String? = "yagom"
printName(myName!)	//yagom, "!"를 붙이면 강제로 추출한다는 뜻

myName = nil
printName(myName!)  //강제추출시 값이 없으므로 런타임 오류 발생
var yourName: String! = nil
printName(yourName)  //nil값이라서 런타임 오류 발생
~~~
- 암시적 추출 옵셔널은 뒤에 느낌표를 붙이지 않아도 값을 전달할 수 있음
- nil 값이 전달되면 오류 발생, 따라서 강제추출은 추천하는 방법이 아님

---
# struct, class, enum
### 구조체
**구조체의 선언**
~~~
struct 이름 {
   //구현부
}
~~~
- 구조체(타입)안에 변수(인스턴스)들이 프로퍼티, 타입안에 들어가있는 함수를 메소드
~~~
struct Sample {
   var mutableProperty: Int = 100     //가변 프로퍼티
   let immutableProperty: Int = 100    //불변 프로퍼티 
        //(이 둘은 인스턴스 프로퍼티)
   static var typeProperty: Int = 100   //타입 프로퍼티
	//인스턴스 메서드
   func instanceMethod() {
	print(“instance method”)
   }
	//타입 메서드
   static func typeMethod() {
   	print(“type method”)
   }
}


~~~
---

**구조체의 사용**
- 가변 인스턴스

~~~
var mutable: Sample = Sample()

mutable.mutableProperty = 200
mutable.immutableProperty = 200	//오류남, 불변프로퍼티는 바꿀 수 없음
~~~

- 불변 인스턴스

~~~
let immutable: Sample = Sample()

immutable.mutableProperty = 200	 //가변 프로퍼티라도 안됨
immutable.immutableProperty = 200 //안됨

//타입 프로퍼티 및 메소드 (타입 자체가 사용하는 프로퍼티와 메소드)
Sample.typeProperty = 300
Sample.typeMethod()	//type method

mutable.typeProperty = 400	//안됨
mutable.typeMethod() //인스턴스에서 타입프로퍼티나 메소드 사용못함
~~~



---
ex) 학생 구조체
~~~
struct Student {
	var name: String = “unknown”
	var ‘class’: String = “Swift” //class라는 키워드가 
    있어서 ‘’로 묶어주면 다른의미로 사용할 수 있음

	static func selfIntroduce() {
		print(“학생타입입니다”)
	}

	func selfIntroduce() {
		print(“저는 \(self.class)반 \(name)입니다”)
	}
}

Student.selfIntroduce()		//학생입니다

var yagom: Student = Student()
yagom.name = “yagom”
yagom.class = “스위프트”
yagom.selfIntroduce()		//저는 스위프트반 yagom입니다

let jina: Student = Student()
jina.name = “jina”	//불변 인스턴스이므로 프로퍼티 값 변경 불가, 오류 발생
jina.selfIntroduce()	//저는 Swift반 unknown입니다
~~~

---

### 클래스
- 구조체와 매우 유사
- 구조체는 값 타입, 클래스는 참조 타입
- 다중상속 안됨


**정의**
~~~
class 이름 {
   //구현부
}
~~~
---

~~~
class Sample {
	var mutableProperty: Int = 100	  //가변 프로퍼티
	let immutableProperty: Int = 100  //불변 프로퍼티

	static var typeProperty: Int = 100 //타입 프로퍼티

	//인스턴스 메소드
	func instanceMethod() {
		print(“instance method”)
	}

	//타입 메소드
	//재정의 불가 타입 메소드 - static
	static func typeMethod() {
		print(“type method - static”)
	}

	//재정의 가능 타입 메소드 - class
	class func classMethod() {
		print(“type method - class”)
	}
}
~~~

---

**클래스의 사용**
- 인스턴스 생성 (참조정보 수정 가능)
~~~
var mutableReference: Sample = Sample()

mutableReference.mutableProperty = 200

// 불변 프로퍼티는 인스턴스 생성 후 수정할 수 없습니다
// 컴파일 오류 발생
//mutableReference.immutableProperty = 200
~~~

- 인스턴스 생성 (참조정보 수정 불가)

~~~
let immutableReference: Sample = Sample()

// 클래스의 인스턴스는 참조 타입이므로 let으로 선언되었더라도 
   인스턴스 프로퍼티의 값 변경이 가능, 구조체랑 다른점
   
immutableReference.mutableProperty = 200 //안됨
~~~

---
### 열거형
- 각각의 케이스가 고유의 값으로 취급이 됨

~~~
enum Weekday {
	case mon
	case tue	
	case wed
	case thu, fri, sat, sun
}
var day: Weekday = Weekday.mon
day = .tue		

print(day)
switch day {
	case .mon, .tue, .wed, .thu:
		print(“평일입니다”)
	case Weekday.fri:
		print(“금요일입니다”)
	case .sat, .sun:
		print(“주말”)
}
~~~
