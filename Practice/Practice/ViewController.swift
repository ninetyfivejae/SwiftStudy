//
//  ViewController.swift
//  Practice
//
//  Created by 신재혁 on 07/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

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
    
    @IBAction func controlMyUITextField(_ sender: UITextField) {
        
    }
    
    @IBAction func controlMyUIButton(_ sender: UIButton) {
        
    }
    
}
