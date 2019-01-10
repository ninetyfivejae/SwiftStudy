## Week2. UIKit 사용해보기

- 2주차: 일요일 13:30까지 서현역 토즈 분당서현점

```
2주차 - UIKit 사용해보기
NSConstraint에 대해서,,,
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
```

## Autolayout

- 

## iOS App Lifecycle

![iOSAppLifeCylceImage](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/appLifeCylceImage.png?raw=true)

### 앱의 실행 상태는 5개 상태로 구분

- 앱 생명주기는 앱이 화면상에서 보이지 않는 background 상태, 화면에 올라와 있는 상태인 foreground 등과 같은 상태들을 정의한 것
  - Not Running: 앱이 실행되지 않은 상태
  - Foreground[Inactive]: 앱이 실행중인 상태 그러나 아무런 이벤트를 받지 않는 상태
  - Foreground[Active]: 앱이 실행중이며 이벤트가 발생한 상태
  - (Inactive와 Active 상태를 합쳐서 Foreground 라고 함)
  - Background: 앱이 백그라운드에 있는 상태 그러나 실행되는 코드가 있는 상태
  - Suspened: 앱이 백그라운드에 있고 실행되는 코드가 없는 상태

### 순서대로 정리, AppDelegate.swift

- AppDelegate.swift 파일이 있으므로 AppDelegate클래스가 만들어지고, 이 AppDelegate클래스에 인스턴스가 애플리케이션 내용이 그려질 window를 만든다

- @UIApplicationMain

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

  - UIApplicationMain()은 애플리케이션 생명주기를 담당하게 되는 AppDelegate를 메모리 상에 올려주는 역할

    ```swift
    //참고. objective-c UIApplicationMain함수 선언부
    int UIApplicationMain(
    	int argc,
    	char *argv[],
    	NSString *principalClassName,
    	NSString *delegateClassName
    );
    ```

    - principalClassName: 해당 애플리케이션에 사용하고자 하는 확장되는 기능을 가지고 있는 UIApplication 클래스. 인자로 넘긴 클래스에서 싱글톤 UIApplication 인스턴스 생성함
    - delegateClassName: 애플리케이션의 생명주기를 담당할 AppDelegate클래스

- 즉 앱이 시작되는 순간, main에서 UIApplicationMain()이 UIApplication 및 AppDelegate 객체를 각각 생성함

  - UIApplication 객체는 싱글톤 객체(앱 전체에 하나만 존재)이며 Event Loop에서 발생하는 여러 이벤트들을 감지하고 Delegate에 전달하는 역할을 한다. 예를 들면 앱이 백그라운드로 갈때, 메모리 부족 경고를 할 때와 같은 상황들을 감지하여 Delegate에 전달함
  - AppDelegate 객체는 UIApplication 객체로 부터 메시지를 받았을 때, 해당 상황에서 실행 될 함수들을 정의함. 생명주기를 담당하는 AppDelegate클래스는 UIApplicationDelegate 프로토콜을 준수하기 때문에 delegate메소드들을 구현할 수 있음. 이 프로토콜(UIApplicationDelegate)은 앱을 세팅하고, 앱 상태 변화에 응답하며 다른 app-level이벤트를 처리하는 데 사용하는 여러가지 방법을 정의한다

- Main Event Loop를 실행(touch, text input등 유저의 액션을 받는 루프) 및 기타 설정

- 앱 실행

- 종료

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

  - application: - 앱이 처음 시작될 때 실행

    ```swift
    applicationDidFinishLaunching(:)
    Tells the delegate when the app has finished launching.
    Don’t use. Instead, use application(_:didFinishLaunchingWithOptions:)
    ```

  - applicationWillResignActive: - 앱이 active 에서 inactive로 이동될 때 실행

  - applicationDidEnterBackground: - 앱이 background 상태일 때 실행

  - applicationWillEnterForeground: - 앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서 실행중이진 않음)

  - applicationDidBecomeActive: - 앱이 active상태가 되어 실행 중일 때

  - applicationWillTerminate: - 앱이 종료될 때 실행

- 위의 함수를 모두 구현 할 필요는 없고 상황에 맞춰 필요한 함수만 구현하면 되고, 위 함수들에는 없지만 원하는 delegate를 추가해도 된다.

- [출처1](https://medium.com/ios-development-with-swift/%EC%95%B1-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0-app-lifecycle-vs-%EB%B7%B0-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0-view-lifecycle-in-ios-336ae00d1855) / [출처2 objective-c 생명주기](http://j2enty.tistory.com/entry/iOS-iOS-Application-Life-Cycle) / [출처3 UIApplication클래스](https://zeddios.tistory.com/539?category=682195) / [출처4 AppDelegate.swift](https://zeddios.tistory.com/218?category=682195)

## iOS viewController LifeCycle

- 모바일 앱은 화면의 크기가 작아서 PC와 달리 하나의 화면에 하나의 ViewController만을 가진다. 그리고 여러개의 ViewController가 모여 하나의 앱을 만든다

- iOS 에서는 한 화면에서 다른 화면으로 전환할 때 기존의 화면위에 새로운 화면이 쌓이는 식으로 화면을 전환한다

- 이 때 각각의 뷰 컨트롤러는 자신만의 생명주기를 가지고 있고 이 생명주기를 잘 이해하고 있다면 뷰 컨트롤러의 상황에 따라 원하는 로직을 수행하도록 만들 수 있음

  ![viewControllerLifeCycleImage](https://docs-assets.developer.apple.com/published/f06f30fa63/UIViewController_Class_Reference_2x_ddcaa00c-87d8-4c85-961e-ccfb9fa4aac2.png)

- 여러개의 뷰 컨트롤러가 있는 앱이라고 한다면 각각의 뷰 컨트롤러는 자신만의 생명주기를 가진다

- 그래서 화면상에 등장 할 때, 사라질 때 등 상황에 맞춰서 함수들이 호출됨

- 뷰 컨트롤러 생명주기의 대표적인 함수

  - ViewDidLoad: 해당 뷰컨트롤러 클래스가 생성될 때(ViewWillAppear전에 실행) 실행된다. Low memory와 같은 특별한 경우가 아니라면 딱 한번만 실행되기 때문에 초기화 할 때 사용 할 수 있다
  - ViewWillAppear: 뷰 컨트롤러가 화면에 나타나기 직전에 실행된다. 뷰 컨트롤러가 나타나기 직전에 항상 실행되기 때문에 해당 뷰 컨트롤러가 나타나기 직전마다 일어나는 작업들을 여기에 배치 시킬 수 있다.
  - ViewDidAppear: 뷰 컨트롤러가 화면에 나타난 직후에 실행된다. 화면에 적용될 애니메이션을 그리거나 API로 부터 정보를 받아와 화면을 업데이트 할 때 이곳에 로직을 위치시키면 좋다. 왜냐하면 지나치게 빨리 애니메이션을 그리거나 API에서 정보를 받아와 뷰 컨트롤러를 업데이트 할 경우 화면에 반영되지 않기 때문
  - ViewWill/DidDisappear: 뷰 컨트롤러가 화면에 나타난 직전/직후에 실행.

- UIViewController 생명 주기

  ![viewControllerLifeCycleImage](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/viewControllerLifeCycle2Image.jpeg?raw=true)

  - loadView

    - Creates the view that the controller manages
    - You should never call this method directly. The view controller calls this method when its [`view`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621460-view)property is requested but is currently `nil`. This method loads or creates a view and assigns it to the [`view`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621460-view) property.
    - 필요하면 override 가능
      ...
    - [Document](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview)

  - viewDidLoad

    - Called after the controller's view is loaded into memory: 뷰의 컨트롤러가 메모리에 로드되고 난 후 호출된다
    - viewDidLoad 메소드는 뷰의 로딩이 완료 되었을 때, 시스템에 의해 자동으로 호출되기 때문에 일반적으로 리소스를 초기화하거나 초기 화면을 구성하는 용도로 주로 사용한다. 화면이 처음 만들어질 때 한 번만 실행되므로, 처음 한 번만 실행해야 하는 초기화 코드가 있을 경우 이 메소드 내부에 작성하면 된다

  - viewWillAppear

    - 뷰가 나타나기 직전에 호출

  - viewDidAppear

    - viewDidAppear는 뷰가 나타났다는 것을 컨트롤러에게 알리는 역할 및 화면에 적용될 애니메이션을 그려줌
    - 뷰가 화면에 나타난 직후에 실행

  - viewWillDisappear

    - 뷰가 사라지기 직전에 호출되는 함수
    - 뷰가 삭제 되려고하고있는 것을 뷰 콘트롤러에 통지함

  - viewDidDisappear

    - 뷰 컨트롤러가 뷰가 제거되었음을 알려줌

  - 예제

    ![stackArchitectureOfNavigationViewImage](https://docs-assets.developer.apple.com/published/83ef757907/NavigationViews_2x_e69e98a2-aaac-477e-9e33-92e633e29cc7.png)

  - view의 스택 구조

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
  
  어디에서 작업을 하든 상관없이 비동기로 작업을 하게 되니까 api를 불러오는 작업을 어디에서 호출하든 상관이 없는지?
  ```

- 출처: https://zeddios.tistory.com/44

## UITextView

- A scrollable, multiline text region

  - Unlike its name, a UITextView is not just a text view
    You can edit it, type in it, scroll it
  - By default a UITextView is editable. To disabled editing you need to set the property `isEditable` as `false`.

- To create it programmatically you need to create a rectangle with a width and height specified

  ```swift
  let uiTextView = UITextView()
  uiTextView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
  ```

- UITextView vs UITextField

  - UITextView is for multi-line input whereas UITextField by default is for a single line only
  - UITextView does not provide a placeholder/hint text by default

- UITextViewDelegate

  - The UITextViewDelegate protocol defines a set of **optional methods** that gets triggered when the text is being edited

  - **All the protocol methods are optional**

  - Following are some of the methods present in the UITextViewDelegate.
    - **textViewDidBeginEditing**
    - **textViewWillBeginEditing**
    - **textViewDidEndEditing**
    - **textViewWillEndEditing**
    - **textViewDidChange**: Gets called when the text is editted
    - **textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String)**: This returns a boolean which asks if the text should be replaced or not.

- UITextView를 사용했을 때 주의해야할 점

  - UITextView를 누르면 키보드가 뜨는데, 한 번 키보드가 생기면 사라지게 할 수 없음. Command + k를 누르면 생겼다가 사라질 수 있지만 앱으로만 조작했을 경우 안 사라짐. 그래서 키보드 사라지게 하기위해서 touchesBegan func override를 해서 구현
  - 기본으로 키보드가 나왔을 때 view를 가리면서 올라오기 때문에, UITextViewDelegate Protocol을 구현하여 view의 frame을 키보드만큼 올려줬음
    - In the viewDidLoad, we've added two Notification observers which detect changes in Keyboard and trigger the function `updateTextView`.
    - Inside the `updateTextView` we change the position of the UITextView depending on the notification name.
    - To move the UITextView above the keyboard, we calculate the keyboard height programmatically and shift the whole view upwards by that height.

- 코드

  ```swift
  import UIKit
  
  class ViewController: UIViewController, UITextViewDelegate {
      
      //UITextViewDelegate를 프로토콜을 준수하여 (Document 참고) UITextView와 communicate
      @IBOutlet weak var myUITextView: UITextView!
      @IBOutlet weak var myUITextField: UITextField!
      
      @IBOutlet weak var myUILabel: UILabel!
      @IBOutlet weak var myUIButton: UIButton!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          //view controller들에게 delegate function들을 적용시키기 위해
          self.myUITextView.delegate = self
          
          NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      }
      
      //키보드 사라지게 하기위해서 touchesBegan func override를 해서 구현
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          super.touchesBegan(touches, with: event)
          
          //self.view.endEditing(true) // 모든 UITextView에 적용하고 싶은 경우
          self.myUITextView.resignFirstResponder() //특정 UITextView에만 적용하고 싶은 경우
      }
      
      //UITextView 터치 시
      func textViewDidBeginEditing(_ textView: UITextView) {
          myUITextView.backgroundColor = UIColor.lightGray
          
          if textView.text == "Enter your notes here" {
              textView.text = ""
              textView.textColor = .black
          }
      }
      //UITextView 편집 완료 후, 다른 view를 터치하는 순간
      func textViewDidEndEditing(_ textView: UITextView) {
          myUITextView.backgroundColor = UIColor.white
          
          if textView.text == "" {
              textView.text = "Enter your notes here"
              textView.textColor = .lightGray
          }
      }
      
      //글자수 제한 기능
      func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          myUILabel.text = "\(myUITextView.text.characters.count)"
  
          return textView.text.characters.count + (text.characters.count - range.length) <= 100
      }
      
      @objc func updateTextView(notification: Notification) {
          if let userInfo = notification.userInfo {
              let keyboardFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
              
              let keyboardFrame = self.view.convert(keyboardFrameScreenCoordinates, to: view.window)
              
              if notification.name == UIResponder.keyboardWillHideNotification {
                  view.frame.origin.y = 0
              } else {
                  view.frame.origin.y = -keyboardFrame.height
              }
          }
      }
  }
  ```

- 출처: https://www.journaldev.com/22238/ios-uitextview-and-uitextviewdelegate

- [Text Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html)

- [Document](https://developer.apple.com/documentation/uikit/uitextview)

## UITextField

- An object that displays an editable text area in your interface.

- To create it programmatically

  ```swift
  func createSurnameTextField() {
      surnameTextField = UITextField()
      surnameTextField.frame = CGRectMake(110, 160, 150, 30)
      surnameTextField.borderStyle = .RoundedRect
      surnameTextField.clearButtonMode = .WhileEditing
      surnameTextField.placeholder = "Insert surname"
      self.view.addSubview(surnameTextField)       
  }
  ```

- UITextFieldDelegate

  - 특정 이벤트 발생시 실행되는 UITextFieldDelegate 메소드들이 있고, 사용할 메소드들을 ViewController 내부에 구현해주면 된다
  - **textFieldShouldBeginEditing**: called when the editing is about to begin
  - **textFieldDidBeginEditing**: called when the editing is began
  - **textFieldShouldEndEditing**: called when the editing is about to end
  - **textFieldDidEndEditing**: called when the editing ended
  - **textFieldshouldChangeCharactersInRange**: called whenever the user types a new character in the text field or deletes an existing character
  - **textFieldShouldClear**: called when the clearButton is pressed
  - **textFieldShouldReturn**: called when the keyboard return key is pressed. This method is used to dismiss keyboard

- 마찬가지로 키보드 나타나고 사라지는 부분 주의할 것

- 위에 UITextView 이어서 추가된 코드

  ```swift
  import UIKit
  
  class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
      
      //UITextViewDelegate를 프로토콜을 준수하여 (Document 참고) UITextView와 communicate
      @IBOutlet weak var myUITextView: UITextView!
      @IBOutlet weak var myUILabel: UILabel!
      
      @IBOutlet weak var userNameField: UITextField!
      @IBOutlet weak var passwordField: UITextField!
      @IBOutlet weak var phoneNumberField: UITextField!
      @IBOutlet weak var dataTextView: UITextView!
      @IBOutlet weak var submitButton: UIButton!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          //myUITextView에 delegate function들을 적용시키기 위해
          self.myUITextView.delegate = self
          
          NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
          
          self.userNameField.delegate = self
          self.passwordField.delegate = self
          self.phoneNumberField.delegate = self
      }
      
      //키보드 사라지게 하기위해서 touchesBegan func override를 해서 구현
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          super.touchesBegan(touches, with: event)
          
          self.view.endEditing(true) // 모든 UITextView에 적용하고 싶은 경우
          //self.myUITextView.resignFirstResponder() //특정 UITextView에만 적용하고 싶은 경우
          //self.userNameField.resignFirstResponder()
          //self.passwordField.resignFirstResponder()
      }
      
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          print("Editing is about to begin")
          return true
      }
      
      func textFieldDidBeginEditing(_ textField: UITextField) {
          textField.backgroundColor = UIColor.green
          print("Editing is began")
      }
      
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          print("Editing is about to end")
          return true
      }
      
      func textFieldDidEndEditing(_ textField: UITextField) {
          print("Editing ended")
          textField.backgroundColor = UIColor.white
      }
  }
  
  //extension ViewController: UITextFieldDelegate {
  //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  //        textField.resignFirstResponder()
  //        return true
  //    }
  //}
  ```

- 출처: http://www.danieledonzelli.com/ios/uitextfield-tutorial/

- [Document](https://developer.apple.com/documentation/uikit/uitextfield)

## UILabel

- A view that displays one or more lines of read-only text, often used in conjunction(결합, 연결) with controls to describe their intended purpose.

- The appearance of labels is configurable(수정 가능), and they can display attributed strings, allowing you to customize the appearance of substrings within a label

- 코드로 생성

  ```swift
  let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40)) self.view.addSubview(label)
  ```

- **NSTextAlignment**

  - .justified 는 언뜻보기로 .left 와 차이가 없게 느껴지나, linebreak 설정에 의해 행이 바뀔 때 들쭉날쭉해지는 문단의 마지막 부분을 뷰 넓이에 맞춰서 글자간격을 조정하는 것을 확인할 수 있음
  - .natural 도 .left 와 비슷하게 느껴지나, 지역화가 아랍어인 경우 자동으로 .right 정렬 되도록 합니다. (iOS 6.0+)

  ```swift
  label.textAlignment = .left //좌측 정렬.
  label.textAlignment = .center //중앙 정렬.
  label.textAlignment = .right //우측 정렬.
  label.textAlignment = .justified //행맞추기
  label.textAlignment = .natural
  ```

- **Baseline**: 20pt 폰트, 10pt 폰트 서로 다른 폰트 크기의 UILabel 들을 정렬할 때, 기준이 모호해진다. UILabel들은 세로 가운데 정렬은 되었지만 출력되는 글자들은 위/아래로 들쭉날쭉하게 보이게 된다. 이때 사용되는 정력하기 위한 속성

- **numberOfLines**: Label 에서 출력가능한 line 수를 정합니다. 0 은 제한이 없음을 표시합니다. AttributedString 의 경우도 마찬가지로 적용이됩니다.

- **adjustsFontSizeToFitWidth**: YES 로 설정한 경우, Label 의 bound 영역이 줄어들면 텍스트도 minimumScaleFactor 에 맞춰서 줄어든다

- **allowsDefaultTighteningForTruncation**: YES 로 설정한 경우, truncation 텍스트 자르기 가 발생하기 전에 최대한 글자 간격을 좁힌다. font, 라인의 넓이, line break mode 등 정보에 기인하여 적정한 간격이 선정된다

- **shadowColor, ShadowOffset**: 그림자 속성을 넣음

- **isHighlighted, highlightedTextColor**: 하이라이트 된 경우와 그렇지 않은 경우에 대한 컬러 속성을 지정

- 출처: http://goodyoda.tistory.com/392

- [Document](https://developer.apple.com/documentation/uikit/uilabel)

## UIButton

- A control that executes your custom code in response to user interactions.

- When you tap a button, or select a button that has focus, the button performs any actions attached to it. You communicate the purpose of a button using a text label, an image, or both. The appearance of buttons is configurable, so you can tint buttons or format titles to match the design of your app.

- 유용한 기능들

  - Outlet collection으로 버튼 3개를 배열로 선언해서 배열을 순회하면서 한 번에 속성을 변경시킴
  - 여러개의 버튼에 triggerOption이라는 하나의 이벤트를 걸어준다(ViewController 오른쪽 마우스로 클릭 후 ReceivedActions에서 버튼 이벤트로 touchup inside 연결을 시켜줌) 
  - 그리고 버튼마다 tag를 부여하여 버튼을 구별하고, 버튼 마다의 이벤트를 지정해준다.

- 위에 예제 코드 이어서, UIButton 기능 추가

  ```swift
  import UIKit
  
  class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
      
      //Outlet collection으로 생성하여 버튼들을 배열로 사용
      @IBOutlet var optionButtons: [UIButton]!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          //outlet collection 버튼 배열을 순회하여 색 변경
          for button in optionButtons {
              button.setTitleColor(UIColor.red, for: .normal)
          }
      }
      
      @IBAction func triggerOption(_ sender: Any) {
          //ViewController 오른쪽 마우스로 클릭 후 ReceivedActions에서 버튼 이벤트로 touchup inside 연결을 시켜줌
          //option 버튼 마다 tag를 설정해줘서 tag로 구별. text내용으로 구별도 가능
          let button = sender as! UIButton
          if button.titleLabel?.text == "Option1" {
              print("Option1 pressed")
          } else if button.tag == 2 {
              print("Option2 pressed")
          } else if button.tag == 3 {
              print("Option3 pressed")
          }
      }
  }
  ```

- 출처: https://youtu.be/NEf0uUIKPIo

- [Document](https://developer.apple.com/documentation/uikit/uibutton)

## 추가정리

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

