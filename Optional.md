# Optional / Optional Binding

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

### 옵셔널 체이닝

- 옵셔널에 속해 있는 nil일지도 모르는 프로퍼티, 메소드, 서브스크립션 등을 가져오거나 호출할 때 사용할 수 있는 일련의 과정

- 옵셔널에 값이 있다면 프로퍼티, 메소드, 서브스크립트 등을 호출할 수 있고 / 옵셔널이 nil이라면 프로퍼티, 메소드, 서브스크립트 등은 nil을 반환함

- 예제

  ```swift
  class Room {
      var number: Int
      init(number: Int) {
          self.number = number
      }
  }
  
  class Building {
      var name: String
      var room: Room?
      init(name: String) {
          self.name = name
      }
  }
  
  struct Address {
      var province: String
      var city: String
      var street: String
      var building: Building?
      var detailAddress: String?
      
      init(province: String, city: String, street: String) {
          self.province = province
          self.city = city
          self.street = street
      }
      
      func fullAddress() -> String? {
          var restAddress: String? = nil
          
          if let buildingInfo: Building = self.building {
              restAddress = buildingInfo.name
          } else if let detail = self.detailAddress {
              restAddress = detail
          }
          
          if let rest: String = restAddress {
              var fullAddress: String = self.province
              
              fullAddress += " " + self.city
              fullAddress += " " + self.street
              fullAddress += " " + rest
              
              return fullAddress
          } else {
              return nil
          }
      }
      
      func printAddress() {
          if let address: String = self.fullAddress() {
              print(address)
          }
      }
  }
  
  class Person {
      var name: String
      var address: Address?
      
      init(name: String) {
          self.name = name
      }
  }
  ```

  ```swift
  let yagom: Person = Person(name: "yagom")
  //질문
  yagom.address?.fullAddress()?.isEmpty
  
  let yagomRoomViaOptionalChaining: Int? = yagom.address?.building?.room?.number //nil
  //let yagomRoomViaOptionalUnwraping: Int = yagom.address!.building!.room!.number //오류
  
  if let roomNumber: Int = yagom.address?.building?.room?.number {
      print(roomNumber)
  } else {
      print("Can't find room number")
  }
  ```

  - 값을 받아오는 것만 하는게 아니라, 값 할당도 가능

  ```swift
  //yagom이라는 인스턴스에 해당되는 프로퍼티가 존재하지 않기 때문에 값 할당 실패.
  yagom.address?.building?.room?.number = 505
  
  //yagom이라는 인스턴스에 해당되는 모든 프로퍼티가 존재한다면 optional(505) 출력
  yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
  yagom.address?.building = Building(name: "곰굴")
  yagom.address?.building?.room = Room(number: 0)
  yagom.address?.building?.room?.number = 505
  ```

  - 서브스크립트

  ```swift
  var optionalArray: [Int]?
  optionalArray?[1]
  optionalArray = [1,2,3]
  optionalArray?[1]
  
  var optionalDictionary: [String: [Int]]? = [String: [Int]]()
  optionalDictionary?["numberArray"] = optionalArray
  optionalDictionary?["numberArray"]?[2]
  ```

### 빠른종료. guard

- EarlyExit의 핵심 키워드 guard: if 구문과 유사하게 Bool타입의 값으로 동작하는 기능

- guard는 **실행되는 위치(enclosing scope)에서 벗어나는 것** 을 항상 필요로 하기 때문. Return, break, continue, throw 등의 제어문 전환 명령어를 쓸 수 없는 상황이라면 사용이 불가함.

- 함수나 메소드, 반복문 등 특정 블록 내부에 위치하지 않는다면 사용이 제한된다. 함수 밖에서 사용을 하면 메인 프로그램을 종료를 할 수 있기 때문

- 기존에 사용했던 if let 바인딩보다는 조금 더 깔끔하게 사용할 수 있음

- 값이 nil이 아니어서 변수가 할당 된다면 이는 guard가 끝난 후에도 남아 있어서 값이 unwrap된 상태로 사용할 수 있음

  ```swift
  func myPrint(name: String?) {
      guard let name = name else {
          print("exiting...")
          return
      }
      print("이름: \(name)")
  }
  
  myPrint(name: "Tom")
  myPrint(name: nil
  ```

- ```swift
  //쉼표(,)로 추가 조건들을 나열하면  AND 논리연산과 같은 결과를 준다. &&로 바꿔서 사용해도 된다
  func enterClub(name: String?, age: Int?) {
      guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
          print("입장 거부")
          return
      }
      
      print("입장 허가")
  }
  ```

- [guard 참고](https://hcn1519.github.io/articles/2017-05/swift_controlFlow)

