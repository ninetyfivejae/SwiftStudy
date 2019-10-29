# Views and Controls

## Frame and Bounds

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

## Interface Builder

- 코드를 작성하지 않고도 전체 user interface를 간단하게 디자인할 수 있음
- windows, buttons, text fields 등의 objects를 끌어다 놓기만 하면 작동하는 userinterface를 만들 수 있음

> Storyboards, Assistant, Auto Layout, Preview
> https://developer.apple.com/xcode/interface-builder/

Interface Builder에서 사용되는 속성이라고 인식 하기 위해 내부적으로 변환되어 동작

```swift
#ifndef IBOutlet
#define IBOutlet
#endif
```

```swift
#ifndef IBAction
#define IBAction void
#endif
```

### frame

- The frame rectangle, which describes the view’s location and size in its <b>superview’s</b> coordinate system.

#### Declaration

```swift
var frame: CGRect { get set }
```

### bounds

- The bounds rectangle, which describes the view’s location and size in <b>its own</b> coordinate system.

#### Declaration

```swift
var bounds: CGRect { get set }
```

## Frame-Based Layout

- 직관적인 위치 명시. 디바이스마다 또는 화면 변경시마다 일일이 프레임 위치 명시해줘야함
- 뷰 계층 구조에서 각 뷰마다 frame을 설정하여 user interface를 배치
- 어떤 뷰의 크기나 위치가 바뀌면 영향 받는 뷰들의 frame을 재계산해야 함.
- 간단한 user interface라도 설계, 디버그, 유지관리에 상당한 비용 발생
- origin(x, y) / height / width
- ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/layout_views_2x.png)

## Auto Layout

- 뷰의 frame 대신, 뷰들의 relationships을 생각하는 방식. 뷰와뷰 사이의 관계를 사용
- Auto Layout은 일련의 constraints를 사용하여 user interface를 정의
  - Constraints는 일반적으로 2개의 view  사이의 관계를 타냄
- Constraints에 기반하여 각각의 뷰는 크기와 위치를 계산
- 어느 위치에, x좌표 y좌표 지정해주고 너비, 높이 지정하면 뷰를 그릴 수 있음. 근데 이 중 하나를 명시를 하지 않으면 조건이 다 만족됐을 시에는 가변적인 크기로 지정이 된다.
- ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/layout_constraints_2x.png)

## Auto Layout을 왜 쓰는가

1. 화면 크기와 디바이스 방향에 따라 유연하게 업데이트 되는 UI를 비교적 쉽게 구현
2. 향후 새로운 해상도의 디바이스가 출시되더라도 업데이트 없이 일관된 UI를 유지 가능
3. 화면 좌표를 직접 계산하거나 수많은 분기 코드를 작성할 필요가 없음
4. 우선 순위와 활성화 속성을 활용하여 특정 조건에 따라 업데이트 되는 UI를 구현 가능
5. 지역화 문자열을 사용할 때 문자열의 너비에 따라 버튼이나 레이블의 너비가 자동으로 업데이트
6. Content Hugging과 Compression Resistance의 우선 순위를 조절하여 동적인 UI를 더욱 세부적으로 제어 가능
7. 뷰 애니메이션, 모션 이펙트와 함께 사용 가능
8. 동일한 계층구조에 존재하지 않는 뷰 사이의 관계를 설정 가능
9. 스토리보드에서 제약을 쉽게 추가할 수 있으며, 코드를 통해 런타임에 동적으로 추가하거나 제거 가능

## Constraint

- 일련의 선형 방정식으로 정의 가능
- ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/view_formula_2x.png)

## NSLayoutConstraint

- Autolayout 환경에서 충족되어야할 두개의 user interface 객체 사이의 관계
- [NSLaytoutConstraint](https://developer.apple.com/documentation/uikit/nslayoutconstraint)

### firstItem

- The first object participating in the constraint.

```swift
unowned(unsafe) var firstItem: AnyObject? { get }
```

### firstAttribute

- The attribute of the first object participating in the constraint.

```swift
var firstAttribute: NSLayoutConstraint.Attribute { get }
```

### relation

- The relation between the two attributes in the constraint.

```swift
var relation: NSLayoutConstraint.Relation { get }
```

### secondItem

- The second object participating in the constraint.

```swift
unowned(unsafe) var secondItem: AnyObject? { get }
```

### secondAttribute

- The attribute of the second object participating in the constraint.

```swift
var secondAttribute: NSLayoutConstraint.Attribute { get }
```

### multiplier

- The multiplier applied to the second attribute participating in the constraint.

```swift
var multiplier: CGFloat { get }
```

### constant

- The constant added to the multiplied second attribute participating in the constraint.

```swift
var constant: CGFloat { get set }
```

## Auto Layout Attributes

- four edges (leading / trailing / top / bottom)
- height, width
- centerX(horizontal), centerY(vertical)
- baseline
- Not An Attribute
- [NSLaytoutAttribute](https://developer.apple.com/documentation/uikit/nslayoutattribute)
  ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/attributes_2x.png)

## Creating Nonambiguous, Satisfiable Layouts

- Constraint는 각 뷰의 사이즈와 위치가 정의되어야만 함.

![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/Art/constraint_examples_2x.png)

## 추가 설명

- Xcode 프리뷰 기능, 빌드하지 않고 어떻게 나오는지 확인하는 기능
- Xcode 메모리 릭 확인하는 기능도 찾아볼 것

## UITextView

- **A scrollable, multiline text region**

  - Unlike its name, a UITextView is not just a text view
    You can edit it, type in it, scroll it
  - By default a UITextView is editable. To disabled editing you need to set the property `isEditable` as `false`.

- To create it programmatically you need to create a rectangle with a width and height specified

  ```swift
  let uiTextView = UITextView()
  uiTextView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
  ```

- UITextView vs UITextField

  - UITextView is for multi-line input, whereas UITextField by default is for a single line only
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

- Memory Management

  - didReceiveMemoryWarning() method: built-in support for reducing their memory footprint at critical times. Releases unneeded memory. 
  - Sent to the view controller when the app receives a memory warning.

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

- UILabel, UIButton은 UIControl 또는 UIView를 subclass 하여 구현된 view이다

  - UIButton은 UIControl을 상속받기 때문에 클릭 이벤트 가능. **Protocol을 채택하여 준수한다는 용어 사용**
  - UISwitch또한 UIControl을 상속 받음. UIControl은 IBAction을 상속받아 구현 가능. 눌렀을 때의 액션을 정의 가능
  - UILable은 UIView를 가지고 UIControl은 안 가지기 때문에 누를 수 없음

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

- **numberOfLines**: Label 에서 출력가능한 line 수를 정합니다. 0 은 제한이 없음을 표시합니다. AttributedString 의 경우도 마찬가지로 적용.

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

