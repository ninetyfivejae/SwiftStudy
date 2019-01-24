//
//  ViewController.swift
//  Practice
//
//  Created by 신재혁 on 07/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //UITextViewDelegate를 프로토콜을 준수하여 (Document 참고) UITextView와 communicate
    @IBOutlet weak var myUITextView: UITextView!
    @IBOutlet weak var myUILabel: UILabel!
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var dataTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    //Outlet collection으로 생성하여 버튼들을 배열로 사용
    @IBOutlet var optionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myUITextView에 delegate function들을 적용시키기 위해
        self.myUITextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.userNameField.delegate = self
        self.passwordField.delegate = self
        self.phoneNumberField.delegate = self
        
        //outlet collection 버튼 배열을 순회하여 색 변경
        for button in optionButtons {
            button.setTitleColor(UIColor.red, for: .normal)
        }
        
        print("1st viewDidload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("1st viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("1st viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("1st viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("1st viewDidDisappear")
    }
    
    //키보드 사라지게 하기위해서 touchesBegan func override를 해서 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // 모든 UITextView에 적용하고 싶은 경우
        //self.myUITextView.resignFirstResponder() //특정 UITextView에만 적용하고 싶은 경우
        //self.userNameField.resignFirstResponder()
        //self.passwordField.resignFirstResponder()
    }
    
    //UITextViewDelegate protocol optional methods
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
        myUILabel.text = "\(myUITextView.text.count)"

        return textView.text.count + (text.count - range.length) <= 100
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Editing is about to begin")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.green
        print("Editing is began")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Editing is about to end")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Editing ended")
        textField.backgroundColor = UIColor.white
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        dataTextView.text = "Username: \(userNameField.text!)\nPassword: \(passwordField.text!)\nPhone Number: \(phoneNumberField.text!)"
        
        self.performSegue(withIdentifier: "ThirdVCSegue", sender: nil)
    }
    
    @IBAction func triggerOption(_ sender: Any) {
        //ViewController 오른쪽 마우스로 클릭 후 ReceivedActions에서 버튼 이벤트로 touchup inside 연결을 시켜줌
        //option 버튼 마다 tag를 설정해줘서 tag로 구별. text내용으로 구별도 가능
        let button = sender as! UIButton
        
        if button.titleLabel?.text == "Option1" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let secondVC = sb.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController {
                secondVC.infoObject = "[Present]: Hello, World!"
                self.present(secondVC, animated: true, completion: nil)
                //secondVC.informationLabel.text = "Hello, World!"
            }
        } else if button.tag == 2 {
            print("Option2 pressed")
        } else if button.tag == 3 {
            print("Option3 pressed")
        }
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
    
    //이 메소드가 있어야 unwind를 할 수 있게 exit 설정해줄 수 있다
    @IBAction func prepareForUnwind (segue: UIStoryboardSegue) {
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let segue = CustomUnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
}

//extension ViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
