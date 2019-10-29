# Type Casting

> - 기존 언어의 타입 변환 vs 스위프트의 타입 변환
> - 데이터 타입 확인 연산자 is
> - Metatype Type. 메타타입 타입
> - 다운캐스팅
> - Any, AnyObject의 타임캐스팅

## 기존 언어의 타입 변환 vs 스위프트의 타입 변환

- C언어

  - 타입 변환: 부동소수 타입인 double에서 정수 타입인 int로 데이터 타입을 변경

  ```swift
  #include<stdio.h>
  
  int main(int argc, char **argv){
          double value = 3.3;
          int convertedValue = (int)value;
          printf("%d ", convertedValue);
          convertedValue = 5.5; //암시적인 데이터 타입 변환
          printf("%d ", convertedValue);
          return 0;
  }
  //3 5
  ```

- Swift

  - 스위프트에서는 이를 타입 변환 혹은 타입캐스팅이라고 칭하지 않고,
  - **이니셜라이저를 통해 새로운 인스턴스를 생성하는 과정**이라고 한다

  ```swift
  var value: Double = 3.3
  var convertedValue: Int = Int(value)
  convertedValue = 5.5
  ```

## 스위프트 타입캐스팅

- 스위프트 타입캐스팅: **인스턴스의 타입을 확인**하거나 **다른 타입의 인스턴스인양 행세를 할 수 있는 방법**을 사용할 수 있다

- **is와 as 연산자**: 이 두 연산자로 값의 타입을 확인하거나 다른 타입으로 전환할 수 있음. 또한 타입캐스팅을 통해 프로토콜을 준수하는지도 확인해볼 수 있음

- Coffee 클래스와 Coffee클래스를 상속받은 Latte, Americano 클래스

  - Latte나 Americano는 Coffee인 척할 수 있음. Latte나 Americano는 Coffee가 갖는 특성을 모두 갖기 때문

  ```swift
  class Coffee {
      let name: String
      let shot: Int
      
      var description: String {
          return "\(shot) shots \(name)"
      }
      
      init(shot: Int) {
          self.shot = shot
          self.name = "coffee"
      }
  }
  
  class Latte: Coffee {
      var flavor: String
      
      override var description: String {
          return "\(shot) shots \(flavor) latte"
      }
      
      init(flavor: String, shot: Int) {
          self.flavor = flavor
          super.init(shot: shot)
      }
  }
  
  class Americano: Coffee {
      let iced: Bool
      
      override var description: String {
          return "\(shot) shots \(iced ? "iced" : "hot") americano"
      }
      
      init(shot: Int, iced: Bool) {
          self.iced = iced
          super.init(shot: shot)
      }
  }
  ```

## 데이터 타입 확인 연산자 is

- 인스턴스가 해당 클래스의 인스턴스거나 그 자식클래스의 인스턴스라면 true를 반환하고, 그렇지 않다면 false를 반환함

- is 연산자는 클래스의 인스턴스뿐만 아니라 모든 데이터 타입에 사용할 수 있음

- 데이터 타입 확인

  ```swift
  let coffee: Coffee = Coffee(shot: 1)
  print(coffee.description)	//1 shots coffee
  
  let myCoffee: Americano = Americano(shot: 2, iced: false)
  print(myCoffee.description)	//2 shots hot americano
  
  let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
  print(yourCoffee.description)	//3 shots green tea latte
  
  print(coffee is Coffee)		//true
  print(coffee is Americano)	//false
  print(coffee is Latte)		//false
  
  print(myCoffee is Coffee)	//true
  print(yourCoffee is Coffee)	//true
  
  print(myCoffee is Latte)	//false
  print(yourCoffee is Latte)	//true
  ```

## Metatype Type. 메타타입 타입

- 타입의 타입

- 클래스 타입, 구조체 타입, 열거형 타입, 프로토콜 타입 등의 타입의 타입

- 타입의 이름 뒤에 .Type을 붙이면 메타 타입을 나타냄

- 프로토콜 타입 뒤에 .Protocol을 붙이면 프로토콜 타입의 메타 타입을 나타냄

- self를 사용하여 타입을 값처럼 표현할 수 있음

- 정의된 SomeClass, SomeProtocol 등의 메타 타입이 하나의 값으로 취급되어 someType 변수에 할당될 수 있음

- 인스턴스 self와 타입 self의 의미

  - .self 표현을 값 뒤에 써주면 그 값 자신을 표현함. "stringValue".self는 "stringValue" 그 자체를 나타냄
  - .self 표현을 타입 이름 뒤에 써주면 타입을 표현하는 값을 반환함. String.self는 String 타입을 나타내는 값

  ```swift
  protocol SomeProtocol {}
  class SomeClass: SomeProtocol {}
  
  let intType: Int.Type = Int.self
  let stringType: String.Type = String.self
  let classType: SomeClass.Type = SomeClass.self
  let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self
  
  var someType: Any.Type = intType
  someType = intType
  print(someType)			//Int
  
  someType = stringType
  print(someType)			//String
  
  someType = classType
  print(someType)			//SomeClass
  
  someType = protocolProtocol
  print(someType)			//SomeProtocol
  ```

  ```swift
  print(type(of: coffee) == Coffee.self)		//true
  print(type(of: coffee) == Americano.self)
  print(type(of: coffee) == Latte.self)
  
  print(type(of: coffee) == Americano.self)
  print(type(of: myCoffee) == Americano.self)	//true
  print(type(of: yourCoffee) == Americano.self)
  
  print(type(of: coffee) == Latte.self)
  print(type(of: myCoffee) == Latte.self)
  print(type(of: yourCoffee) == Latte.self)	//true
  ```

## 다운캐스팅

- 아래와 같은 상황에서 actingConstant가 참조하는 인스턴스를 진짜 타입인 Latte 타입으로 사용해야할 때가 있음

- 가령 Latte 타입에 정의되어 있는 메소드를 사용하거나 프로퍼티에 접근해야 할 때 Latte 타입으로 변수의 타입을 변환해주어야함

  ```swift
  let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
  print(actingConstant.description)
  ```

- 자식클래스보다 더 상위에 있는 부모클래스의 타입을 자식클래스의 타입으로 캐스팅한다고 해서 다운캐스팅이라고함

- 클래스의 인스턴스뿐만 아니라, Any 타입 등에서 다른 타입으로 캐스팅할 때도 다운캐스팅을 사용함.

- as?

  - 다운캐스팅 실패의 여지가 충분히 있기 때문에 사용하고 실패했을 경우 nil을 반환. 옵셔널 반환 타입

- as!

  - 다운캐스팅에 실패할 경우 런타임 오류 발생

  ```swift
  let coffee: Coffee = Coffee(shot: 1)
  let myCoffee: Americano = Americano(shot: 2, iced: false)
  let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
  
  if let actingOne: Americano = coffee as? Americano {
      print("This is Americano")
  } else {
      print(coffee.description)
  }
  //1 shots coffee
  
  if let actingOne: Latte = coffee as? Latte {
      print("This is Latte")
  } else {
      print(coffee.description)
  }
  //1 shots coffee
  
  if let actingOne: Americano = myCoffee as? Americano {
      print("This is Americano")
  } else {
      print(coffee.description)
  }
  //This is Americano
  
  if let actingOne: Latte = myCoffee as? Latte {
      print("This is Latte")
  } else {
      print(coffee.description)
  }
  //1 shots coffee
  
  if let actingOne: Coffee = myCoffee as? Coffee {
      print("This is Just Coffee")
  } else {
      print(coffee.description)
  }
  //This is Just Coffee
  ```

  ```swift
  let castedCoffee: Coffee = yourCoffee as! Coffee
  
  //let castedAmericano: Americano = coffee as! Americano //런타임 오류
  ```

- **이런 캐스팅 작업은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아님. 인스턴스는 메모리에 똑같이 남아있지만, 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할지 판단할 수 있도록 컴퓨터에 힌트를 주는 것뿐이다.**

## Any, AnyObject의 타입캐스팅

- 스위프트에 특정 타입을 지정하지 않고 여러 타입의 값을 할당할 수 있는 Any와 AnyObject 타입이 있음

- **Any: 함수 타입을 포함한 모든 타입**

- **AnyObject: 클래스 타입만을 뜻함**

  ```swift
  func checkType(of item: AnyObject) {
      if item is Latte {
          print("item is Latte")
      } else if item is Americano {
          print("item is Americano")
      } else {
          print("Unknown Type")
      }
  }
  
  checkType(of: myCoffee)
  checkType(of: yourCoffee)
  ```

  ```swift
  func castTypeToAppropriate(item: AnyObject) {
      if let castedItem: Latte = item as? Latte {
          print(castedItem.description)
      } else if let castedItem: Americano = item as? Americano {
          print(castedItem.description)
      } else {
          print("Unknown Type")
      }
  }
  
  castTypeToAppropriate(item: myCoffee)
  castTypeToAppropriate(item: yourCoffee)
  ```

- Any 타입은 모든 값 타입을 표현함. 더불어 옵셔널 타입도 표현할 수 있음

- 근데 Any타입의 값이 들어와야할 자리에 옵셔널 타입의 값이 위치한다면 스위프트 컴파일러는 경고를 함

- 의도적으로 옵셔널 값을 Any 타입의 값으로 사용하고자 한다면 as 연산자를 사용하여 명시적 타입 캐스팅을 해주면 경고 메세지를 받지 않음

  ```swift
  let optionalValue: Int? = 100
  print(optionalValue)		//컴파일러 경고 발생
  print(optionalValue as Any)	//경고 없음
  ```

