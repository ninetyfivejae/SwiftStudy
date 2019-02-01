//
//  ReceiverViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class ReceiverViewController: UIViewController {

    @IBOutlet weak var receiverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //스토리보드에서 segue 생성 후 identifier마다 작업 구현하는 방법
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassDataVC"{
            let senderViewController = segue.destination as! SenderViewController
            senderViewController.delegate = self
        }
    }
    
    //스토리보드 id를 가지고 다음에 띄울 view controller를 present하는 방법
    @IBAction func nextButtonTapped(_ sender: Any) {
        let senderViewController = storyboard?.instantiateViewController(withIdentifier: "SenderViewController") as! SenderViewController
        
        senderViewController.delegate = self
        
        present(senderViewController, animated: true, completion: nil)
    }
}

extension ReceiverViewController: SendDataDelegate {
    func changeLabelText(to: String) {
        receiverLabel.text = to
    }
}
