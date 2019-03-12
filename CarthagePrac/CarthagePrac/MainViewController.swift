//
//  MainViewController.swift
//  CarthagePrac
//
//  Created by 신재혁 on 12/03/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

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
