# MVVM

> ### MVVM Architecture in Swift
>
> - MVVM Architecture in Swift
> - ViewModel
> - Command Pattern
> - Data Binding
> - Binding with Rx

##1. MVVM Architecture in Swift

- [참고1](https://wnstkdyu.github.io/2018/04/20/mvvmdesignpattern/)
  
- [참고2](https://junsae.tistory.com/30)
  
- MVVM가 나온 배경
  
- MVVM 패턴은 Microsoft의 엔지니어인 Ken Cooper와 Ted Peters에 의해 만들어졌다.
  - 이 패턴은 Windows의 그래픽 프레임워크인 WPF와 Silverlight에서 처음 적용되었다.
  - 이 패턴의 주요 목적은 **To simplify event-driven programming user interfaces**인데, 이것을 위해 View에 관한 로직과 비즈니스 로직을 철저히 구분한다. 여기서 사용되는 주요한 개념이 *Data binding*이다.
  
- MVVM 패턴이란
  
- 데이터 모델(Model) 부분과 화면을 보여주는 뷰(View) 그리고 뷰에서 발생되는 이벤트행동들을 뷰모델(ViewModel)로 나누는 것
  - 소프트웨어 아키텍처 패턴
  
- 왜 MVVM 패턴으로 개발을 하는가,

  1. 디자이너와 개발자의 협업시 유연하게 진행 할 수 있다.
  2. 반복되는 이벤트핸들러들과 비즈니스로직을 캡슐화하여 관리 할 수 있고, 재사용할 수 있다.
  3. 객체의 상관관계에 제약 받지 않고 좀 더 편리하게 이벤트들을 실행 할 수 있다.
  4. 유지보수가 편해진다. (기능만 구현해 놓는다면 쉽게 추가 할 수 있게 됩니다.)

- 장점
  - MVC 패턴의 View와 Model의 독립성을 유지하고 MVP 패턴과 같이 보여주는 로직과 비즈니스 로직을 나누었다. 물론 테스트 또한 나누어 실행할 수 있어 효율적인 유닛 테스트가 가능하다.
  
- 단점

  - 데이터 바인딩이 필수적으로 요구된다. 다양한 방법을 통해 바인딩이 가능하지만 그 작업을 위해 *Boilerplate code*를 짜야 한다. 그래서 간단한 View나 로직을 만들 때는 배보다 배꼽이 더 큰 경우를 볼 수도 있다.

    > Boilerplate code: 작지만 대체할 수 없고, 여러 곳에 포함되어야 하는 코드 섹션. 프로그래머가 매우 작은 일을 하기 위해서 많은 코드를 작성해야 하는 경우를 말한다.

- MVP와의 차이
  - MVP 패턴에서는 Presenter를 통해서 MVVM의 ViewModel과 거의 같은 역할을 한다. 그러나 **MVP 패턴은 Presenter가 View와 ‘1 대 1’ 관계를 맺어야 한다는 점에서 한계**를 가진다.
  - 따라서, 특정 View의 Presenter는 그 View에 특정되어진 로직을 가지고 있기 때문에 비슷한 역할을 하는 View의 경우 그 Presenter들은 중복되는 로직을 가지는 한계를 갖는다.
  - 반면, MVVM 패턴에서 ViewModel은 View를 전혀 모른다. View만 ViewModel을 인스턴스로 갖고 있고 데이터 바인딩을 통해 ViewModel의 데이터를 View에 표시한다.
  - 때문에 **굳이 ‘1 대 1’ 관계로 묶여 있지 않고 필요에 따라 ‘多 대 多’ 관계도 가능**하다. 그렇기 때문에 중복 로직을 줄일 수 있고 결합도를 낮출 수 있다
  
- 

- 위에 이론 내용 사진 찍어놓은거 내용 덧붙이면서 다시 한 번 더 정리

- 

## 2. ViewModel 이란,

- MVVM 패턴은 MVC 패턴과 마찬가지로 Model과 View를 가지고 Controller 대신 **ViewModel**이라는 개념을 도입했다.
  - Model: 기존 패턴들의 Model과 같이 실제적 데이터를 가지며 View와는 독립되어 있다. ViewModel이 소유하고 갱신하며 가공하여 View에 표시한다.
  - View: UIView와 UIViewController가 여기에 속하며 말 그대로 보여주는 작업과 유저 인터랙션을 받는 역할을 한다. 유저 인터랙션을 받아 ViewModel에게 명령(Command)를 내린다.
  - ViewModel: Model을 가공해 View에 전달하거나 유저 인터랙션이 올 경우 그에 따른 작업을 수행한다. 작업이 끝난 후 View를 이에 맞춰 바꿔줘야 하는데 데이터 바인딩을 통해서 이를 달성한다.

> - [Microsoft Docs MVVM 정의](https://docs.microsoft.com/en-us/previous-versions/msp-n-p/hh848246(v%3dpandp.10)?ranMID=24542&ranEAID=je6NUbpObpQ&ranSiteID=je6NUbpObpQ-P87ml7WHP9EPR9QcEFV8tQ&epi=je6NUbpObpQ-P87ml7WHP9EPR9QcEFV8tQ&irgwc=1&OCID=AID681541_aff_7593_1243925&tduid=(ir__b6c1wtlvrixh2y0wyefjvj9obu2xmyln3wdncoz000)(7593)(1243925)(je6NUbpObpQ-P87ml7WHP9EPR9QcEFV8tQ)()&irclickid=_b6c1wtlvrixh2y0wyefjvj9obu2xmyln3wdncoz000)
> - The view model acts as an intermediary between the view and the model, and is responsible for handling the view logic.
> - Typically, the view model interacts with the model by invoking methods in the model classes.
> - The view model then **provides data from the model in a form that the view can easily use.** The view model retrieves data from the model and then makes the data available to the view, and may reformat the data in some way that makes it simpler for the view to handle.
> - The view model also **provides implementations of commands that a user of the application initiates in the view**. For example, when a user clicks a button in the UI, that action **can trigger a command in the view model.**
> - The view model may also be responsible for defining logical state changes that affect some aspect of the display in the view, such as an indication that some operation is pending.

- Which means
  - ViewModel은 Presentation Logic을 다루게 된다 하지만 UI는 다루지 않는다
  - 그런 다음 뷰 모델은 뷰에서 쉽게 사용할 수 있는 형태로 모델의 데이터를 제공한다.
  - 또한 뷰 모델은 애플리케이션 사용자가 뷰에서 시작하는 command pattern 구현을 제공한다. 예를 들어 사용자가 UI에서 버튼을 클릭하면 해당 동작이 뷰 모델에서 명령을 트리거할 수 있다.
  - ViewModel과 View를 바인딩할 때 주로 Rx를 이용한다
- 참고
  - [여기 링크 안에 더 좋은 링크들 있음](https://github.com/ClintJang/sample-swift-mvvm)
  - [viewModel에 대해서](https://eunjin3786.tistory.com/31)
  - [커맨드 패턴의 좋은 설명](http://minsone.github.io/programming/better-mvvm-architecture-from-kickstarter-oss) 
  - [끝판왕 킥스타터 오픈소스](https://github.com/kickstarter/ios-oss)

## 3. Command Pattern이란,

- [참고1](<https://agostini.tech/2018/06/03/design-patterns-in-swift-command-pattern/>)

- MVVM + Command 패턴: 모델, 뷰, 뷰모델을 분리하기 위해서는 Command 패턴을 이용

- Command 패턴이란,

  - 커맨드 패턴을 이용하면 요구 사항을 객체로 캡슐화할 수 있으며, 매개변수를 써서 여러 가지 다른 요구 사항을 집어 넣을수도 있다. 또한, 요청 내역을 큐에 저장하거나 로그로 기록할수도 있으며, 작업취소 기능도 지원함.
  - 좀 더 쉽게 정의 해보면 여러 객체들에서 발생하는 일들을 Command 에서 일괄적으로 명령을 처리를 하게 된다. 그러므로 각각의 일들을 분리 시켜서 관리 할 수 있음.
  - Command 패턴을 가지고 MVVM 아키텍쳐의 뷰와 뷰모델을 분리 할 수 있도록 만드는 것

- The command pattern is used to express a request, including the call to be made and all of its required parameters, in a command object.

- The command may then be executed immediately or held for later use.

  ```swift
  protocol DoorCommand {
      func execute() -> String
  }
  
  class OpenCommand : DoorCommand {
      let doors:String
  
      required init(doors: String) {
          self.doors = doors
      }
      
      func execute() -> String {
          return "Opened \(doors)"
      }
  }
  
  class CloseCommand : DoorCommand {
      let doors:String
  
      required init(doors: String) {
          self.doors = doors
      }
      
      func execute() -> String {
          return "Closed \(doors)"
      }
  }
  
  class HAL9000DoorsOperations {
      let openCommand: DoorCommand
      let closeCommand: DoorCommand
      
      init(doors: String) {
          self.openCommand = OpenCommand(doors:doors)
          self.closeCommand = CloseCommand(doors:doors)
      }
      
      func close() -> String {
          return closeCommand.execute()
      }
      
      func open() -> String {
          return openCommand.execute()
      }
  }
  ```

  ```swift
  let podBayDoors = "Pod Bay Doors"
  let doorModule = HAL9000DoorsOperations(doors:podBayDoors)
  
  doorModule.open()
  doorModule.close()
  ```

### Command 패턴을 통해 View와 ViewModel을 분리

- 아래부터 스위처 앱으로 예제 정리하기

## 5. Data Binding

- 데이터 바인딩의 개념은 쉽게 말해 **Model과 UI 요소 간의 싱크를 맞춰주는 것**이라 할 수 있다(정확히 말하면 UI 데이터 바인딩이지만 iOS를 다루기 때문에 이것을 다룬다)
- 이 패턴을 통해 View와 로직이 분리되어 있어도 한 쪽이 바뀌면 다른 쪽도 업데이트가 이루어져 데이터의 일관성을 유지할 수 있다.

### [Property Observer 사용한 Data Binding 예제](https://wnstkdyu.github.io/2018/04/20/mvvmdesignpattern/)

- iOS에서 데이터 바인딩을 하는 방법은 다음과 같다.
  - KVO
  - Delegation
  - Functional Reactive Programming
  - Property Observer: 우리는 이 중에서 **Property Observer**를 사용해 볼 것이다.

>  두 텍스트 필드에 사람의 이름과 나이를 넣으면 그 아래에 있는 레이블이 그것을 표시하는 앱

```swift
struct Person {
    var name: String
    var age: Int
}
```

그 다음, Person을 표시할 ViewModel

```swift
struct PersonViewModel {
    var person: Person
}
```

ViewController에서는 UITextFieldDelegate의 메서드인 `textFieldDidEndEditing`를 통해 텍스트 필드에 변화가 일어나면 레이블에서 단순히 뿌려준다.

```swift
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nameText = nameTextField.text,
            let ageText = ageTextField.text,
            let age = Int(ageText) else { return }
        
        personViewModel.person.name = nameText
        personViewModel.person.age = age
        
        yearLabel.text = nameText + " " + "\(age)세"
    }
}
```

이 상태에서는 UI의 변화가 ViewModel에 영향을 끼치고 있다. 즉, 방향이 하나인 것이다. 이것을 **프로퍼티 옵저버**를 통해 데이터 바인딩을 하여 양방향으로 해보자.

먼저, `didSet`을 통해 Person의 변화를 감지한다. 변화 이벤트가 일어날 시 적절한 처리를 할 객체가 필요한데 이것에는 다양한 방법을 사용할 수 있다. 그 중 클로저를 사용해보자. `bind(lisenter: Listener?)` 메서드를 통해 외부에서 PersonViewModel의 Listener 타입의 listener를 지정할 수 있게끔 한다.

```swift
struct PersonViewModel {
    typealias Listener = (Person) -> Void
    var listener: Listener?
    
    var person: Person {
        didSet {
            listener?(person)
        }
    }
    ...
    mutating func bind(listener: Listener?) {
        self.listener = listener
    }
}
```

그러면 ViewController에서는 다음과 같이 바인딩을 하면 된다.

```swift
override func viewDidLoad() {
    ...
    personViewModel.bind { [weak self] person in
        self?.yearLabel.text = person.name + " " + "\(person.age)세"
    }
}
```

이를 통해 textFieldDidEndEditing에서 Person이 바뀌었을 시에, 즉 ViewModel이 바뀌었을 때 자동으로 yearLabel이 업데이트될 것이다.

텍스트 필드도 delegate를 사용하지 않고 데이터 바인딩을 통해 로직을 수행할 수 있다. UITextField를 상속하는 BindingTextField 클래스를 만들어 해보자.

```swift
class BindingTextField: UITextField {
    var textChanged: (String) -> Void = { _ in }
    
    func bind(callBack: @escaping (String) -> Void) {
        textChanged = callBack
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let text = text else { return }
        textChanged(text)
    }
}
```

BindingTextField는 위에서와 마찬가지로 클로저 textChanged를 통해 이벤트를 감지할 시 일어날 작업을 정의한다. 또 bind 메서드를 통해 textChanged에 인자로 받은 callBack 클로저를 넣어주고 더불어 editingChnaged 때 일어날 메서드를 등록해둔다. 그래서 텍스트 필드 안의 값이 변경될 시 textChnaged 클로저가 실행된다.

ViewController에서는 다음과 바꿔주면 된다.

```swift
@IBOutlet weak var nameTextField: BindingTextField! {
    didSet {
        nameTextField.bind { [weak self] name in
            self?.personViewModel.person.name = name
        }
    }
}
@IBOutlet weak var ageTextField: BindingTextField! {
    didSet {
        ageTextField.bind { [weak self] ageText in
            guard let age = Int(ageText) else { return }
            self?.personViewModel.person.age = age
        }
    }
}
```

### Rx 사용한 Data Binding 예제

-  ==> Rx 라이브러리로 데이터 바인딩 시킨 예제 추가하기
- 

## 느낀 점

- 예전에 프로그래밍을 할 때에는 크게 디자인 패턴을 적용하는데 큰 필요성을 느끼지 못했습니다.
- 하지만 공부를 계속 하고 실제 서비스 앱을 직접 만들다 보니 Controller가 커지는 것을 실감할 수 있었고, 너무 많은 로직들이 들어가서 유지보수하는데 어려움을 직접 느낄 수 있었습니다.
- ==> 결국엔 이것들 포트폴리오에 작성 예정
