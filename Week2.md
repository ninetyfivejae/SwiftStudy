## Week2. UIKit 사용해보기

- 2주차
  - 다음 스터디 일요일 12시 서현역 토즈 분당서현점

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
——————————————
지호
iOS viewController LifeCycle
UILabel
UIButton
```

```
과제 목차

```

## Autolayout

- 

## iOS App Lifecycle

- 

## iOS viewController LifeCycle

- 

## UITextView

- A scrollable, multiline text region.

- Unlike its name, a UITextView is not just a text view. You can edit it, type in it, scroll it.
  A UITextView is a multiline text region. It has a built-in UIScrollView

  By default a UITextView is editable. To disabled editing you need to set the property `isEditable` as `false`.

- To create it programmatically you need to create a rectangle with a width and height specified

  ```swift
  let uiTextView = UITextView()
  uiTextView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
  ```

- UITextView vs UITextField

  - UITextView is for multi-line input whereas UITextField by default is for a single line only
  - UITextView does not provide a placeholder/hint text by default

- UITextViewDelegate

  - The UITextViewDelegate protocol defines a set of optional methods that gets triggered when the text is being edited

  - All the protocol methods are optional.

  - Following are some of the methods present in the UITextViewDelegate.
    - textViewDidBeginEditing
    - textViewWillBeginEditing
    - textViewDidEndEditing
    - textViewWillEndEditing
    - textViewDidChange: Gets called when the text is editted
    - textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String): This returns a boolean which asks if the text should be replaced or not.

- UITextView를 누르면 키보드가 뜨는데, 한 번 키보드가 생기면 사라지게 할 수 없음. Command + k를 누르면 생겼다가 사라질 수 있지만 앱으로만 조작했을 경우 안 사라짐.

- In the above code, we've implemented the UITextViewDelegate Protocol, implemented keyboard dismiss logic and moved the UITextView above the keyboard.

  - To set it on the UITextView we do: `bottomTextView.delegate = self`
  - We've implemented three functions of the **UITextViewDelegate** - `textViewDidBeginEditing`, `textViewDidEndEditing`, `textView(shouldChangeTextIn:)`. We change the background color of the UITextView when editting begins and ends.
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

- [Document](https://developer.apple.com/documentation/uikit/uitextview)

## UITextField

- 

## UILabel

- 

## UIButton

- 