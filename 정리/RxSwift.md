# [RxSwift](https://github.com/ReactiveX/RxSwift)

- https://medium.com/@jang.wangsu/rxswift-rxswift%EB%9E%80-reactivex-%EB%9E%80-b21f75e34c10

- https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md

- [가장 간단한 예제](https://www.youtube.com/watch?v=2m92mRI8l7U&t=593s)

  - MasterViewController

    ```swift
    import UIKit
    import RxSwift
    
    class MainViewController: UIViewController {
    	
    	@IBOutlet weak var greetingsLabel: UILabel!
    	
    	let disposeBag = DisposeBag()
    
    	override func viewDidLoad() {
    		super.viewDidLoad()
    		
    	}
    	
    	@IBAction func selectCharacter(_ sender: Any) {
    
    		let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    
    		//detailVC.delegate = self
    
    		detailVC.selectedCharacter
    			.subscribe(onNext: { [weak self] character in
    				self?.greetingsLabel.text = "Hello \(character)"
    			}).disposed(by: disposeBag)
    
    		navigationController?.pushViewController(detailVC, animated: true)
    
    	}
    	
    	func didSelectCharacter(_ name: String) {
    		self.greetingsLabel.text = "Hello \(name)"
    	}
    	
    	override func didReceiveMemoryWarning() {
    		super.didReceiveMemoryWarning()
    	}
    	
    }
    
    extension UIViewController {
    	
    	static var instance: UIViewController {
    		return UIStoryboard(name: self.className, bundle: nil).instantiateInitialViewController()!
    	}
    	
    }
    
    extension NSObject {
    	
    	class var className: String {
    		return String(describing: self)
    	}
    	
    	var className: String {
    		return type(of: self).className
    	}
    	
    }
    
    ```

  - DetailViewController

    ```swift
    import UIKit
    import RxSwift
    
    class DetailViewController: UIViewController {
    	
    	let selectedCharacterVariable = Variable("User")
    	
    	var selectedCharacter: Observable<String> {
    		return selectedCharacterVariable.asObservable()
    	}
    	
    	override func viewDidLoad() {
    		super.viewDidLoad()
    		
    	}
    	
    	override func didReceiveMemoryWarning() {
    		super.didReceiveMemoryWarning()
    	}
    	
    	@IBAction func characterSelected(_ sender: UIButton) {
    		guard let characterName = sender.titleLabel?.text else {return}
    		
    		selectedCharacterVariable.value = characterName
    	}
    	
    }
    ```

- 좀 더 공부하고 정리해야함 ...

### [Subjects](<http://reactivex.io/documentation/subject.html>)

- Subject는 Observer와 Observable 두 역할을 수행하는 브릿지 또는 프록시 종류이다

- Observer 역할로 하나 이상의 Observable을 구독하며, Observable 역할로 아이템을 내보낼 수 있다.

- Subject를 지원하는 클래스는 PublishSubject, ReplaySubject, BehaviorSubject, Variable이 있다

  - PublishSubject: PublishSubject는 구독한 뒤에 Observable이 보낸 이벤트를 전달받는다.

    ```swift
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    
    subject.subscribeNext {
        print("Subscription First : \($0)")
    }.addDisposableTo(disposeBag)
    
    subject.on(.Next("a"))
    subject.on(.Next("b"))
    
    subject.subscribeNext {
        print("Subscription Second : \($0)")
    }.addDisposableTo(disposeBag)
    
    subject.on(.Next("c"))
    subject.on(.Next("d"))
    subject.onCompleted()
    
    // Output
    Subscription First : a
    Subscription First : b
    Subscription First : c
    Subscription Second : c
    Subscription First : d
    Subscription Second : d
    ```

  - ReplaySubject: ReplaySubject는 구독 전에 발생한 이벤트를 버퍼에 넣고, 버퍼에 있던 이벤트를 구독 후에 전달한다. 버퍼 크기를 설정한 만큼 구독 후 이벤트를 전달한다. 만약 버퍼 크기가 0이라면, PublishSubject와 같은 역할을 하게 된다.

    ```swift
    let disposeBag = DisposeBag()
    let subject = ReplaySubject<String>.create(bufferSize: 1)
    
    subject.subscribeNext { 
        print("Subscription First : \($0)")
    }.addDisposableTo(disposeBag)
    
    subject.on(.Next("a"))
    subject.on(.Next("b"))
    
    subject.subscribeNext {
        print("Subscription Second : \($0)")
    }.addDisposableTo(disposeBag)
    
    subject.on(.Next("c"))
    subject.on(.Next("d"))
    subject.onCompleted()
    
    // Output
    Subscription First : a
    Subscription First : b
    Subscription Second : b
    Subscription First : c
    Subscription Second : c
    Subscription First : d
    Subscription Second : d
    ```

  - BehaviorSubject: BehaviorSubject는 구독 후에 가장 최근 아이템을 전달합니다.

    ```swift
    let disposeBag = DisposeBag()
    let subject = BehaviorSubject(value: "f")
    
    subject.subscribeNext {
        print("Subscription First : \($0)")
    }.addDisposableTo(disposeBag)
    
    subject.on(.Next("a"))
    subject.on(.Next("b"))
    
    subject.subscribeNext {
        print("Subscription Second : \($0)")
    }.addDisposableTo(disposeBag)
    
    subject.on(.Next("c"))
    subject.on(.Next("d"))
    subject.onCompleted()
    
    // Output
    Subscription First : f
    Subscription First : a
    Subscription First : b
    Subscription Second : b
    Subscription First : c
    Subscription Second : c
    Subscription First : d
    Subscription Second : d
    ```

  - Variable

    - Variable은 BehaviorSubject를 감쌌지만, complete나 error 이벤트가 발생하지 않습니다. 그리고 Variable이 해제될 때 자동으로 complete를 호출합니다.

      ```swift
      let disposeBag = DisposeBag()
      let variable = Variable("f")
      variable.asObservable().subscribe {
          print("Subscription First : \($0)")
      }.addDisposableTo(disposeBag)
      
      variable.value = "a"
      variable.value = "b"
      
      variable.asObservable().subscribe {
          print("Subscription Second : \($0)")
      }.addDisposableTo(disposeBag)
      
      variable.value = "c"
      variable.value = "d"
      
      // Output
      Subscription First : Next(f)
      Subscription First : Next(a)
      Subscription First : Next(b)
      Subscription Second : Next(b)
      Subscription First : Next(c)
      Subscription Second : Next(c)
      Subscription First : Next(d)
      Subscription Second : Next(d)
      Subscription First : Completed
      Subscription Second : Completed
      ```

  - 위의 코드에서 초기값을 f로 설정하고, 구독을 추가하면 초기값 f가 전달된 것을 확인할 수 있습니다. 그리고 아래 코드에서 Variable의 init에서 subject로 BehaviorSubject를 생성하고, 값이 변경될 때 `_subject.on(.Next(newValue))`가 호출되어 이벤트를 전달함을 알 수 있다.

    ```swift
    public class Variable<Element> {
    	public var value: E {
    		get {
    			_lock.lock(); defer { _lock.unlock() }
    			return _value
    		}
    		set(newValue) {
    			_lock.lock()
    			_value = newValue
    			_lock.unlock()
    
    			_subject.on(.Next(newValue))
    		}
    	}
    
    	public init(_ value: Element) {
    		_value = value
    		_subject = BehaviorSubject(value: value)
    	}
    }
    ```

- 