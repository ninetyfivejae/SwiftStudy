# [RxSwift](https://github.com/ReactiveX/RxSwift)

- [무엇인지에 대한 블로그](https://medium.com/@jang.wangsu/rxswift-rxswift%EB%9E%80-reactivex-%EB%9E%80-b21f75e34c10)

- https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md

- [잘 정리해놓으신 분 레포지토리](<https://github.com/fimuxd/RxSwift>)

- [RxSwift가 무엇인지에 대한 세미나?? realm 영상](<https://academy.realm.io/kr/posts/how-to-use-rxswift-with-simple-examples-ios-techtalk/>)

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

### RxSwift in playground

- Clone the **RxSwift repository** on your computer
- Open **Rx.xcworkspace**
- Build the **RxSwift-macOS** scheme
- Open **Rx.playground** in the Rx.xcworkspace tree view and select TryYourself page or add new page

### Observable

- Observable (something which emits notifications of change)

- An Observable is a sequence of ongoing events ordered in time.ie Only one element is received at a particular time. eg in tableView delegates (did Select Row At Indexpath) only one element is received.

- Observable emits events. Event is an enum containing three types of events.Next for getting actual value , Error is sent when something goes wrong and completed is sent when an Observable wants to tell his observers that no more events will be sent.

  ```swift
  public enum Event<Element> {
  	case next(Element)
  	case error(Swift.Error)
  	case completed
  }
  ```

### Subscribe

- Subscribe(something listening to Observable)

- subscribe is a very important method while working with Observables.The listening to observable is called subscribing.. If you forget to call subscribe no events(next, error, completed) will ever come to you.

  ```swift
  let helloSequence = Observable.from(["H","e","l","l","o"])
  let subscription = helloSequence.subscribe { event in
  	switch event {
  	case .next(let value):
  		print(value)
  	case .error(let error):
  		print(error)
  	case .completed:
  		print("completed")
  	}
  }
  ```

### DisposableBag

- Just like in notifications we remove observer to clear ARC count like that we have to remove observer in order to decrease reference count. To overcome this RxSwift gives us a tool to deallocate memory automatically .i.e DisposableBag

- It is given in RxSwift to deal with ARC and memory management. This is a virtual “bag” of Observer objects which are disposed of when their parent object is deallocated.If object contains DisposableBag as a property, then it will automatically deallocate it.

- Without a DisposableBag, you’d get one of two results: either the Observer would create a retain cycle, hanging on to what it’s observing indefinitely, or it could get deallocated out from under your object, causing a crash.

- So it is better to use DisposableBag to cancel subscriptions.

  ```swift
  // Creating a DisposeBag so subscribtion will be cancelled correctly
  let bag = DisposeBag()
  
  // Creating an Observable Sequence that emits a String value
  let observable = Observable.just("Hello Rx!")
  
  // Creating a subscription just for next events
  let subscription2 = observable.subscribe (onNext:{
  	print($0)
  }).addDisposableTo(bag)
  ```

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


### [Error 처리](<https://brunch.co.kr/@tilltue/8>)

- 에러발생을 감지하는 catchError 메소드와 다시 정상적인 이벤트를 받기 위한 retry에 대해

  - catchError
  - catchErrorJustReturn

- 에러가 발생했을 때, onError로 종료되지 않도록 하고, 이벤트를 발생하고 onComplete될 수 있도록 한다

- 토끼 이벤트를 3번 발생하고 에러를 전달하는 observable을 생성했다

- catchError에서 에러를 받았지만, 단일 이벤트 observable 연산자인 just를 통해 Zoo Closed 이벤트를 전달하도록 했다

  ```swift
  let zoo = Observable<String>.create { observer in
  	for count in 1...3 {
  		observer.onNext("Rabbit\(count)")
  	}
  	let error = NSError(domain: "dummyError", code: 0, userInfo: nil)
  	observer.onError(error)
  	return Disposables.create {
  		print("dispose")
  	}
  }
  zoo.catchError { error -> Observable<String> in
  	return Observable.just("Zoo Closed")
  }.subscribe(onNext: { test in
  	print(test)
  }).disposed(by: disposeBag)
  ```

  ```
  Rabbit1
  Rabbit2
  Rabbit3
  Zoo Closed
  dispose
  ```

-  catchError 여러 이벤트 전달

  - catchError에서는 여러개의 이벤트를 보내줄 수도 있다
  - return Observable.of("Fox1", "Fox2", "Closed Zoo")

- catchErrorJustReturn

  - catchErrorJustReturn은 위와 같이 error가 발생했을 때 설정해둔 단일 이벤트를 전달하도록 하는 연산자이다

  - subscribe에서 에러를 감지하는 것이 아닌, Observable에서 에러에 대한 기본 이벤트를 설정하는 부분에 주목하자

  ```swift
  let zoo2 = Observable<String>.create { observer in
  	for count in 1...3 {
  		observer.onNext("Rabbit\(count)")
  	}
  	let error = NSError(domain: "dummyError", code: 0, userInfo: nil)
  	observer.onError(error)
  	return Disposables.create {
  		print("dispose")
  	}
  }.catchErrorJustReturn("Rabbit End")
  zoo2.subscribe(onNext: { test in
  	print(test)
  }).disposed(by: disposeBag)
  ```

  ```
  Rabbit1
  Rabbit2
  Rabbit3
  Rabbit End
  dispose
  ```

- Retry

  - retry()
  - retry(maxAttemptCount: Int)
  - 에러가 발생했을 때 성공을 기대하며 Observable을 다시 시도하는 연산자이다
  - (maxAttemptCount를 통해 재시도 횟수를 지정할 수 있다. 2로 지정하면 에러를 처리하고 다시 한 번 수행한다는 것이다. retry(2)가 재시도를 한 번 한다는 뜻)

  ```swift
  let zoo3 = Observable<String>.create { observer in
  	observer.onNext("TEST1")
  	observer.onNext("TEST2")
  	let error = NSError(domain: "dummyError", code: 0, userInfo: nil)
  	observer.onError(error)
  	return Disposables.create()
  }
  zoo3.debug().retry(2).subscribe { (event) in
  	print(event)
  }.disposed(by: disposeBag)
  ```

  ```
  2019-04-03 00:55:37.656: RxSwiftPractice.playground:13 (__lldb_expr_14) -> subscribed
  2019-04-03 00:55:37.669: RxSwiftPractice.playground:13 (__lldb_expr_14) -> Event next(TEST1)
  next(TEST1)
  2019-04-03 00:55:37.679: RxSwiftPractice.playground:13 (__lldb_expr_14) -> Event next(TEST2)
  next(TEST2)
  2019-04-03 00:55:37.680: RxSwiftPractice.playground:13 (__lldb_expr_14) -> Event error(Error Domain=dummyError Code=0 "(null)")
  2019-04-03 00:55:37.680: RxSwiftPractice.playground:13 (__lldb_expr_14) -> isDisposed
  ---
  2019-04-03 00:55:37.681: RxSwiftPractice.playground:13 (__lldb_expr_14) -> subscribed
  2019-04-03 00:55:37.681: RxSwiftPractice.playground:13 (__lldb_expr_14) -> Event next(TEST1)
  next(TEST1)
  2019-04-03 00:55:37.682: RxSwiftPractice.playground:13 (__lldb_expr_14) -> Event next(TEST2)
  next(TEST2)
  2019-04-03 00:55:37.683: RxSwiftPractice.playground:13 (__lldb_expr_14) -> Event error(Error Domain=dummyError Code=0 "(null)")
  2019-04-03 00:55:37.683: RxSwiftPractice.playground:13 (__lldb_expr_14) -> isDisposed
  error(Error Domain=dummyError Code=0 "(null)")
  ```

- retryWhen

  - retry하는 시점을 지정할 수 있다. 재시도는 한 번만 수행한다
  - 에러가 발생했을 때 retryWhen에서 지연시간을 가질 Observable을 지정하면, observable의 이벤트가 발생했을 때 다시 Observable의 시퀀스가 수행한다
  - retry와 이벤트 전달할 때 하나의 차이점이 error를 이벤트로 전달하지 않고, complete으로 종료된다

  ```swift
  let zoo4 = Observable<String>.create { observer in
  	observer.onNext("TEST1")
  	observer.onNext("TEST2")
  	let error = NSError(domain: "dummyError", code: 0, userInfo: nil)
  	observer.onError(error)
  	return Disposables.create()
  }
  zoo4.debug().retryWhen { (_) -> Observable<Int> in
  	return Observable<Int>.timer(3, scheduler: MainScheduler.asyncInstance)
  }.subscribe { (event) in
  	print(event)
  }.disposed(by: disposeBag)
  ```

  ```
  2019-04-03 00:57:35.310: RxSwiftPractice.playground:14 (__lldb_expr_16) -> subscribed
  2019-04-03 00:57:35.312: RxSwiftPractice.playground:14 (__lldb_expr_16) -> Event next(TEST1)
  next(TEST1)
  2019-04-03 00:57:35.314: RxSwiftPractice.playground:14 (__lldb_expr_16) -> Event next(TEST2)
  next(TEST2)
  2019-04-03 00:57:35.315: RxSwiftPractice.playground:14 (__lldb_expr_16) -> Event error(Error Domain=dummyError Code=0 "(null)")
  2019-04-03 00:57:35.315: RxSwiftPractice.playground:14 (__lldb_expr_16) -> isDisposed
  ---
  2019-04-03 00:57:38.311: RxSwiftPractice.playground:14 (__lldb_expr_16) -> subscribed
  2019-04-03 00:57:38.311: RxSwiftPractice.playground:14 (__lldb_expr_16) -> Event next(TEST1)
  next(TEST1)
  2019-04-03 00:57:38.312: RxSwiftPractice.playground:14 (__lldb_expr_16) -> Event next(TEST2)
  next(TEST2)
  2019-04-03 00:57:38.312: RxSwiftPractice.playground:14 (__lldb_expr_16) -> Event error(Error Domain=dummyError Code=0 "(null)")
  2019-04-03 00:57:38.312: RxSwiftPractice.playground:14 (__lldb_expr_16) -> isDisposed
  completed
  
  ```

- Timeout

  - 이벤트가 일정시간동안 발생하지 않으면 오류를 발생시킨다

  ```swift
  let timer = Observable<Int>.create { observer in
  	let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
  	timer.schedule(deadline: DispatchTime.now() + 1, repeating: 1)
  	let cancel = Disposables.create {
  		timer.cancel()
  	}
  	var next = 0
  	timer.setEventHandler {
  		if cancel.isDisposed {
  			return
  		}
  		if next < 3 {
  			observer.onNext(next)
  			next += 1
  		}
  	}
  	timer.resume()
  	return cancel
  }
  
  timer.debug().timeout(2, scheduler: MainScheduler.instance).subscribe().disposed(by: disposeBag)
  ```

  ```
  2019-04-03 00:59:28.188: RxSwiftPractice.playground:43 (__lldb_expr_18) -> subscribed
  2019-04-03 00:59:29.190: RxSwiftPractice.playground:43 (__lldb_expr_18) -> Event next(0)
  2019-04-03 00:59:30.190: RxSwiftPractice.playground:43 (__lldb_expr_18) -> Event next(1)
  2019-04-03 00:59:31.189: RxSwiftPractice.playground:43 (__lldb_expr_18) -> Event next(2)
  Unhandled error happened: Sequence timeout.
   subscription called from:
  
  2019-04-03 00:59:33.190: RxSwiftPractice.playground:43 (__lldb_expr_18) -> isDisposed
  ```

### [Just](<http://reactivex.io/documentation/ko/operators/just.html>)

- The Just operator converts an item into an Observable that emits that item.

  Just is similar to From, but note that From will dive into an array or an iterable or something of that sort to pull out items to emit, while Just will simply emit the array or iterable or what-have-you as it is, unchanged, as a single item.

  Note that if you pass `null` to Just, it will return an Observable that *emits* `null` as an item. Do not make the mistake of assuming that this will return an empty Observable (one that emits no items at all). For that, you will need the [Empty](http://reactivex.io/documentation/ko/operators/empty-never-throw.html) operator.

- 