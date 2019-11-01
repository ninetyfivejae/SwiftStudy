# Inheritance

## 상속

- 수직으로 클래스를 확장할 수 있는 상속. 기반클래스(다른 클래스로부터 상속을 받지 않은 클래스)를 다른 클래스에서 물려받는 것
- 클래스는 부모클래스로부터 물려받은 메소드를 호출할 수 있고, 프로퍼티에 접근할 수 있으며, 서브스크립트도 사용할 수 있다
- 또, 부모클래스로부터 물려받은 메소드, 프로퍼티, 서브스크립트 등을 자신만의 내용으로 재정의할 수 있음
- 연산 프로퍼티를 정의해준 클래스에서는 연산 프로퍼티에 프로퍼티 감시자를 구현할 수 없지만, 부모클래스에서 연산 프로퍼티로 정의한 프로퍼티든, 저장 프로퍼티로 정의한 프로퍼티든 자식클래스에서는 프로퍼티 감시자를 구현할 수 있음
- 상속을 통해 기반클래스보다 세분화된 특징이 있고, 더 많은 기능을 실행할 수 있는 새로운 자식클래스를 만들어 줄 수 있음

## 재정의

- 자식클래스가 부모클래스로부터 물려받은 특성을 그대로 사용하지 않고 자신만의 기능으로 변경하여 사용하는 것
- override 키워드 사용
- 재정의할 때, 부모클래스의 특성을 자식클래스에서 사용하고 싶다면 super 프로퍼티를 사용하면 된다
- super키워드를
  - 타입 메소드 내에서 사용한다면 부모클래스의 타입 메소드와 타입 프로퍼티에 접근할 수 있음
  - 인스턴스 메소드 내에서 사용한다면 부모클래스의 인스턴스 메소드와 인스턴스 프로퍼티, 서브스크립트에 접근할 수 있음
- super.SomeMethod()
- super.someProperty
- super[index]

### 메소드 재정의

- [주의] 반환 타입이 다르거나 매개변수가 다르면 서로 다른 메소드로 취급한다

  ```swift
  class Person {
      var name: String = ""
      var age: Int = 0
      
      var introduction: String {
          return "이름: \(name). 나이: \(age)"
      }
      
      func speak() {
          print("가나다라마바사")
      }
      
      class func introduceClass() -> String {
          return "인류의 소원은 평화입니다"
      }
  }
  
  class Student: Person {
      var grade: String = "F"
      
      func study() {
          print("Study hard ... ")
      }
      
      override func speak() {
          print("저는 학생입니다")
      }
  }
  
  class University: Student {
      var major: String = ""
      
      class func introduceClass() {
          print(super.introduceClass())
      }
      
      override class func introduceClass() -> String {
          return "대학생의 소원은 A+입니다."
      }
      
      override func speak() {
          super.speak()
          print("대학생이죠")
      }
  }
  ```

  ```swift
  let yagom: Person = Person()
  yagom.speak()
  
  let jay: Student = Student()
  jay.speak()
  
  let jenny: UniversityStudent = UniversityStudent()
  jenny.speak()
  
  print(Person.introduceClass())
  print(Student.introduceClass())
  print(UniversityStudent.introduceClass() as String)
  UniversityStudent.introduceClass() as Void
  ```

### 프로퍼티 재정의

- 메소드와 마찬가지로 부모클래스로부터 상속받은 인스턴스 프로퍼티나 타입 프로퍼티를 자식 클래스에서 용도에 맞게 재정의할 수 있음

- [주의] 프로퍼티를 재정의할 때 저장 프로퍼티로 재정의할 수는 없음

- 프로퍼티를 재정의한다는 것은 프로퍼티 자체가 아니라 프로퍼티의 getter, setter, property observer 등을 재정의하는 것을 의미한다

- 재정의하려는 프로퍼티는 조상클래스 프로퍼티의 이름과 타입이 일치해야한다

- 조상클래스에서 읽기 정용 프로퍼티였더라도 자식클래스에서 읽고 쓰기가 가능한 프로퍼티로 재정의해줄 수도 있음. 하지만 읽기 쓰기 모두 가능했던 프로퍼티를 읽기 전용으로 재정의하는건 안 된다

- 읽기 쓰기가 모두 가능한 프로퍼티를 재정의할 때, setter만 따로 재정의할 수는 없음. 즉 getter setter 모두 재정의해야한다

  ```swift
  class Person {
      var name: String = ""
      var age: Int = 0
      var koreanAge: Int {
          return self.age + 1
      }
      
      var introduction: String {
          return "이름: \(name). 나이: \(age)"
      }
  }
  
  class Student: Person {
      var grade: String = "F"
      
      override var introduction: String {
          return super.introduction + " " + "학점: \(self.grade)"
      }
      
      override var koreanAge: Int {
          get {
              return super.koreanAge
          }
          set {
              self.age = newValue - 1
          }
      }
  }
  ```

  ```swift
  let yagom: Person = Person()
  yagom.name = "yagom"
  yagom.age = 55
  yagom.koreanAge = 56		//오류 발생
  print(yagom.introduction)
  print(yagom.koreanAge)
  
  let jay: Student = Student()
  jay.name = "jay"
  jay.age = 14
  jay.koreanAge = 15
  print(jay.introduction)
  print(jay.koreanAge)
  ```

### 프로퍼티 감시자 재정의

- 프로퍼티 감시자도 프로퍼티의 접근자와 설정자처럼 재정의할 수 있음.

- 조상클래스에 정의한 프로퍼티가 연산 프로퍼티인지 저장 프로퍼티인지는 상관없음

- [주의] 상수 저장 프로퍼티나 읽기 전용 연산 프로퍼티는 프로퍼티 감시자를 재정의할 수 없음. 근본적으로 값을 설정할 수 없기 때문에 willSet, didSet 메소드를 사용한 프로퍼티 감시자를 사용할 수 없음

- 프로퍼티 감시자를 재정의하더라도 조상클래스에 정의한 프로퍼티 감시자도 동작한다

- [주의] 프로퍼티 접근자getter와 프로퍼티 감시자는 동시에 재정의할 수 없음. 만약 둘 다 동작하길 원한다면 재정의하는 접근자에 프로퍼티 감시자의 역할을 구현해야한다

  ```swift
  class Person {
      var name: String = ""
      var age: Int = 0 {
          didset {
              print("Person age: \(self.age)")
          }
      }
      
      var koreanAge: Int {
          return self.age + 1
      }
      
      var fullName: String {
          get {
              return self.name
          }
          set {
              self.name = newValue
          }
      }
  }
  
  class Student: Person {
      var grade: String = "F"
      
      override var age: Int {
          didSet {
              print("Student age: \(self.age)")
          }
      }
      
      override var koreanAge: Int {
          get {
              return super.koreanAge
          }
          set {
              self.age = newValue - 1
          }
          didset {} // 오류 발생 ==> 상수저장프로퍼티나, 읽기전용프로퍼티는 감시자를 재정의할 수 없음
      }
      
      override var fullName: String {
          didSet {
              print("Full Name: \(self.fullName)")
          }
      }
  }
  ```

### 서브스크립트 재정의

- 서브스크립트도 메소드와 마찬가지로 재정의 가능

- 서브스크립트도 매개변수와 반환타입이 다르면 다른 서브스크립트로 취급하므로, 자식클래스에서 재정의하려는 서브스크립트라면 부모클래스 서브스크립트의 매개변수와 반환 타입이 같아야한다.

  ```swift
  class School {
      var students: [Student] = [Student]()
      
      subscript(number: Int) -> Student {
          print("School subscript")
          return Students[number]
      }
  }
  
  class MiddleSchool: School {
      var middleStudents: [Student] = [Student]()
      
      override subscript(index: Int) -> Student {
          print("MiddleSchool subscript")
          return middleStudents[index]
      }
  }
  ```

### 재정의 방지

- 만약 부모클래스를 상속받는 자식클래스에서 몇몇 특정을 재정의할 수 없도록 제한하고 싶다면 재정의를 방지하고 싶은 특성 앞에 final 키워드를 명시하면 된다.
- final 키워드가 붙은 특성들을 자식클래스에서 재정의하려고 하면 컴파일 오류가 난다
- 만약 클래스를 상속하거나 재정의할 수 없도록 하고 싶다면 class 키워드 앞에 final 키워드를 명시해주면 된다













## 클래스의 이니셜라이저 - 상속과 재정의

- 