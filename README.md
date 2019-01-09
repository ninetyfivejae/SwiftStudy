# SwiftStudy

## 예습

- [SwiftBasicExamples](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/SwiftBasicExamples.md#swiftbasicexamples)
- [Flashlight App](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/FlashlightApp.md#flashlight-app)

## En#SwiftStudy

- 스터디 방식

  - 과제
    - 각자 분야 조사 및 공부, 정리해와서 설명해주기(내 분야가 아닌건 그날 스터디 종료 후 바로 설명들은거로 공부하기)
    - 각자 10분씩 총 30분 서로 설명해주고, 나머지 30분은 상욱이형이 추가적으로 부족한 부분 설명하고 실습 진행으로 2~3시간씩 스터디 진행
    - 다음 스터디 일정은 바로 전주에 만나서 정하는걸로하고, 내가 먼저 장소 프로젝트 가능한 곳으로 괜찮은데 알아봐야함
    - 3주차때는 형 여행가니까 평일에 금요일이나 월요일 중으로 만나서 하는걸로

- 일정

  ```
  1주차 - Swift에서 타입이란
  - 상수와 변수
  - 함수 정의 및 사용법
  - Property(Stored, Computed, Class)
  - 콜렉션(Array, Dictionary, Set)
  - Class / Struct / Enum
  - Optional / Optional Binding
  
  실습
  - Calculate 클래스 만들어보기
  
  2주차 - UIKit 사용해보기
  - 스토리보드
  - Frame, Bounds
  - Autolayout
  - UILabel
  - UIButton
  - UITextview
  - UITextField
  실습
  - Autolayout 실습
  - UIResponder, User Interaction
  - 버튼 동작해보기
  
  3주차 - POP 개요
  - 상속에 관한 이야기
  - Protocol 과 Extension
  - 타입 캐스팅
  - 제네릭 개요
  + Swift 기본 패턴
  - Delegate
  - KVO
  
  실습
  - UITableView, UICollectionView
  - UINavigation 및 화면 transition
  
  4주차 - 클로저와 ARC
  - Closure
  - 고차함수(Map, Filter, Reduce)
  - Generic
  
  + ARC
  
  실습
  - Array 확장해보기(제네릭 사용)
  - ARC
  - 순환참조 해결하기
  
  5주차 ~ 8주차 - 미니 프로젝트 선정 및 진행해보기
  - 사진 앨범 or 미니 Todo 앱
  ```

## 추가 정리

### Delegate

- https://zeddios.tistory.com/8?category=682195

- 프로토콜은 서로간의 지켜야할 규약

- Delegate는 대리자 라는 뜻. 너가 해야할 일을 내가 해서 줄게

- swift에서 기존의 버튼이나 텍스트필드, 라벨 등의 객체들은 고유의 특징을 가지는데

  - 버튼은 누르면 동작
  - 텍스트필드는 글자를 입력할 수 있도록 해줌
  - 라벨은 글자 내용을 출력
  - 등등

- 델리게이트 패턴은 쉽게 말해서, 객체 지향 프로그래밍에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리 해야 할 일 중 일부를 다른 객체에 넘기는 것을 뜻함

- viewDidLoad()함수에 textField.delegate = self 를 추가하면, delegate가 누구인지 명시하는 것임. textField의 뒷바라지는 내가 할게라는 의미. self라고 명시했기 때문에 현재클래스인 ViewController가 된다

- UITextFieldDelegate 프로토콜을 채택하여, textFieldShouldReturn(UITextFieldDelegate 안에 정의되어있는 함수)에 하고싶은 일을 구현만 하면 된다

- ```swift
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          enteredLabel.text = textField.text
          return true
  }
  ```

- @IBAction 클릭함수 대신에 처리할 함수를 구현한 것임

### Frame and Bounds

- CGPoint: 2차원 좌표계의 **점**을 포함하는 구조체

  ```swift
  public struct CGPoint {
      public var x: CGFloat
      public var y: CGFloat
      public init()
      public init(x: CGFloat, y: CGFloat)
  }
  ```

- CGSize: 너비와 높이 **값**을 포함하는 구조체. Width & height

  ```swift
  public struct CGSize {
      public var width: CGFloat
      public var height: CGFloat
      public init()
      public init(width: CGFloat, height: CGFloat)
  }
  ```

- CGRect: 각형의 **위치와 크기**를 포함하는 구조체

  ```swift
  public struct CGRect {
      public var origin: CGPoint
      public var size: CGSize
      public init()
      public init(origin: CGPoint, size: CGSize)
  }
  ```

- 예제

  ```swift
  var rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 30))
  ```

- Frame과 Bounds는 **UIView**의 instance property

- Frame: **SuperView(상위뷰)의 좌표시스템**안에서 View의 위치와 크기를 나타낸다.

  ```swift
  scrollView.frame.origin.x = 100
  scrollView.frame.origin.y = 100
  ```

- Bounds: View의 위치와 크기를 **자신만의 좌표시스템**안에서 나타냅니다.

  ```swift
  scrollView.bounds.origin.x = 300
  scrollView.bounds.origin.y = 500
  ```

### asdf

- 