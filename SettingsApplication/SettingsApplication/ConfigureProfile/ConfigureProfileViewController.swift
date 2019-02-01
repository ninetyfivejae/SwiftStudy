//
//  ViewController.swift
//  SettingsApplication
//
//  Created by 신재혁 on 25/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class ConfigureProfileViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var configureProfileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var profileImage: UIImage?
    var profileName: String?
    var profileImageURL: URL?
    
    var updateDelegate: UpdateDelegate?

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate 채택 및 UIImagePickerController 인스턴스 생성
        picker.delegate = self
        
        setLastState()
        
        //configureProfileView 원형으로 변경
        self.configureProfileView.layer.cornerRadius = self.configureProfileView.frame.size.width / 2;
        self.configureProfileView.clipsToBounds = true;
        
        //UIView에 TapGesture 추가
        var tapGesture = UITapGestureRecognizer()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ConfigureProfileViewController.configureProfileViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        configureProfileView.addGestureRecognizer(tapGesture)
        configureProfileView.isUserInteractionEnabled = true
    }
    
    //키보드 사라지게 하기위해서 touchesBegan func override를 해서 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 모든 UITextView에 적용하고 싶은 경우
        self.view.endEditing(true)
        //특정 UITextView에만 적용하고 싶은 경우
        //self.nameTextField.resignFirstResponder()
    }
    
    //@objc 속성을 붙여주는 이유와 괜찮은지
    @objc func configureProfileViewTapped(_ sender: UIGestureRecognizer) {
        if (sender.state == .ended) {
            let optionMenu = UIAlertController(title: nil, message: "프로필 사진 선택", preferredStyle: .actionSheet)
            
            let takePhoto = UIAlertAction(title: "사진 찍기", style: .default) { (action) in
                self.openCamera()
            }
            let selectPhoto = UIAlertAction(title: "사진 선택", style: .default) { (action) in
                self.openLibrary()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            optionMenu.addAction(takePhoto)
            optionMenu.addAction(selectPhoto)
            optionMenu.addAction(cancel)
            
            self.present(optionMenu, animated: true, completion: nil)
        }
    }

    //Privacy - Photo Library Usage Description(사진앨범 권한), Privacy - Camera Usage Description(카메라 권한)을 info.plist에 추가해줘야함
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }

    @IBAction func cancelAction(_ sender: Any) {
        //키보드 먼저 내리기 위해서 dismiss 이전에 호출
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        //키보드 먼저 내리기 위해서 dismiss 이전에 호출
        self.view.endEditing(true)
        //변경사항 저장 후
        saveCurrentState()
        //메인 테이블뷰의 프로필셀 변경
        updateDelegate?.updateProfile()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setLastState() {
        if let imageURL = UserDefaults.standard.url(forKey: "currentProfileImage") {
            profileImage = UIImage(url: imageURL)
        } else {
            profileImage = UIImage(named: ImageName.defaultProfileImage.rawValue)
        }
        
        if let name = UserDefaults.standard.string(forKey: "currentProfileName") {
            profileName = name
        } else {
            profileName = "이름 지정하지 않음"
        }

        profileImageView.image = profileImage
        nameTextField.text = profileName
    }
    
    func saveCurrentState() {
        if profileImageURL == nil {
            profileImageURL = UserDefaults.standard.url(forKey: "currentProfileImage")
        }

        UserDefaults.standard.set(profileImageURL, forKey: "currentProfileImage")
        UserDefaults.standard.set(nameTextField.text, forKey: "currentProfileName")
        //synchronize가 호출되지 못하는 비정상적인 상황 대비해서 바로 메모리의 내용을 파일로 동기화
        UserDefaults.standard.synchronize()
    }
}

//위에서 한꺼번에 ViewController에서 채택할 수도 있지만, Swift 컨벤션에 따르면 Delegate 채택작업은 extension으로 빼는게 좋다고 함.
extension ConfigureProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            profileImageURL = imgUrl
        }

        dismiss(animated: true, completion: nil)
    }
}

extension UIImage {
    public convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
