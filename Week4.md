# Week4. 클로저와 ARC

```
+ Swift 기본 패턴
- Delegate
- KVO: Key-Value Observing

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

## Delegate

- https://zeddios.tistory.com/8?category=682195

- 프로토콜은 서로간의 지켜야할 규약

- Delegate는 대리자 라는 뜻. 너가 해야할 일을 내가 해서 줄게

- swift에서 기존의 버튼이나 텍스트필드, 라벨 등의 객체들은 고유의 특징을 가지는데

  - 버튼은 누르면 동작
  - 텍스트필드는 글자를 입력할 수 있도록 해줌
  - 라벨은 글자 내용을 출력
  - 등등

- 델리게이트 패턴은 쉽게 말해서, 객체 지향 프로그래밍에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리 해야 할 일 중 일부를 다른 객체에 넘기는 것을 뜻함

- 가령, textField의 기능에는 명시 안하고, textField를 가진 뷰 컨트롤러에 명시

- viewDidLoad()함수에 textField.delegate = self 를 추가하면, delegate가 누구인지 명시하는 것임. textField의 뒷바라지는 내가 할게라는 의미. self라고 명시했기 때문에 현재클래스인 ViewController가 된다

- UITextFieldDelegate 프로토콜을 채택하여, textFieldShouldReturn(UITextFieldDelegate 안에 정의되어있는 함수)에 하고싶은 일을 구현만 하면 된다

- ```swift
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          enteredLabel.text = textField.text
          return true
  }
  ```

- @IBAction 클릭함수 대신에 처리할 함수를 구현한 것임

## Tab bar 이용

### 스토리보드 이용

- Embed in Tab Bar Controller 방법
- ViewController 5개 생성하여 TabBarController에서 RelationShip Segue 세그웨이를 각각 연결
- 탭바의 아이콘을 원하는 아이콘으로 변경하기 위해서는 TabBarController의 TabBar를 클릭하지 말고, 아이템을 변경하고 싶은 ViewController의 TabBar attributes inspector에 아이콘을 설정 해주면 된다. 
  기본으로 제공되는 아이콘은 System Item에 있으며, 사용자가 원하는 이미지는 Bar Item 섹션의 Image에서 선택해주면 된다.
- [출처](https://twer.tistory.com/6)

### 코드상에서만 이용

- 스토리보드에 빈 ViewController 연결 및 UITabBarController 프로토콜 채택

  ```swift
  import UIKit
  
  class ViewController: UITabBarController, UITabBarControllerDelegate {
  
      override func viewDidLoad() {
          super.viewDidLoad()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          // Create First Tab
          let tabOne = FirstViewController()
          let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
          tabOne.tabBarItem = tabOneBarItem
          
          // Create Second Tab
          let tabTwo = SecondViewController()
          let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
          tabTwo.tabBarItem = tabTwoBarItem2
          
          self.viewControllers = [tabOne, tabTwo]
      }
      
      // UITabBarControllerDelegate method
      func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
          print("Selected \(viewController.title!)")
      }   
  }
  ```

- 각 TabBar에 해당하는 ViewController 파일 생성 및 각각의 작업 구현

  ```swift
  import UIKit
  
  class FirstViewController: UIViewController {
  
      override func viewDidLoad() {
          super.viewDidLoad()
          
          //backgroundColor 지정 안 해주면 검은색으로 설정된다
          self.view.backgroundColor = .blue
          self.title = "Tab 1"
      }
      
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
  }
  ```

  ```swift
  import UIKit
  
  class SecondViewController: UIViewController {
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          //backgroundColor 지정 안 해주면 검은색으로 설정된다
          self.view.backgroundColor = .red
          self.title = "Tab 2"
      }
      
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
  }
  ```

- [출처](http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/)

## 프로젝트 패키지화, 폴더 사용

- **New Group**: 실제로 폴더를 생성함. xcode 왼쪽에 project navigator 보면 그냥 노란색 폴더로 생성된다
- **New Group without folder**: 실제로는 폴더가 생성이 안 되고, 그룹 project navigator에서만 폴더 내부로 들어가게 되는데, 좌측 하단에 화살표가 표시된 노란 폴더로 생성된다
- **폴더 reference**: 외부에서 project navigator로 파일이나 폴더를 끌어다놓으면, 아래와 같은 선택을 할 수 있는데, Create folder references를 선택하면 실제 폴더를 참조하게 되어 폴더를 지우게 되면 원본의 폴더도 같이 지워지게 된다
  - Create groups: 실제 폴더가 프로젝트 디렉토리에 복사가 된다
  - **Create folder references**

## kvo

Key value observing, 옵저버를 추가해 key에 해당하는 value 변경을 확인

viewDidLoad에 addObserver 하면

oberveValue의 동작이 수행된다

프로퍼티나 텍스트필드 등등에 적용가능. 다른 클래스의 속성을 지켜보고 싶으면, 클래스의 인스턴스를 가지고 있어야한다



여러 앱을 왔다갔다 하면서 사용하면 observing 추가한게 다른 앱에도 적용될 수 있어서, remove옵저버를 해줘야 좋다



notification 종류. nsnotification center 각 상황에 맞춰서 



keyPath로 접근해서 값을 빼오는게, 위험할 수 있음. 버전 올라가면서 바뀔 수 있으니까

