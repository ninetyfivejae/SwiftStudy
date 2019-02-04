# Segue

- An object that prepares for and performs the visual transition between two view controllers.
- Segue: 화면 전환을 뜻함 / 세그웨이 사전적 의미: 하나에서 다른 것으로 부드럽게 넘어가다라는 뜻
- 종류
  - **show**: 화면에 보여지고 있는 마스터 또는 디테일 영역에 뷰를 로드한다. 마스터와 디테일 영역 모두 화면에 보여지고 있을 경우 로드되는 새로운 컨텐츠 뷰는 디테일 영역의 네비게이션 스택에 푸시된다. 마스터와 디테일 영역중 하나만 보여지고 있을 경우 현재 뷰컨트롤러 스택의 최상단에 푸시된다. 새 화면으로 이동하는데 Stack구조로서 새 화면이 원래 화면 위를 덮는 구조이다
  - **show detail**: show와 매우 비슷하지만 푸시가 아닌 교체(replace)된다는 점이 크게 다르다. 마스터와 디테일 영역 모두 화면에 보여지고 있을 경우 로드되는 뷰는 디테일 영역을 교체하게 되며 둘중 하나만 보여지고 있을 경우 현재 뷰컨트롤러 스택의 최상단 뷰를 교체하게 된다. SplitView 구조에서 원래 화면을 Master, 새 화면을 Detail로 표시한다. 아이폰에서는 똑같아 보이지만 아이패드로 보면 화면이 둘로 분할되서 보이게 된다.
  - **present modally**: 새로 로드하는 컨텐츠 뷰를 모달 형태로 띄운다. 원래 화면은 새 화면 뒤에 그대로 존재함. UIModalPresentationStyle 옵션을 이용하여 보여지는 스타일을 결정하거나 UIModalTransitionStyle 옵션을 사용하여 트랜지션 스타일을 설정할 수 있다.
  - **popover presentation**: iPad만 해당. 현재 보여지고 있는 뷰 위에 앵커를 가진 팝업 형태로 컨텐츠 뷰를 로드한다. UIPopoverArrowDirection 옵션을 사용하여 창에 붙어있는 엣지의 방향을 설정 할 수 있다.
  - **custom**: 사용자 정의 세그웨이를 만든다
- [한 번에 쉽게 정리해놓은 블로그](http://blog.lattecom.xyz/2016/06/06/swift-ios-scene-transition/)
- [참고, 가장 잘 정리해놓은 블로그 및 코드](https://digitalleaves.com/define-segues-programmatically/)
- [tip & tricks](https://medium.com/@biz84/ios-segues-tips-and-tricks-78847484d2ba)
- [segue trigger 되는 과정](https://soooprmx.com/archives/8873)

## iOS에서 화면전환 방식

1. **Present / Dismiss**: 뷰 컨트롤러에서 다른 뷰 컨트롤러를 호출하기. 
2. **Push / Pop**: 내비게이션 컨트롤러 사용하기.
3. 화면 전환용 객체 세그웨이(Segueway) 사용하기

- 기본적으로 iOS의 화면 전환은 **stack**과 같은 느낌이다. 화면이 바뀔 때마다 원래 있던 화면 위에 새 화면이 올라가는 형식이다
- 여기서 주의 해야할 부분은 이전 화면으로 돌아갈 때엔 새 화면을 올릴 때처럼 이전화면을 새로 위에 올리는게 아니라 stack에서 pop을 하는 것처럼 올렸던 화면을 빼야한다는 것이다
- 이전 화면으로 돌아갈 때 현재화면의 pop이 아니라 이전화면의 push로 구현시엔 인스턴스가 중복되어 에러가 발생할 수도 있고, 에러가 나지 않더라도 메모리 낭비로 이어지기때문에 주의해야한다.

### 1. 뷰 컨트롤러에서 다른 뷰 컨트롤러를 호출하기

- `presentViewController(_:animated:completion:)`
- `dismissViewControllerAnimated(_:completion:)`
- 이 방법에서 주의해야할 점은 위 메소드를 호출하는 객체가 동일하다는 것이다.
  뷰 컨트롤러 A가 `self.presentViewController(_:animated:completion:)`로 뷰 컨트롤러 B를 호출하면, 
  B와 A사이에는 다음과 같은 속성을 갖는다.
  - A.presentedViewController => B
  - B.presentingViewController => A
- 여기서 B에서 A로 돌아갈 땐 A에서 B로 갈 때처럼 `self.dismissViewControllerAnimated(_:completion:)`이 아니라 다음과 같이 A를 참조하여 호출한다. `self.presentingViewController?.dismissViewControllerAnimated(_:completion:)`

### [instantiateViewController](https://youtu.be/-Rsr3hoSRes)

- 메인 ViewController에서 이동할 ViewController swift 파일 생성. 여기에서는 SecondViewController.swift 파일 사용

  - 스토리보드에서 Custom class 파일 지정
  - **ViewController의 storyboard id 지정. instantiateViewController메소드 사용 시 필요. SecondVC로 지정했음**

- 새로운 ViewController를 present할 액션 생성

  - ViewController.swift / 첫 번째 ViewController의 present할 액션 메소드

  ```swift
  @IBAction func triggerOption(_ sender: Any) {
          let button = sender as! UIButton
          
          if button.titleLabel?.text == "Option1" {
              let sb = UIStoryboard(name: "Main", bundle: nil)
              if let secondVC = sb.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController {
                  secondVC.infoObject = "Hello, World!"
                  self.present(secondVC, animated: true, completion: nil)
                  //secondVC.informationLabel.text = "Hello, World!"
              }
          } else if button.tag == 2 {
              print("Option2 pressed")
          } else if button.tag == 3 {
              print("Option3 pressed")
          }
      }
  ```

- SecondViewController.swift / 두 번째 ViewController

  - 다시 이전 ViewController로 돌아갈 dismiss 수행을 위한 goBack 메소드 설정

  ```swift
  import UIKit
  class SecondViewController: UIViewController {
      
      @IBOutlet weak var informationLabel: UILabel!
      var infoObject: String?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          if infoObject != nil {
              informationLabel.text = infoObject
          }
      }
      
      @IBAction func goBack(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
      }
  }
  ```

- 다른 예시

  ```swift
  @IBAction func nextButtonTapped(_ sender: Any) {
      let senderViewController = storyboard?.instantiateViewController(withIdentifier: "SenderViewController") as! SenderViewController
  
      senderViewController.delegate = self
  
      present(senderViewController, animated: true, completion: nil)
  }
  ```

- 데이터 전달 시 주의사항

  - present 하는 메소드에서 생성되지 않은 informationLabel의 text를 변경하려고 하면 오류가 난다.
  - 그래서 present메소드 이후에 속성을 변경하거나,
  - infoObject라는 변수에 값을 담아두고 ViewController의 viewDidLoad 메소드 호출 시 할당을 해주면 된다

### 2. 네비게이션 컨트롤러 사용하기

- `pushViewController(_:animated:)`

- `popViewControllerAnimated(_:)`

- 다음 화면으로 띄울 뷰컨트롤러 스토리보드 id를 이용한 경우

  ```swift
  let secondViewController:UIViewController =  self.storyboard?.instantiateViewController(withIdentifier: "StoryboardIdOfsecondViewController") as? SecondViewController
  
  self.navigationController?.pushViewController(secondViewController, animated: true)
  ```

  ```swift
  let navigationController: UINavigationController = UINavigationController()
  navigationController.popViewController(animated: true)
  ```

- 아예 스토리보드 사용하지 않고 다음 화면 전환하기. NavigationController인 경우에 사용 가능

  ```swift
  @IBAction func addButtonTapped(_ sender: Any) {
      let test = ViewController()
      self.navigationController?.pushViewController(test, animated: true)
  }
  ```

- **이 방법은 전체적인 화면 관리를 navigationController가 맡아서 한다는 것이 특징이다.**

- 1번 방법은 뷰 컨트롤러가 직접 메소드를 호출했지만, 2번 방법은 2가지 메소드 모두 아래와 같이 navigationController가 호출한다.
  `self.navigationController?.pushViewController(_:animated:)`
  `self.navigationController?.popViewControllerAnimated(_:)`

- 네비게이션 컨트롤러를 이용한 방법의 특징 중 하나는 `pushViewController(_:animated:)`를 이용하여 화면 전환을 하게 되면 전환된 뷰 컨트롤러에 자동으로 네비게이션 바가 탑재되고, 네비게이션 바 왼쪽에 아이템을 별도로 지정하지 않았을 경우 자동으로 `popViewControllerAnimated(_:)`를 이용한 Unwind가 구현된다는 것이다.

### 3. 화면 전환용 객체 세그웨이(Segueway) 사용하기

- Action Segue
  - 버튼등 이벤트가 발생하는 객체와 뷰 컨트롤러를 직접 연결할 때 사용
- Manual Segue
  - **매뉴얼 세그는 뷰 컨트롤러와 뷰 컨트롤러를 직접 연결하며  `performSegueWithIdentifier(_:sender:)`를 특정 시점에 호출하여 전환을 한다.**
  - 세그웨이를 이용한 전환에서 Unwind의 경우 스토리보드에서 뷰 컨트롤러를 선택시 윗 부분에 나타나는 3개의 아이콘 중에서 오른쪽 끝에 있는 Exit 아이콘에 연결하여 복귀할 뷰 컨트롤러 클래스에서 정의된 Unwind 메소드를 지정함으로써 구현한다.
- 세그웨이는 UIStoryboardSegue 클래스를 상속받아 커스텀 세그를 구현할 수 있다. 이미 정의되어있는 `perform(_:)` 메소드를 override하여 구현한다.
- `prepareForSegue(segue: UIStoryboardSegue, sender: Anyobject?)` 메소드를 전환 되는 시점의 뷰 컨트롤러 클래스에 재정의(override)하여 세그웨이가 실행되기 전 특정 코드를 실행할 수 있다.

### [performSegue, withIdentifer](https://youtu.be/OZix7etsd8g)

- 메인 ViewController에서 이동할 ViewController swift 파일 생성. 여기에서는 SecondViewController.swift 파일 사용

  - 스토리보드에서 Custom class 파일 지정

- 스토리보드에서 드래그하여 segue 생성. Segue identifier 지정. SecondVCSegue & ThirdVCSegue라고 지정함

- 새로운 ViewController로 이동하기 위한 prepare 메소드 작성

  - segue identifier에 따라 이동할 ViewController와 작업 지정

  ```swift
  import UIKit
  class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
  
      ...
      
      override func viewDidLoad() {
          super.viewDidLoad()
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "SecondVCSegue" {
              if let secondVC = segue.destination as? SecondViewController {
                  secondVC.infoObject = "[Segue]: Hello, World!"
              }
          } else if segue.identifier == "ThirdVCSegue" {
              if let secondVC = segue.destination as? SecondViewController {
                  secondVC.infoObject = "Username: \(userNameField.text!)\nPassword: \(passwordField.text!)\nPhone Number: \(phoneNumberField.text!)"
              }
          }
      }
  }
  ```

- SecondViewController.swift / 두 번째 ViewController

  - 속성 변경하기 위한 설정

  ```swift
  import UIKit
  class SecondViewController: UIViewController {
      
      @IBOutlet weak var informationLabel: UILabel!
      var infoObject: String?
  
      @IBOutlet weak var dataTextView: UITextView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          if infoObject != nil {
              informationLabel.text = infoObject
              dataTextView.text = infoObject
          }
      }
  }
  ```

- 데이터 전달 시 주의사항

  - Prepare 메소드에서 생성되지 않은 view의 속성을 변경하려고 하면 오류가 난다.

  - infoObject라는 변수에 값을 담아두고 ViewController의 viewDidLoad 메소드 호출 시 할당을 해주면 된다

  - The order of the last steps might vary slightly. However, what never changes is that **prepareForSegue: is always called after the destination view controller has been initialized, and just before its viewDidLoad method is invoked.**

    Why is this important? Because if you are defining a property of the destination view controller, you will only be able to use it from viewDidLoad, not before. Thus, generally speaking, you can use a property passed through a segue in viewDidLoad, viewWillAppear and viewDidAppear safely.

    ![lifeCycleOfViewControllersDuringSegues](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/lifeCycleOfViewControllersDuringSegues.png?raw=true)

### [Custom Segue](https://www.youtube.com/watch?v=jn-93qElOT4)

- CustomSegue클래스 생성

  - override	perform 메소드

  - Custom 액션 구현

    ```swift
    import UIKit
    class CustomScaleSegue: UIStoryboardSegue {
        override func perform() {
            scale()
        }
        
        func scale() {
            let toViewController = self.destination
            let fromViewController = self.source
            
            let containerView = fromViewController.view.superview
            let originalCenter = fromViewController.view.center
            
            toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            toViewController.view.center = originalCenter
            
            containerView?.addSubview(toViewController.view)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                toViewController.view.transform = CGAffineTransform.identity
            }, completion: { success in
                fromViewController.present(toViewController, animated: false, completion: nil)
            })
        }
    }
    ```

- 스토리보드에서 custom segue로 연결 후 직접 구현한 CustomSegue 클래스 설정

- 다시 돌아가는 CustomSegue도 구현하고 적용하기 위해서, 다시 돌아갈 ViewController클래스에 prepareForUnwind 함수 구현해줘야 액션을 ViewController exit과 연결시킬 수 있음.

- Unwind 메소드 override해서 직접 구현한 CustomUnwindSegue 메소드를 호출함

  ```swift
  @IBAction func prepareForUnwind (segue: UIStoryboardSegue) {
  
  }
  
  override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
      let segue = CustomUnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
      segue.perform()
  }
  ```

