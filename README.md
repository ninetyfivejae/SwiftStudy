# SwiftStudy

## 예습

- [SwiftBasicExamples](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/SwiftBasicExamples.md#swiftbasicexamples)
- [Flashlight App](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/FlashlightApp.md#flashlight-app)

## En#SwiftStudy

### 1. Swift에서 타입이란

- 상수와 변수, 함수
- Property(Stored, Computed, Class)
- 콜렉션(Array, Dictionary, Set)
- Class / Struct / Enum
- Optional / Optional Binding

### 2. UIKit 사용해보기

- 스토리보드 / Frame, Bounds / Autolayout
- UILabel / UIButton / UITextview / UITextField

### 3. POP(Protocol Oriented Programming) 개요

- TypeCasting
- 제네릭
- Protocol
- Extension
- UITableView / UICollectionView / UITabBarController
- Segue

###4. Swift 기본 패턴

- Delegate
- KVO: Key-Value Observing

### 5. 클로저와 ARC

- Closure
- 고차함수(Map, Filter, Reduce)
- ARC

```
4주차 - 클로저와 ARC
- Closure
- 고차함수(Map, Filter, Reduce)
- Generic

+ ARC

실습
- Array 확장해보기(제네릭 사용)
- ARC
- 순환참조 해결하기
```

```
5주차 ~ 8주차 - 미니 프로젝트 선정 및 진행해보기
- 사진 앨범 or 미니 Todo 앱
```

## SettingsApplication

- SettingsApplication 과제 하면서 깨달은 것들 정리

## 추가 정리

- Typealias는 static 으로 설정이 된다
- 도큐먼트 맨 마지막 conform to(준수하다) 많이 참고하게 될 것
- protocol document에 required 표시 돼있으면 필수 구현해야하는 것들이 있음

## 프로젝트 패키지화, 폴더 사용

- **New Group**: 실제로 폴더를 생성함. xcode 왼쪽에 project navigator 보면 그냥 노란색 폴더로 생성된다
- **New Group without folder**: 실제로는 폴더가 생성이 안 되고, 그룹 project navigator에서만 폴더 내부로 들어가게 되는데, 좌측 하단에 화살표가 표시된 노란 폴더로 생성된다
- **폴더 reference**: 외부에서 project navigator로 파일이나 폴더를 끌어다놓으면, 아래와 같은 선택을 할 수 있는데, Create folder references를 선택하면 실제 폴더를 참조하게 되어 폴더를 지우게 되면 원본의 폴더도 같이 지워지게 된다
  - Create groups: 실제 폴더가 프로젝트 디렉토리에 복사가 된다
  - **Create folder references**

## kvo

- Key value observing, 옵저버를 추가해 key에 해당하는 value 변경을 확인
- viewDidLoad에 addObserver 하면 oberveValue의 동작이 수행된다
- 프로퍼티나 텍스트필드 등등에 적용가능.
- 다른 클래스의 속성을 지켜보고 싶으면, 클래스의 인스턴스를 가지고 있어야한다
- 여러 앱을 왔다갔다 하면서 사용하면 observing 추가한게 다른 앱에도 적용될 수 있어서, remove옵저버를 해줘야 좋다
- notification 종류. nsnotification center 각 상황에 맞춰서 keyPath로 접근해서 값을 빼오는 것은 위험할 수 있음. 버전 올라가면서 바뀔 수 있으니까

## 고차함수

- map
- filter
- reduce
- 