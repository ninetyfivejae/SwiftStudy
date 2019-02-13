# Subscript

## 서브스크립트

- 클래스, 구조체, 열거형에는 컬렉션, 리스트, 시퀀스 등 타입의 요소에 접근하는 단축 문법인 서브스크립트를 정의할 수 있음
- 별도의 getter/setter를 구현하지 않고, someArray[index] or someDictionary[index]의 표현처럼 인덱스를 통해 값을 가져오거나 설정할 수 있음

## 서브스크립트 문법

- 인스턴스 메소드와 비슷하게 매개변수의 개수, 타입, 반환 타입 등을 지정하며, 읽고 쓰기가 가능하거나 읽기 전용으로 구현할 수 있음

  ```swift
  subscript(index: Int) -> Int {
      get {
          ...
      }
      set(newValue) {
          ...
      }
  }
  ```

  ```swift
  //읽기 전용 subscript인 경우, 아래와 같이 구현할 수 있음
  subscript(index: Int) -> Int {
  	return ...
  }
  ```

  - newValue의 타입은 서브스크립트의 반환 타입과 동일함
  - 매개변수를 따로 명시해주지 않으면 setter의 암시적 전달인자 newValue를 사용할 수 있음
  - 읽기 전용 프로퍼티를 구현할 때는 get이나 set 키워드를 사용하지 않고 적절한 값만 반환해주는 형태로 구현 가능

## 구현

- 한 타입에 여러 개의 서브스크립트를 정의할 수 있고, 다른 타입을 인덱스로 갖는 여러 개의 서브스크립트를 중복 정의할 수 있음

- 필요에 따라 여러 개의 매개변수를 인덱스로 사용할 수 있음

- 읽기 전용 서브스크립트. 학생의 번호를 전달인자로 받아 자신의 students 프로퍼티의 인덱스에 맞는 Student 인스턴스를 반환한다

  ```swift
  struct Student {
      var name: String
      var number: Int
  }
  
  class School {
      var number: Int = 0
      var students: [Student] = [Student]()
      
      func addStudent(name: String) {
          let student: Student = Student(name: name, number: self.number)
          self.students.append(student)
          self.number += 1
      }
      
      func addStudent(names: String...) {
          for name in names {
              self.addStudent(name: name)
          }
      }
      
      subscript(index: Int) -> Student? {
          get {
              if index < self.number {
                  return self.students[index]
              }
              return nil
          }
          
          set {
              guard var newStudent: Student = newValue else {
                  return
              }
              
              var number: Int = index
              
              if index > self.number {
                  number = self.number
                  self.number += 1
              }
              
              newStudent.number = number
              self.students[number] = newStudent
          }
      }
      
      subscript(name: String) -> Int? {
          get {
              return self.students.filter{ $0.name == name }.first?.number
          }
          
          set {
              guard var number: Int = newValue else {
                  return
              }
              
              if number > self.number {
                  number = self.number
                  self.number += 1
              }
              
              let newStudent: Student = Student(name: name, number: number)
              self.students[number] = newStudent
          }
      }
      
      subscript(name: String, number: Int) -> Student? {
          return self.students.filter{ $0.name == name && $0.number == number }.first
      }
  }
  ```

  ```swift
  let highSchool: School = School()
  highSchool.addStudent(names: "JuHyun", "SeulGi", "SeungWan", "SuYoung", "Yerim")
  
  let aStudent: Student? = highSchool[1]
  print("\(aStudent?.number) \(aStudent?.name)")
  
  print(highSchool["JuHyun"])
  print(highSchool["Wendy"])
  
  highSchool[0] = Student(name: "SuYoung", number: 0)
  highSchool["Yerim"] = 1
  
  print(highSchool["JuHyun"])
  print(highSchool["Yerim"])
  print(highSchool["SeungWan", 3])
  print(highSchool["SuYoung", 3])
  ```

- 