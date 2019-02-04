# Collection (Array, Dictionary, Set)

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

## Array

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

## Dictionary

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

## Set

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

## Fast Enumeration

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

