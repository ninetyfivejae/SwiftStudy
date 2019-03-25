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

- 