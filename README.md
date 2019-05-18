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
- [Autolayout 정독하기(엄청 많음)](<https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1>)
  - [Intrinsic 컨텐트 사이즈 / Compression Resistance / Hugging](<https://dev17.tistory.com/1>)
  - Intrinsic 컨텐트 사이즈는 현제 컨텐트에 따른 사이즈임을 명시하고 있다. 포함한 컨텐트에 따라 사이즈가 변할 수 있다는 것이다
  - 주어진 상황이 빈 공간을 채워야 하는 상황이면 Hugging 우선도를 조절해서 배치하고, 겹쳐져있다면 Compression Resistance 우선도를 저절해서 배치하면 된다
  - <https://medium.com/@vialyx/import-uikit-what-is-intrinsic-content-size-20ae302f21f3>

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

- [Closure](<https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Closure.md#closure>)
- 고차함수(Map, Filter, Reduce)
- ARC
- 순환참조 해결

## SettingsApplication

- [SettingsApplication 과제 하면서 깨달은 것들 정리](https://github.com/ninetyfivejae/SwiftStudy/blob/master/SettingsApplication.md#settingsapplication)

  > 사운드 참고 링크
  > ImageView 모양 원형으로 만들기
  > 이미지 설정할 때, #imageLiteral로 지정하는 것
  > TableView Cell 클릭시 하이라이트 계속 남아있는 버그 수정
  > 16진수 컬러코드 사용해서 UIColor 생성
  > **[UserDefaults](<https://github.com/ninetyfivejae/SwiftStudy/blob/master/SettingsApplication.md#6-userdefaults>)**
  > UIImage의 URL 가져오기, URL을 통해서 UIImage 다시 생성하기
  > 키보드 사라지는 타이밍 이슈
  > UITableView Section Header에 button 추가 / 새로운 Cell 추가 후 reloadData
  > **[Dealing with magic number / magic string](<https://github.com/ninetyfivejae/SwiftStudy/blob/master/SettingsApplication.md#10-dealing-with-magic-number--magic-string>)**

## 추가 정리

- Typealias는 static 으로 설정이 된다
- 도큐먼트 맨 마지막 conform to(준수하다) 많이 참고하게 될 것
- protocol document에 required 표시 돼있으면 필수 구현해야하는 것들이 있음
- [Managing the Keyboard](<https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html>)
- [흐름제어](<https://hcn1519.github.io/articles/2017-05/swift_controlFlow>)

## Todo

- 앞으로 읽어볼 것들
  - <https://www.raywenderlich.com/2752-25-ios-app-performance-tips-tricks#launchtime>
  - MVVM Architecture 계속 연구해보기

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

## 순환참조

- 

## 고차함수, 모나드

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

- 에러났을 경우, 아래처럼 해결해보기

  - Cartfile.resolved (파일)

  - /Carthage/ (폴더)

  - 지우고 다시 update하면 update할 수 있다

    ```
    sinjaehyeog-ui-MacBook-Pro:Switcher-m-iOS jaehyukshin$ carthage update
    *** Cloning Toast-Swift
    *** Fetching RxSwift
    *** Fetching realm-cocoa
    *** Fetching RxDataSources
    *** Fetching IOS-Pods-DFU-Library
    *** Checking out IOS-Pods-DFU-Library at "3.1.0"
    *** Checking out RxDataSources at "1.0.4"
    *** Checking out realm-cocoa at "v3.13.1"
    *** Checking out RxSwift at "3.6.1"
    *** Checking out Toast-Swift at "4.0.1"
    *** xcodebuild output can be found in /var/folders/s0/zqhtx9_d5nbgrh3d_2_g7vwm0000gn/T/carthage-xcodebuild.h4pdh2.log
    *** Downloading realm-cocoa.framework binary at "v3.13.1"
    *** Downloading RxSwift.framework binary at "Oxygen.1"
    ***  Skipped installing RxSwift.framework binary due to the error:
    	"Incompatible Swift version - framework was built with 3.1 (swiftlang-802.0.53 clang-802.0.42) and the local version is 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)."
    
        Falling back to building from the source
    *** Building scheme "iOSDFULibrary" in iOSDFULibrary.xcworkspace
    *** Building scheme "Zip" in iOSDFULibrary.xcworkspace
    *** Building scheme "RxBlocking-tvOS" in Rx.xcworkspace
    *** Building scheme "RxBlocking-macOS" in Rx.xcworkspace
    *** Building scheme "RxBlocking-watchOS" in Rx.xcworkspace
    *** Building scheme "RxBlocking-iOS" in Rx.xcworkspace
    *** Building scheme "RxCocoa-macOS" in Rx.xcworkspace
    *** Building scheme "RxCocoa-iOS" in Rx.xcworkspace
    *** Building scheme "RxCocoa-tvOS" in Rx.xcworkspace
    *** Building scheme "RxCocoa-watchOS" in Rx.xcworkspace
    Build Failed
    	Task failed with exit code 65:
    	/usr/bin/xcrun xcodebuild -workspace /Users/jaehyukshin/Documents/Switcher-m-iOS/Carthage/Checkouts/RxSwift/Rx.xcworkspace -scheme RxCocoa-watchOS -configuration Release -derivedDataPath /Users/jaehyukshin/Library/Caches/org.carthage.CarthageKit/DerivedData/10.1_10B61/RxSwift/3.6.1 -sdk watchos ONLY_ACTIVE_ARCH=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY= CARTHAGE=YES archive -archivePath /var/folders/s0/zqhtx9_d5nbgrh3d_2_g7vwm0000gn/T/RxSwift SKIP_INSTALL=YES GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=NO CLANG_ENABLE_CODE_COVERAGE=NO STRIP_INSTALLED_PRODUCT=NO (launched in /Users/jaehyukshin/Documents/Switcher-m-iOS/Carthage/Checkouts/RxSwift)
    
    This usually indicates that project itself failed to compile. Please check the xcodebuild log for more details: /var/folders/s0/zqhtx9_d5nbgrh3d_2_g7vwm0000gn/T/carthage-xcodebuild.h4pdh2.log
    ```

## [iPhoneOSDeviceSupport 문제 해결](<https://github.com/filsv/iPhoneOSDeviceSupport>)

- This iPhone 6 is running iOS 12.2 (16E227), which may not be supported by this version of Xcode.
- 저번에 xcode 최신 버전으로 업데이트하고, 다시 downgrade한 이후에 발생한 에러였는데, iOS 12.2 xcode device support file이 없어서 발생한 에러였음
- iOS12.2 버전인데 iOS12.1 버전까지만 support file이 있었음

## [Realm](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/Realm.md#realm)

## [Observer Pattern in Swift](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/ObserverPattern.md#observer-pattern-in-swift)

## [MVVM Architecture in Swift](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/MVVM.md#mvvm)

## [RxSwift](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%A0%95%EB%A6%AC/RxSwift.md#rxswift)

## Dispatch

> 시스템에 의해 관리되는 dispatch queues에 작업을 할당함으로써 멀티코어 환경에서 코드를 병렬로 실행한다.

> Execute code concurrently on multicore hardware by submitting work to dispatch queues managed by the system.

------

#### Grand Central Dispatch 란?

> 애플에서 개발한 멀티프로세서 환경을 지원하는 병렬처리 기술이다. Thread pool pattern을 사용한다. Thread pool 관리를 추상화해 운영체제에 가깝도록 한것.

> NSThread, NSOperation 보다 쉬운 구현이 장점이다.

------

#### Managing Dispatch Queues

> GCD 를 사용하면 병렬프로그래밍을 보다 쉽게 구현할 수 있습니다.

> GCD는 FIFO 큐를 제공합니다. block object 형식의 작업을 큐에 넣을 수 있습니다. 이 큐에 있는 작업들은 전부 시스템에서 관리하는 쓰레드 풀에서 실행됩니다. 작업이 실행되는 쓰레드에 대해서는 보장되는게 없습니다. 어떤 쓰레드에서 실행되는지 언제 끝나는지 이런걸 알 수 없다는 것 같습니다.

------

#### Synchronous and Asynchronous Execution (동기와 비동기)

큐에 들어간 작업들은 Synchronous 혹은 Asynchronous 실행될 수 있습니다.

- Synchronous 란 무엇인가?
- 어떤 작업이 Synchronous 실행 될때에는 프로그램은 메서드가 리턴해서 작업을 완료할 때까지 기다리는 겁니다.
- Asynchronous 란 무엇인가?
- 어떤 작업이 Asynchronous 실행 될때에는 메서드는 바로 리턴합니다. 하지만 작업은 어떤 다른 쓰레드에서 실행되고 있을겁니다. 작업이 완료되면 notification을 보낼 수 있습니다.

------

#### Serial and Concurrent Queues

dispatch queue 는 Serial 하게 혹은 Concurrent 하게 실행될 수 있습니다.

Serial 하다는건 한번에 하나의 작업을 실행한다는 것입니다.

Concurrent 하다는것 순서대로 deque되겠지만 모두 한번에 실행되고 완료되는 시간도 제각각이 될 수 있다는 것입니다.

serial 큐와 concurrent 큐 둘다 작업을 FIFO 방식으로 처리합니다.

------

#### System-Provided Queues (Main Queue)

> 앱이 실행되면 특정한 큐가 생성되는데 이 큐를 Main Queue 라고 합니다. 작업들은 메인큐에 들어가고 serial 하게 실행됩니다.

> **메인 큐에서 동기적으로 작업을 실행하면 데드락이 발생한다고 합니다.**

- 데드락이란?
- A는 B를 기다리고 B는 C를 기다리는데 C는 A를 기다리는 상황입니다.
- 상호 배제 (Mutual exclusion)
- 점유 상태로 대기 (Hold and wait)
- 선점 불가 (No preemption)
- 순환성 대기 (Circular wait)
- 이런 조건들이 만족하면 데드락이 발생한답니다.

> Main큐 외에도 시스템은 다수의 global 큐들을 생성합니다. 필요에 따라 global 큐들을 사용할 수 있습니다.

------

#### Managing Units of Work

> Work items 은 개별적인 작업들에 대해 속성을 구성할 수 있습니다. 완료를 기다리게 할 수도 있고 완료후 노티 받도록 할 수도 있고 취소하도록 할 수 있습니다.

------

- Prioritizing Work and Specifying Quality of Service
- Using Dispatch Groups
- Using Dispatch Semaphores
- Using Dispatch Data
- Using Dispatch Time
- Managing Dispatch Sources
- Managing Dispatch I/O
- Working with Dispatch Objects
- Enumerations
- Protocols

## [localization 참고](<https://medium.com/ios-forever/ios%EC%97%90%EC%84%9C-localization%ED%95%98%EB%8A%94-gorgeous-%ED%95%9C-%EB%B0%A9%EB%B2%95-f82ac29d2cfe>)