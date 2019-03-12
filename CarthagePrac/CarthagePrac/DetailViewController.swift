//
//  DetailViewController.swift
//  CarthagePrac
//
//  Created by 신재혁 on 12/03/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

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
