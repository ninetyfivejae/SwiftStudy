# Closure

- 예제

  ```swift
  //public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]
  
  let names: [String] = ["wizplan", "eric", "yagom", "jenny"]
  
  
  
  func backwards(first: String, second: String) -> Bool {
      print("\(first) \(second) 비교 중")
      return first > second
  }
  let firstReversed: [String] = names.sorted(by: backwards)
  print(firstReversed)
  
  
  
  let secondReversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
      return first > second
  })
  print(secondReversed)
  
  
  
  let thirdReversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
      return first > second
  }
  print(thirdReversed)
  
  
  
  let fourthReversed: [String] = names.sorted { (first: String, second: String) -> Bool in
      return first > second
  }
  print(fourthReversed)
  
  
  
  let fifthReversed: [String] = names.sorted() {
      return $0 > $1
  }
  print(fifthReversed)
  
  
  
  let sixthReversed: [String] = names.sorted { $0 > $1 }
  print(sixthReversed)
  ```

  ```
  ["yagom", "wizplan", "jenny", "eric"]
  ["yagom", "wizplan", "jenny", "eric"]
  ["yagom", "wizplan", "jenny", "eric"]
  ["yagom", "wizplan", "jenny", "eric"]
  ["yagom", "wizplan", "jenny", "eric"]
  ["yagom", "wizplan", "jenny", "eric"]
  ```

- 