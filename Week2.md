## Week2. UIKit 사용해보기

- 2주차: 일요일 12시 서현역 토즈 분당서현점

```
2주차 - UIKit 사용해보기
NSConstraint에 대해서,
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

```
재혁
iOS App Lifecycle
UITextView
UITextField

지호
iOS viewController LifeCycle
UILabel
UIButton
```

## Autolayout

- 

## iOS App Lifecycle

- 

## iOS viewController LifeCycle

- 

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

## asdf

- 