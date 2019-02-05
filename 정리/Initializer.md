# 인스턴스 생성 및 소멸

- 인스턴스의 첫 사용을 위해 초기화하는 것

- 새로운 인스턴스를 사용할 준비를 하기 위하여 저장 프로퍼티의 초깃값을 설정하는 등의 일을 한다

- init 키워드를 사용하여 이니셜라이저 메소드임을 표현함

- 클래스, 구조체, 열거형 등의 구현부 또는 익스텐션 구현부에 위치

- [주의] 다만, 클래스의 지정 이니셜라이저는 익스텐션에서 구현할 수 없음

- [주의] enum은 초기화할 때 반드시 case 중 하나가 되어야 한다

  ```swift
  class SomeClass {
      init() {
          //초기화할 때 필요한 코드
      }
  }
  
  struct SomeStruct {
      init() {
          //초기화할 때 필요한 코드
      }
  }
  
  enum SomeEnum {
      case someCase
      
      //enum은 초기화할 때 반드시 case 중 하나가 되어야 한다
      init() {
          self.someCase
          //초기화할 때 필요한 코드
      }
  }
  ```

## 프로퍼티 기본값

- 구조체와 클래스의 인스턴스는 처음 생성할 때 옵셔널 저장 프로퍼티를 제외한 모든 저장 프로퍼티에 적절한 초기값을 할당해야한다

- 이니셜라이저가 실행될 때 저장 프로프티에 적절한 초기값을 할당할 수 있음

- 초기화 후에 값이 확정되지 않은 저장 프로퍼티는 존재할 수 없음

- 프로퍼티를 정의할 때 프로퍼티 기본값을 할당하면, 이니셜라이저에서 따로 초기값을 할당하지 않더라도 프로퍼티 기본값으로 저장 프로퍼티의 값이 초기화된다

- [주의] 이니셜라이저를 통해 초기값을 할당하거나, 프로퍼티 기본값을 통해 처음 저장 프로퍼티가 초기화될 때는 프로퍼티 감시자 메소드는 호출되지 않는다

  ```swift
  //이니셜라이저로 저장 프로퍼티에 초기값 설정하는 방식
  struct Area {
      var squareMeter: Double
      
      init() {
          squareMeter = 0.0
      }
  }
  ```

  ```swift
  //프로퍼티에 기본값을 할당하는 방식
  struct Area {
      var squareMeter: Double = 0.0
  }
  ```

  ```swift
  let room: Area = Area()
  print(room.squareMeter)	//0.0
  ```

## 이니셜라이저 매개변수. 사용자 정의 이니셜라이저

- 사용자 정의 이니셜라이저를 만들면 기존의 기본 이니셜라이저는 별도로 구현하지 않는 이상 사용할 수 없음

  ```swift
  struct Area {
      var squareMeter: Double
      
      init(fromPy py: Double) {
          squareMeter = py * 3.3058
      }
      
      init(fromSquareMeter squareMeter: Double) {
          self.squareMeter = squareMeter
      }
      
      init(value: Double) {
          squareMeter = value
      }
      
      init(_ value: Double) {
          squareMeter = value
      }
  }
  
  let roomOne: Area = Area(fromPy: 15.0)
  let roomTwo: Area = Area(fromSquareMeter: 33.06)
  let roomThree: Area = Area(value: 30.0)
  let roomFour: Area = Area(55.0)
  
  Area() //오류 발생
  ```

## 옵셔널 프로퍼티 타입

- 인스턴스가 사용되는 동안에 값을 꼭 갖지 않아도 되는 저장 프로퍼티가 있거나 초기화 과정에서 값을 지정해주기 어려운 경우, 해당 프로퍼티를 옵셔널로 선언할 수 있음

  ```swift
  class Person {
      var name: String
      var age: Int?
      
      init(name: String) {
          self.name = name
      }
  }
  ```

## 상수 프로퍼티

- 상수로 선언된 저장 프로퍼티는 인스턴스를 초기화하는 과정에서만 값을 할당할 수 있음
- 처음 할당된 이후로는 값을 변경할 수 없음
- [주의] 클래스 인스턴스의 상수 프로퍼티는 프로퍼티가 정의된 클래스에서만 초기화할 수 있음. 해당 클래스를 상속박은 자식클래스의 이니셜라이저에서는 부모클래스의 상수 프로퍼티 값을 초기화할 수 없음

## 기본 이니셜라이저와 멤버와이즈 이니셜라이저(Struct)

- 기본 이니셜라이저

  - 사용자 정의 이니셜라이저를 정의해주지 않으면 클래스나 구조체는 모든 프로퍼티에 기본값이 지정되어 있다는 전제하에 기본 이니셜라이저를 사용한다
  - 기본 이니셜라이저는 프로퍼티 기본값으로 프로퍼티를 초기화해서 인스턴스를 생성한다
  - 기본 이니셜라이저는 저장 프로퍼티의 기본값이 모두 지정되어 있고, 동시에 사용자 정의 이니셜라이저가 정의되어 있지 않은 상태에서 사용할 수 있다

- 멤버와이즈 이니셜라이저

  - 저장 프로퍼티를 선언할 때 기본값을 지정해주지 않으면 이니셜라이저에서 초기값을 설정해야한다. 하지만 프로퍼티 하나 때문에 매번 이니셜라이저를 추가하거나 변경하게 되면 귀찮기 때문에

  - 구조체는 사용자 정의 이니셜라이저를 구현하지 않으면, 프로퍼티의 이름으로 매개변수를 갖는 이니셜라이저인 멤버와이즈 이니셜라이저를 기본으로 제공한다

  - 클래스는 멤버와이즈 이니셜라이저를 지원하지 않으므로 멤버와이즈 이니셜라이저는 구조체만의 특권이다

    ```swift
    struct Point {
        var x: Double = 0.0
        var y: Double = 0.0
    }
    
    let point: Point = Point(x: 0, y: 0)
    ```

## 초기화 위임

- 값 타입인 구조체와 열거형은 코드의 중복을 피하기 위해 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임하는 초기화 위임을 간단하게 구현할 수 있음

- [주의] 하지만 클래스는 상속을 지원하기 때문에 간단한 초기화 위임도 할 수 없음

- 값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출하려면 self.init을 사용한다

- 당연히 self.init은 이니셜라이저 안에서만 사용할 수 있는데, self.init을 사용한다는 것 자체가 사용자 정의 이니셜라이저를 정의하고 있다는 뜻이다

- 그런데 사용자 정의 이니셜라이저를 정의하면 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 사용할 수 없다고 했다. 따라서 초기화 위임을 하려면 최소 두 개 이상의 사용자 정의 이니셜라이저를 정의해야 한다

- 사용자 정의 이니셜라이저와 기본 이니셜라이저, 멤버와이즈 이니셜라이저를 모두 사용하고 싶으면 익스텐션을 사용하여 사용자 정의 이니셜라이저를 구현하면 된다

  ```swift
  enum Student {
      case elementary, middle, high
      case none
      
      //사용자 정의 이니셜라이저가 있는 경우, init() 메소드를 구현해줘야 기본 이니셜라이저를 사용할 수 있음
      init() {
          self = .none
      }
      
      init(koreanAge: Int) {
          switch koreanAge {
              case 8...13:
              	self = .elementary
              case 14...16:
              	self = .middle
              case 17...19:
              	self = .high
              default:
              	self = .none
          }
      }
      
      //초기화 위임 사용자 이니셜라이저
      init(bornAt: Int, currentYear: Int) {
          self.init(koreanAge: currentYear - bornAt + 1)
      }
  }
  
  var younger: Student = Student(koreanAge: 16)
  print(younger) //middle
  
  younger = Student(bornAt: 1998, currentYear: 2016)
  print(younger) //high
  ```

## 실패 가능한 이니셜라이저

- 이니셜라이저를 통해 인스턴스를 초기화할 수 없는 여러 예외 상황에 대비

- 이니셜라이저의 전달인자로 잘못된 값이나 적절치 못한 값이 전달됐을 때, 이니셜라이저는 초기화에 실패할 수 있음

- 이니셜라이저를 정의할 때 이런 실패 가능성을 염두에 두기도 하는데, 이렇게 실패 가능성을 내포한 이니셜라이저를 실패 가능한 이니셜라이저라고 부른다

- 클래스, 구조체, 열거형 등에 모두 정의 가능

- init? 키워드

- 실패하지 않는 이니셜라이저와 실패 가능한 이니셜라이저를 같은 이름과 같은 매개변수 타입을 갖도록 정의할 수 없음

  ```swift
  class Person {
      let name: String
      var age: Int?
      
      init?(name: String) {
          if name.isEmpty {
              return nil
          }
          self.name = name
      }
      
      init?(name: String, age: Int) {
          if name.isEmpty || age < 0 {
              return nil
          }
          self.name = name
          self.age = age
      }
  }
  
  let yagom: Person? = Person(name: "yagom", age: 99)
  
  if let person: Person = yagom {
      print(person.name)
  } else {
      print("Person wasn't initialized")
  }
  //yagom
  
  let chope: Person? = Person(name: "chope", age: -10)
  
  if let person: Person = chope {
      print(person.name)
  } else {
      print("Person wasn't initialized")
  }
  //Person wasn't initialized
  ```

- 특히 열거형에서 유용하게 사용 가능. 특정 case에 맞지 않는 값이 들어오면 생성에 실패할 수 있음. 혹은 rawValue로 초기화할 때, 잘못된 rawValue가 전달되어 들어온다면 열거형 인스턴스를 생성하지 못할 수 있기 때문에, rawValue를 통한 이니셜라이저는 기본적으로 실패 가능한 이니셜라이저로 제공된다

  ```swift
  enum Student {
      case elementary, middle, high
      case none
      
      init() {
          self = .none
      }
      
      init(koreanAge: Int) {
          switch koreanAge {
              case 8...13:
              	self = .elementary
              case 14...16:
              	self = .middle
              case 17...19:
              	self = .high
              default:
              	self = .none
          }
      }
      
      init(bornAt: Int, currentYear: Int) {
          self.init(koreanAge: currentYear - bornAt + 1)
      }
  }
  
  var younger: Student = Student(koreanAge: 20)
  print(younger) //nil
  
  younger = Student(bornAt: 2020, currentYear: 2016)
  print(younger) //nil
  
  younger = Student(rawValue: "대학생")
  print(younger) //nil
  ```

## 함수를 사용한 프로퍼티 기본값 설정

- 연산을 통해 저장 프로퍼티 기본값을 설정하고자 한다면 클로저나 함수를 사용하여 프로퍼티 기본값을 제공할 수 있음

- 함수나 클로저가 호출되면서 연산 결과값을 프로퍼티 기본값으로 제공하기 때문에 클로저나 함수의 반환 타입은 프로퍼티의 타입과 일치해야한다

- 클로저 뒤에 소관호가 붙은 이유는 클로저를 실행하기 위해서이다. 소괄호가 없게 되면 프로퍼티의 기본값은 클로저 그 자체가 되고 값 할당이 안 되기 때문

  ```swift
  struct Student {
      var name: String?
      var number: Int?
  }
  
  class SchoolClass {
      var students: [Student] = {
          //새로운 인스턴스를 생성해서 사용자 정의 연산을 통한 후 반환해준다
          //반환 타입은  [Student] 타입이어야한다
          var arr: [Student] = [Student]()
          
          for num in 1...15 {
              var student: Student = Student(name: nil, number: num)
              arr.append(student)
          }
          
          return arr
      }()
  }
  
  let myClass: SchoolClass = SchoolClass()
  print(myClass.students.count)
  ```

## 인스턴스 소멸

- 디이니셜라이저. 클래스의 인스턴스가 메모리에서 소멸되기 바로 직전 호출된다

- 메모리에서 해제되기 직전 클래스 인스턴스와 관련하여 원하는 작업을 구현할 수 있음

- deinit 키워드를 사용하여 구현하고, 클래스의 인스턴스에만 구현할 수 있다

- 스위프트는 인스턴스가 더 이상 필요하지 않으면 자동으로 메모리에서 소멸시킨다. 그래서 인스턴스 대부분은 소멸시킬 때 디이니셜라이저를 사용해 별도의 메모리 관리 작업을 할 필요가 없다

- 하지만 예를 들어 인스턴스 내부에서 파일을 불러와 열어보는 등의 외부 자원을 사용했다면 인스턴스를 소멸하기 직전에 파일을 다시 저장하고 닫아주는 등의 부가 작업을 해야한다. 또는 인스턴스를 메모리에서 소멸하기 직전에 인스턴스에 저장되어 있던 데이터를 디스크에 파일로 저장해줘야하는 경우도 있을 수 있기 때문에, 디이니셜라이저는 굉장히 유용하게 사용된다

  ```swift
  class FileManager {
      var fileName: String
      
      init(fileName: String) {
          self.fileName = fileName
      }
      
      func openFile() {
          print("Open File : \(self.fileName)")
      }
      
      func modifyFile() {
          print("Modify File : \(self.fileName)")
      }
      
      func writeFile() {
          print("Write File : \(self.fileName)")
      }
      
      func closeFile() {
          print("Close File : \(self.fileName)")
      }
      
      deinit {
          print("Deinit instance")
          self.writeFile()
          self.closeFile()
      }
  }
  
  var fileManager: FileManager? = FileManager(fileName: "abc.txt")
  
  if let manager: FileManager = fileManager {
      manager.openFile()		//Open File : abc.txt
      manager.modifyFile()	//Modify File : abc.txt
  }
  
  fileManager = nil
  //Deinit instance
  //Write File : abc.txt
  //Close File : abc.txt
  ```

