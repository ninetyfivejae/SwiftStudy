# SwiftStudy

## 예습

- [SwiftBasicExamples](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/SwiftBasicExamples.md#swiftbasicexamples)
- [Flashlight App](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/FlashlightApp.md#flashlight-app)

## En#SwiftStudy

### 1. Swift에서 타입이란

- [상수와 변수, 함수](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/%EC%83%81%EC%88%98%EC%99%80%20%EB%B3%80%EC%88%98%2C%20%ED%95%A8%EC%88%98.md#%EC%83%81%EC%88%98%EC%99%80-%EB%B3%80%EC%88%98-%ED%95%A8%EC%88%98)
- [Property(Stored, Computed, Class)](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Property.md#propertystored-computed-class)
- [Collection(Array, Dictionary, Set)](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Collection.md#collection-array-dictionary-set)
- [Class / Struct / Enum](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Class%20:%20Struct%20:%20Enum.md#class--struct--enum)
- [인스턴스 생성 및 소멸](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Initializer.md#%EC%9D%B8%EC%8A%A4%ED%84%B4%EC%8A%A4-%EC%83%9D%EC%84%B1-%EB%B0%8F-%EC%86%8C%EB%A9%B8)
- [Optional / Optional Binding](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Optional.md#optional--optional-binding)
- [Subscript](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Subscript.md#subscript)

### 2. UIKit 사용해보기

- [스토리보드 / Frame, Bounds / Autolayout](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Views%26Controls.md#frame-and-bounds)
- [UILabel / UIButton / UITextview / UITextField](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Views%26Controls.md#uitextview)
- [App Life Cycle & ViewController Life Cycle](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/AppLifeCycle%26ViewControllerLifeCycle.md#app-lifecycle-viewcontroller-lifecycle)
- [UITableView / UICollectionView / UITabBarController](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/UIViewControllers.md#uiviewcontrollers)
- [Segue](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Segue.md#segue)

### 3. POP(Protocol Oriented Programming) 개요

- [상속](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Inheritance.md#inheritance)
- [TypeCasting](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/TypeCasting.md#type-casting)
- [Generic](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Generic.md#%EC%A0%9C%EB%84%A4%EB%A6%AD)
- [Protocol](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Protocol.md#protocol)
- [Extension](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Extension.md#extension)

### 4. Swift 기본 패턴

- [Delegate](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Delegate.md#delegate)
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

- [SettingsApplication 과제 하면서 깨달은 것들 정리](https://github.com/ninetyfivejae/SwiftStudy/blob/master/SettingsApplication.md#settingsapplication)

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

## cocoapods

- 많이 사용하는 라이브러리 찾아보기

  - Alamofire
  - AFNetworking
  - SdWebImage

- [CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 57 thousand libraries and is used in over 3 million apps. CocoaPods can help you scale your projects elegantly.](https://cocoapods.org/)

- 설치하기

  ```
  $ sudo gem install cocoapods
  ```

- 필요한 파일 다운로드 및 준비

  ```
  $ pod setup
  ```

- 의존성 관리를 할 Xcode 프로젝트 폴더에서 아래 명령 실행. 실행하면 Podfile이 생성된다

  ```
  $ pod init
  ```

- Pod 파일 편집

  ```
  # Uncomment the next line to define a global platform for your project
  # platform :ios, '9.0'
  
  target 'cocoapods_test2' do
    # 스위프트를 사용하지 않고 동적 라이브러리를 이용하지 않는다면 아래 구문을 주석처리 합니다
    use_frameworks!
  
    # 여기에 설치할 라이브러리를 나열합니다.
    pod 'Alamofire'
  
  end
  ```

- Podfile에서 나열한 라이브러리 설치하기

  ```
  $ pod install
  ```

- ‘프로젝트명.xcworkspace’ 파일을 더블 클릭하여 실행하면 라이브러리를 사용할 준비가 완료된다

  ```swift
  import UIKit
  import SDWebImage
  
  class ConfigureFriendViewController: UIViewController {
  
      @IBOutlet weak var testFriendImageView: UIImageView!
      override func viewDidLoad() {
          super.viewDidLoad()
  
          testFriendImageView.sd_setImage(with: URL(string: "https://static-breeze.nike.co.kr/kr/ko_kr/cmsstatic/product/-82622102/touch-of-lime.jpg?zoom"), placeholderImage: UIImage(named: "https://www.google.co.kr/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"))
      }
      
  }
  ```

- [xcode 파일 cocoapods - 프로젝트에서 CocoaPod를 제거하는 방법](https://medium.com/@xwildeyes/remove-uninstall-deintegrate-cocoapods-from-your-xcode-ios-project-c4621cee5e42)

  ```
  $ sudo gem install cocoapods-deintegrate cocoapods-clean
  $ pod deintegrate
  $ pod clean
  $ rm Podfile
  ```

## [Carthage](https://github.com/Carthage/Carthage)

- [iOS Carthage 사용법](https://letsean.app/2016/02/22/Carthage.html#fnref:1)

- [Carthage Tutorial: Getting Started](https://www.raywenderlich.com/416-carthage-tutorial-getting-started)

- [Carthage로 RxSwift 사용](https://medium.com/@jang.wangsu/ios-swift-%EC%B9%B4%EB%A5%B4%ED%83%80%EA%B3%A0-carthage-%EB%9E%80-%EC%82%AC%EC%9A%A9%EB%B2%95%EC%9D%80-%EC%98%88%EC%A0%9C-%EB%94%B0%EB%9D%BC%ED%95%98%EA%B8%B0%EA%B9%8C%EC%A7%80-127e71fdd253)

  ```
  $ brew update
  $ brew install carthage
  $ touch Cartfile
  $ open -a Xcode Cartfile // or vi Cartfile
  
  ... 내용 추가 ...
  github "Alamofire/Alamofire" == 2.0
  github "SwiftyJSON/SwiftyJSON" ~> 2.3.0
  
  ... 참고 내용...
  == 2.0 - 2.0 버전을 내려받아라
  >= 2.0 - 2.0 버전보다 큰 버전을 내려 받아라
  ~> 2.0 - 2.0 버전과 호환되는 어떤 버전을 내려받아라
  
  $ cartfile update //전체 빌드
  $ carthage update --platform iOS //iOS만 빌드
  ```

- 라이브러리 프레임워크 추가

  - Carthage 는 CocoaPods와 달리 직접 프레임워크를 프로젝트에 직접 추가를 해야한다

  - Carthage 폴더에 있는 프레임워크(.framework) 파일들을 Project Setting에서 Linked Frameworks and Libraries에 추가

  - 프로젝트 타겟의 Build Phases 탭에서 + 버튼을 눌러서 Run Script를 추가 하고 사용할 프레임워크들의 주소를 입력

    ```
    $(SRCROOT)/Carthage/Build/iOS/Alamofire.framework
    $(SRCROOT)/Carthage/Build/iOS/SwiftyJSON.framework
    ```

## Closure

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

## [Realm](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Realm.md#realm)

## [Observer Pattern in Swift](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/ObserverPattern.md#observer-pattern-in-swift)

## [RxSwift](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/RxSwift.md#rxswift)

