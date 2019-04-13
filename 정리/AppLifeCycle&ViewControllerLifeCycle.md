# App LifeCycle, ViewController LifeCycle

## 1. iOS App Lifecycle

![iOSAppLifeCylceImage](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/appLifeCylceImage.png?raw=true)

### 앱의 실행 상태는 5개 상태로 구분

- 앱 생명주기는 앱이 화면상에서 보이지 않는 background 상태, 화면에 올라와 있는 상태인 foreground 등과 같은 상태들을 정의한 것
  - **Not Running**: 앱이 실행되지 않은 상태
  - **Foreground[Inactive]**: 앱이 실행중인 상태 그러나 아무런 이벤트를 받지 않는 상태. 앱이 Foreground 상태로 돌아가지만, 이벤트는 받지 않는 상태, 앱의 상태 전환 과정에서 잠깐 머무는 단계.
  - **Foreground[Active]**: 앱이 실행중이며 이벤트가 발생한 상태. 일반적으로 앱이 돌아가는 상태
  - (Inactive와 Active 상태를 합쳐서 Foreground 라고 함)
  - **Background**: 앱이 백그라운드에 있는 상태 그러나 실행되는 코드가 있는 상태. 앱이 Suspended(유예 상태) 상태로 진입하기 전 거치는 상태
  - **Suspened**: 앱이 백그라운드에 있고 실행되는 코드가 없는 상태. 앱이 Background 상태에 있지만, 아무 코드도 실행하지 않는 상태, 시스템이 임의로 Background 상태의 앱을 Suspended 상태로 만든다
- Not Running은 앱이 실행되고 있지 않으며 어떤한 디바이스 리소스도 점유하고 있지 않는 상태. 사용자가 홈 화면에서 앱을 실행하면 Inactive 상태로 전환된다
- Inactive 상태는 앱이 Foreground에서 실행되고 있지만 이벤트를 받고 있지 않은 상태이다
- 앱이 Foreground에서 이벤트를 받으면 Active 상태로 전환된다. 일반적으로 앱이 실행되고 있는 상태이다.
- 사용자가 홈 버튼을 누르거나 다른 앱으로 전환하면 Background 상태로 전환된다. Background 상태에서 UI는 화면에 표시되지 않지만 코드를 실행할 수 있다. 또한, Background 상태에서 앱을 실행하면 InActive 상태를 거치지 않고 앱이 실행된다. **iOS에서 홈버튼을 두 번 눌러서 앱을 전환할 때, 앱이 재시작되지 않는다면 해당 앱은 Background 상태에 있던 앱이다.**
- Background에서 코드를 실행할 경우 실행 시간을 명시적으로 요청해야 한다. 만약 실행할 코드가 없다면 바로 Suspended 상태로 전환된다. Suspended 상태로 전환된 앱은 디바이스의 리소스를 점유하고 있지만 어떠한 코드도 실행하지 않는다. 디바이스의 메모리가 부족한 경우 OS에 의해 Not Running 상태로 전환될 수 있다
- [출처1](https://hcn1519.github.io/articles/2017-09/ios_app_lifeCycle), [출처2](https://m.blog.naver.com/PostView.nhn?blogId=horajjan&logNo=220893600250&proxyReferer=https%3A%2F%2Fwww.google.com%2F)

### 순서대로 정리, AppDelegate.swift

- AppDelegate.swift 파일이 있으므로 AppDelegate클래스가 만들어지고, 이 AppDelegate클래스에 인스턴스가 애플리케이션 내용이 그려질 window를 만든다

- **@UIApplicationMain**

  - 앱이 시작되면 main함수에서 UIApplicationMain()함수 실행

    ```swift
    //참고. objective-c main함수
    int main(int argc, char *argv[]){
        @autoreleasepool
        {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    ```

  - UIApplicationMain()은 **애플리케이션 생명주기를 담당하게 되는 AppDelegate를 메모리 상에 올려주는 역할**

    ```swift
    //참고. objective-c UIApplicationMain함수 선언부
    int UIApplicationMain(
    	int argc,
    	char *argv[],
    	NSString *principalClassName,
    	NSString *delegateClassName
    );
    ```

    - **principalClassName**: 해당 애플리케이션에 사용하고자 하는 확장되는 기능을 가지고 있는 UIApplication 클래스. 인자로 넘긴 클래스에서 싱글톤 UIApplication 인스턴스 생성함
    - **delegateClassName**: 애플리케이션의 생명주기를 담당할 AppDelegate클래스

- 즉 앱이 시작되는 순간, main에서 UIApplicationMain()이 UIApplication 및 AppDelegate 객체를 각각 생성함

  - **UIApplication 객체**는 싱글톤 객체(앱 전체에 하나만 존재)이며 Event Loop에서 발생하는 여러 이벤트들을 감지하고 Delegate에 전달하는 역할을 한다. 예를 들면 앱이 백그라운드로 갈때, 메모리 부족 경고를 할 때와 같은 상황들을 감지하여 Delegate에 전달함
  - **AppDelegate 객체**는 UIApplication 객체로 부터 메시지를 받았을 때, 해당 상황에서 실행 될 함수들을 정의함. 생명주기를 담당하는 AppDelegate클래스는 UIApplicationDelegate 프로토콜을 준수하기 때문에 delegate메소드들을 구현할 수 있음. 이 프로토콜(UIApplicationDelegate)은 앱을 세팅하고, 앱 상태 변화에 응답하며 다른 app-level이벤트를 처리하는 데 사용하는 여러가지 방법을 정의한다

- Main Event Loop를 실행(touch, text input등 유저의 액션을 받는 루프) 및 기타 설정

  - ![mainRunLoopImage](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/event_draw_cycle_a_2x.png)
  - 사용자 발생 이벤트 처리.
    **UIApplication object** sets up the main run loop at launch time and uses it to process events and handle updates to view-based interfaces. 앱의 메인쓰레드에서 실행. user-related events 순차적으로 처리.
  - UIKit으로 setup된 포트로 터치와 같은 사용자가 발생한 이벤트를 전달받음. EventQueue에 들어온 이벤트들을 순차적으로 처리함

- 앱 실행

- 종료

  - 앱은 언제든지 종료될 수 있도록 준비되어야하며, 사용자 데이터를 저장하거나 다른 중요한 작업을 수행 할 때까지 기다려서는 안 된다
  - **System-initiated termination** is a normal part of an app’s life cycle.
    동작이랑 반응 없는 앱을 종료하여 사용자에 의해 실행된 다른 앱들을 위해 메모리 공간을 확보한다
  - **Suspended apps** receive no notification when they are terminated; the system kills the process and reclaims the corresponding memory.
  - **User-initiated termination** 또한 suspended app 종료와 같은 방식으로 종료된다
    The app’s process is killed and no notification is sent to the app
  - **background에서 동작하고 있는(not suspended) 앱인 경우**, 종료 전에`applicationWillTerminate:` 가 호출된다
  - 디바이스가 reboot 다시시작할 때는 이 메소드 호출되지 않는다

- AppDelegate클래서의 delegate메소드들

  - 이 메소드들을 사용하여 UIApplication 객체와 AppDelegate 객체가 통신할 수 있음
  - 앱상태가 전환되는 동안(ex : 앱 실행, 백그라운드로 전환 및 앱 종료) UIApplication 객체는 다음 메소드들 중 해당하는 delegate 메소드를 호출하여 앱이 응답할 수 있는 기회를 제공한다
  - 이러한 메소드가 올바른 시간에 호출되도록 하려고 특별한 작업을 수행 할 필요는 없음. 응용프로그램 객체가 해당작업을 알아서 처리함

  ```swift
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  func applicationWillResignActive(_ application: UIApplication)
  func applicationDidEnterBackground(_ application: UIApplication)
  func applicationWillEnterForeground(_ application: UIApplication)
  func applicationDidBecomeActive(_ application: UIApplication)
  func applicationWillTerminate(_ application: UIApplication)
  ```

  - **application**: - 앱이 처음 시작될 때 실행

    ```swift
    applicationDidFinishLaunching(:)
    Tells the delegate when the app has finished launching.
    Don’t use. Instead, use application(_:didFinishLaunchingWithOptions:)
    ```

    - **willFinishLaunchingWithOptions**: This method is your app’s first chance to execute code at launch time
    - **didFinishLaunchingWithOptions**: This method allows you to perform any final initialization before your app is displayed to the user

  - **applicationWillResignActive**: - 앱이 active 에서 inactive로 이동될 때 실행

  - **applicationDidEnterBackground**: - 앱이 background 상태일 때 실행

  - **applicationWillEnterForeground**: - 앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서 실행중이진 않음)

  - **applicationDidBecomeActive**: - 앱이 active상태가 되어 실행 중일 때

  - **applicationWillTerminate**: - 앱이 종료될 때 실행

- 위의 함수를 모두 구현 할 필요는 없고 상황에 맞춰 필요한 함수만 구현하면 되고, 위 함수들에는 없지만 원하는 delegate를 추가해도 된다.

## 2. [Strategies for Handling App State Trasitions](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW1)

#### 2.1. The Launch Cycle

- At launch time, the system automatically loads your app’s main storyboard file and loads the initial view controller.
  - Use the `application:willFinishLaunchingWithOptions:` method **to show your app window and to determine if state restoration should happen at all.**
  - Use the `application:didFinishLaunchingWithOptions:` method **to make any final adjustments to your app’s user interface.**
- **Launching an app into the foreground**
  - To determine whether your app is launching into the foreground or background, check the `applicationState` property of the shared `UIApplication`object in your `application:willFinishLaunchingWithOptions:` or `application:didFinishLaunchingWithOptions:` delegate method.
  - When the app is launched into the foreground, this property contains the value `UIApplicationStateInactive`. When the app is launched into the background, the property contains the value `UIApplicationStateBackground` instead.
  - ![launchingAppForegroundImage](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_launch_fg_2x.png)
- **Launching an app into the background**. 어떤 경우가 있는지 확실히 모르겠음
  - 그냥 똑같이 실행시키는데, app window를 보여주지 않는 것임
  - ![launchingAppBackground](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_launch_bg_2x.png)

#### 2.2. Launching in Landscape Mode

- 가로로된 화면으로 실행시키는 경우 설정할 것
  - Add the `UIInterfaceOrientation` key to your app’s `Info.plist` file and set the value of this key to either `UIInterfaceOrientationLandscapeLeft`or `UIInterfaceOrientationLandscapeRight`.
  - Lay out your views in landscape mode and make sure that their layout or autosizing options are set correctly.

#### 2.3. Installing App-Specific Data Files at First Launch

#### 2.4. App is Interrupted Temporarily

- **Alert-based interruptions** result in a temporary loss of control by your app.
- 앱이 Foreground에서 동작하고 있다가 아무런 터치 이벤트를 받지 않게 되면 `applicationWillResignActive:`메소드가 호출되고, 여기에 아래와 같은 작업들을 수행해야한다
  - Save data and any relevant state information.
  - Stop timers and other periodic tasks.
  - Stop any running metadata queries.
  - Do not initiate any new tasks.
  - Pause movie playback (except when playing back over AirPlay).
  - Enter into a pause state if your app is a game.
  - Throttle back OpenGL ES frame rates.
  - Suspend any dispatch queues or operation queues executing non-critical code. (You can continue processing network requests and other time-sensitive background tasks while inactive.)
- 다시 active 상태로 돌아오게 되면 `applicationWillResignActive:` method에서 수행했던 작업들을 다시 되돌려야한다
- **alert-based interruption, 가령 전화가 오는 경우 아래와 같이 cycle이 수행된다**. 전화가 오면 실행 중인 앱이 inactive 상태로 되고, 사용자가 전화를 받을지 무시할지 이벤트를 기다린다.
- ![temporaryInterruptionCycleImage](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_interruptions_2x.png)

#### 2.5. App Enters the Foreground

- **Returning to the foreground** is your app’s chance to restart the tasks that it stopped when it moved to the background

- The `applicationWillEnterForeground:` method should undo anything that was done in your `applicationDidEnterBackground:` method

- The `applicationDidBecomeActive:` method should continue to perform the same activation tasks that it would at launch time.

- ![appEntersForegroundCycleImage](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_enter_foreground_2x.png)

- **Queued Notifications**

  - Suspended 상태에서 받은 notification들은 suspended 상태에서 처리를 할 수 없기 때문에 queue에 들어가서 대기하다가, foreground나 background로 상태가 돌아오게되면 터치 이벤트나 사용자 입력이 들어오기 전에 바로 전달된다.

- Handle iCloud, Locale, Settings changes

  - If the status of iCloud changes for any reason, the system delivers a `NSUbiquityIdentityDidChangeNotification` notification to your app

  - If a user changes the current locale while your app is suspended, you can use the `NSCurrentLocaleDidChangeNotification` notification to force updates to any views containing locale-sensitive information, such as dates, times, and numbers when your app returns to the foreground.

  - If your app has settings that are managed by the Settings app, it should observe the `NSUserDefaultsDidChangeNotification` notification. Because the user can modify settings while your app is suspended or in the background, you can use this notification to respond to any important changes in those settings.

    사용자 계정 정보 변경 시 보안과 관련된 문제가 생길 수 있으니 중요함

#### 2.6. App Enters the Background

- When moving from foreground to background execution, use the `applicationDidEnterBackground:` method of your app delegate to do the following:
  - **Prepare to have your app’s picture taken.** When your `applicationDidEnterBackground:` method returns, the system takes a picture of your app’s user interface and uses the resulting image for transition animations. If any views in your interface contain sensitive information, you should hide or modify those views before the `applicationDidEnterBackground:` method returns. 
  - **Save any relevant app state information.** Prior to entering the background, your app should already have saved all critical user data. Use the transition to the background to save any last minute changes to your app’s state.
  - **Free up memory as needed.** Release any cached data that you do not need and do any simple cleanup that might reduce your app’s memory footprint. Apps with large memory footprints are the first to be terminated by the system, so release image resources, data caches, and any other objects that you no longer need.
- ![backgroundTransitionCycleImage](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_bg_life_cycle_2x.png)
- [출처1](https://medium.com/ios-development-with-swift/%EC%95%B1-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0-app-lifecycle-vs-%EB%B7%B0-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0-view-lifecycle-in-ios-336ae00d1855) / [출처2 objective-c 생명주기](http://j2enty.tistory.com/entry/iOS-iOS-Application-Life-Cycle) / [출처3 UIApplication클래스](https://zeddios.tistory.com/539?category=682195) / [출처4 AppDelegate.swift](https://zeddios.tistory.com/218?category=682195)

## 3. iOS ViewController LifeCycle

- **모바일 앱은 화면의 크기가 작아서 PC와 달리 하나의 화면에 하나의 ViewController만을 가진다. 그리고 여러개의 ViewController가 모여 하나의 앱을 만든다**

- **iOS 에서는 한 화면에서 다른 화면으로 전환할 때 기존의 화면위에 새로운 화면이 쌓이는 식으로 화면을 전환한다**(스택구조)

- 이 때 각각의 뷰 컨트롤러는 자신만의 생명주기를 가지고 있고 이 생명주기를 잘 이해하고 있다면 뷰 컨트롤러의 상황에 따라 원하는 로직을 수행하도록 만들 수 있음

  ![viewControllerLifeCycleImage](https://docs-assets.developer.apple.com/published/f06f30fa63/UIViewController_Class_Reference_2x_ddcaa00c-87d8-4c85-961e-ccfb9fa4aac2.png)

- 여러개의 뷰 컨트롤러가 있는 앱이라고 한다면 각각의 뷰 컨트롤러는 자신만의 생명주기를 가진다

- 그래서 화면상에 등장 할 때, 사라질 때 등 상황에 맞춰서 함수들이 호출됨

- 뷰 컨트롤러 생명주기의 대표적인 함수

  - **ViewDidLoad**: 해당 뷰컨트롤러 클래스가 생성될 때(ViewWillAppear전에 실행) 실행된다. Low memory와 같은 특별한 경우가 아니라면 딱 한번만 실행되기 때문에 초기화 할 때 사용 할 수 있다
  - **ViewWillAppear**: 뷰 컨트롤러가 화면에 나타나기 직전에 실행된다. 뷰 컨트롤러가 나타나기 직전에 항상 실행되기 때문에 해당 뷰 컨트롤러가 나타나기 직전마다 일어나는 작업들을 여기에 배치 시킬 수 있다.
  - **ViewDidAppear**: 뷰 컨트롤러가 화면에 나타난 직후에 실행된다. 화면에 적용될 애니메이션을 그리거나 API로 부터 정보를 받아와 화면을 업데이트 할 때 이곳에 로직을 위치시키면 좋다. 왜냐하면 지나치게 빨리 애니메이션을 그리거나 API에서 정보를 받아와 뷰 컨트롤러를 업데이트 할 경우 화면에 반영되지 않기 때문
  - **ViewWill/DidDisappear**: 뷰 컨트롤러가 화면에 나타난 직전/직후에 실행.

- UIViewController 생명 주기

  ![viewControllerLifeCycleImage](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/viewControllerLifeCycle2Image.jpeg?raw=true)

  - **loadView**

    - Creates the view that the controller manages
    - You should never call this method directly. The view controller calls this method when its [`view`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621460-view)property is requested but is currently `nil`. This method loads or creates a view and assigns it to the [`view`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621460-view) property.
    - 필요하면 override 가능
      ...
    - [Document](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview)

  - **viewDidLoad**

    - Called after the controller's view is loaded into memory: 뷰의 컨트롤러가 메모리에 로드되고 난 후 호출된다
    - viewDidLoad 메소드는 뷰의 로딩이 완료 되었을 때, 시스템에 의해 자동으로 호출되기 때문에 일반적으로 리소스를 초기화하거나 초기 화면을 구성하는 용도로 주로 사용한다. 화면이 처음 만들어질 때 한 번만 실행되므로, 처음 한 번만 실행해야 하는 초기화 코드가 있을 경우 이 메소드 내부에 작성하면 된다
    - loadView를 호출하면 viewDidLoad는 자동으로 호출됨

  - **viewWillAppear**

    - 뷰가 나타나기 직전에 호출
    - 예를 들어, viewWillAppear, viewWillDisappear 메소드는 아이폰 카톡이나 크롬 등등에서 옆으로 슬라이드하면 이전 화면으로 가는 기능에서 호출이 된다

  - **viewDidAppear**

    - viewDidAppear는 뷰가 나타났다는 것을 컨트롤러에게 알리는 역할 및 화면에 적용될 애니메이션을 그려줌
    - 뷰가 화면에 나타난 직후에 실행

  - **viewWillDisappear**

    - 뷰가 사라지기 직전에 호출되는 함수
    - 뷰가 삭제 되려고하고있는 것을 뷰 콘트롤러에 통지함

  - **viewDidDisappear**

    - 뷰 컨트롤러가 뷰가 제거되었음을 알려줌

  - 예제

    ![stackArchitectureOfNavigationViewImage](https://docs-assets.developer.apple.com/published/83ef757907/NavigationViews_2x_e69e98a2-aaac-477e-9e33-92e633e29cc7.png)

  - **view의 스택 구조**

    - 네비게이션 컨트롤러는 반드시 root View controller를 갖는다. 예제에서는 첫번째 뷰가 root view이다.
    - 스택구조이기 때문에 LIFO(Last-in First-out)구조
    - 우측 상단 버튼(Item)을 누르면 SecondViewController가 push되어 root view(ViewController) 위로 올라오게 된다
    - 다시 뒤로가기 버튼(Title)을 누르면 가장 위에 있던(top) SecondViewController가 pop되어 사라지고, 밑에 있던 root view가 나오게 된다
    - 가장 base에 있는 view는 사라지지 않고 top에 있는 view만 들어왔다 나갔다를 반복한다. 그리고 view의 스택에서 pop된 데이터는 메모리에서 사라지게 된다
    - 그래서 2st viewDidLoad만 출력이 되고 1st는 처음 한 번만 출력이 되는 것이다.
    - viewDidLoad가 SecondViewController로 갈때만 호출이 되는 이유는 root view는 항상 메모리에 로드돼있는 상태에서 그 위에 추가되는 view들은 메모리에 로드되었다가 삭제되었다가를 반복하기 때문. viewDidLoad는 뷰의 컨트롤러가 메모리에 로드되고 난 후에 호출된다고 명시돼있음

  - 코드

    ```swift
    import UIKit
    
    class SecondViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            print("2st viewDidLoad")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            print("2st viewWillAppear")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            print("2st viewDidAppear")
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            print("2st viewWillDisappear")
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            print("2st viewDidDisappear")
        }
    }
    ```

    ```
    //앱 처음 실행 root view
    1st viewDidload
    1st viewWillAppear
    1st viewDidAppear
    
    //SecondViewController로 이동
    2st viewDidLoad
    1st viewWillDisappear
    2st viewWillAppear
    1st viewDidDisappear
    2st viewDidAppear
    
    //다시 root view로 이동
    2st viewWillDisappear
    1st viewWillAppear
    2st viewDidDisappear
    1st viewDidAppear
    
    //SecondViewController로 이동
    2st viewDidLoad
    1st viewWillDisappear
    2st viewWillAppear
    1st viewDidDisappear
    2st viewDidAppear
    ```

- What is better place for loading data from API?

  ```
  viewDidLoad method is called first time when UIViewController is first loaded and when it pop and then you reenter in it at that time viewDidLoad is called.
  So if you want to load the API only once then viewDidLoad is the best place to call an API.
  
  viewWillAppear called every time when you enter in that UIViewController and it is the place load the API when you want to get refreshed data (updated data).
  
  viewDidAppear also called like viewWillAppear but bit late called than viewWillAppear so if you want to call the API every time than the best place is viewWillAppear method.
  
  Because viewDidAppear method called late from viewWillAppear method and you are just requesting the API so the response of API may be late and If your UI change based on API response then it will stuck the application UI so there is a best place to call API either  viewDidLoad & viewWillAppear methods.
  ```

  ```
  근데 viewWillAppear에서 api를 불러오게 되면 api작업을 마칠 때까지 기다리기 때문에 앱 화면이 뜨기 전까지 delay가 생긴다. viewWillAppear에 sleep(5) 사용하면 화면이 안 뜬 상태에서 기다리는 것을 알 수 있음.
  
  그래서 api 불러오는 작업을 viewDidAppear에서 실행을 하여 일단 화면을 먼저 띄운 후에 작업을 진행하라고 하는 의견도 있었음
  
  어디에서 작업을 하든 상관없이 비동기로 작업을 하게 되니까 api를 불러오는 작업을 어디에서 호출하든 상관이 없는지? 그러함
  ```

- 출처: https://zeddios.tistory.com/44

