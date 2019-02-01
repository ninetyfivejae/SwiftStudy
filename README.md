# SwiftStudy

## 예습

- [SwiftBasicExamples](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/SwiftBasicExamples.md#swiftbasicexamples)
- [Flashlight App](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/FlashlightApp.md#flashlight-app)

## En#SwiftStudy

- 스터디 방식

  - 과제
    - 각자 분야 조사 및 공부, 정리해와서 설명해주기(내 분야가 아닌건 그날 스터디 종료 후 바로 설명들은거로 공부하기)
    - 각자 10분씩 총 30분 서로 설명해주고, 나머지 30분은 상욱이형이 추가적으로 부족한 부분 설명하고 실습 진행으로 2~3시간씩 스터디 진행
    - 다음 스터디 일정은 바로 전주에 만나서 정하는걸로하고, 내가 먼저 장소 프로젝트 가능한 곳으로 괜찮은데 알아봐야함
    - 3주차때는 형 여행가니까 평일에 금요일이나 월요일 중으로 만나서 하는걸로

- 일정

  ```
  1주차 - Swift에서 타입이란
  - 상수와 변수
  - 함수 정의 및 사용법
  - Property(Stored, Computed, Class)
  - 콜렉션(Array, Dictionary, Set)
  - Class / Struct / Enum
  - Optional / Optional Binding
  
  실습
  - Calculate 클래스 만들어보기
  
  2주차 - UIKit 사용해보기
  - 스토리보드
  - Frame, Bounds
  - Autolayout
  - UILabel
  - UIButton
  - UITextview
  - UITextField
  실습
  - Autolayout 실습
  - UIResponder, User Interaction
  - 버튼 동작해보기
  
  3주차 - POP 개요
  - 상속에 관한 이야기
  - Protocol 과 Extension
  - 타입 캐스팅
  - 제네릭 개요
  + Swift 기본 패턴
  - Delegate
  - KVO
  
  실습
  - UITableView, UICollectionView
  - UINavigation 및 화면 transition
  
  4주차 - 클로저와 ARC
  - Closure
  - 고차함수(Map, Filter, Reduce)
  - Generic
  
  + ARC
  
  실습
  - Array 확장해보기(제네릭 사용)
  - ARC
  - 순환참조 해결하기
  
  5주차 ~ 8주차 - 미니 프로젝트 선정 및 진행해보기
  - 사진 앨범 or 미니 Todo 앱
  ```

## 추가 정리

### SettingsApplication 과제 하면서 깨달은 것들 정리

- 이미지 설정할 때, 이미지 리터럴로 지정하는 것은 나중에 코드 가독성을 안 좋게 하거나 수정시 혼란을 가져올 수 있으니 안 좋을 수도 있다

  ```swift
  //profileImageView.image = #imageLiteral(resourceName: "defaultProfileImage")
  profileImageView.image = UIImage(named: "defaultProfileImage")
  ```

- **TableView Cell 클릭시 하이라이트 계속 남아있는 에러 수정**

  - 먼저, 스토리보드에서 selection 스타일 none으로 설정

  - 선택 시 하이라이트 설정을 하고 싶은 Cell(ProfileTableViewCell 및 SettingsTableViewCell) 코드에서 setHighlighted 메소드 오버라이드 하여 구현

    ```swift
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            if highlighted {
                self.backgroundColor = UIColor.hexStringToUIColor(hex: "#7DB9CA")
            } else {
                self.backgroundColor = .white
            }
        }
    ```

- **16진수 컬러코드 사용해서 UIColor 생성**

  - UIColor를 RGB 수치를 이용해 생성 할 때는 아래와 같은 생성자를 이용 할 수 있지만, 이 생성자를 이용 할 경우 웹에서 쓰이는 16진수 컬러코드를 그대로 사용 할 수가 없다. 

  - 각 컬러 컴포넌트는 실수형, 즉 0.0이 최소이고 1.0이 최대이기 때문에 16진수로 1바이트로 표현하는 정수형 타입을 그대로 넣을 수가 없기 때문이다.

    ```swift
    UIColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    ```

  - 그래서 extension으로 UIColor에 이니셜라이저 추가해서 사용해준다

    ```swift
    extension UIColor {
        convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
            var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
    
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
    
            if ((cString.count) == 6) {
                Scanner(string: cString).scanHexInt32(&rgbValue)
            }
    
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
        }
    }
    ```

    ```swift
    let myColor = UIColor(hexFromString: "4F9BF5")
    let myColor = UIColor(hexFromString: "#4F9BF5")
    let myColor = UIColor(hexFromString: "#4F9BF5", alpha: 0.5)
    ```

  - 다른 방법으로도 사용 가능하니 적절하게 구현하여 사용하면 된다

    ```swift
    extension UIColor {
        class func hexStringToUIColor(hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
    ```

    ```swift
    self.backgroundColor = UIColor.hexStringToUIColor(hex: "#7DB9CA")
    ```

  - [출처](https://code.i-harness.com/ko-kr/q/172395f)

- **UserDefaults**

  - UserDefaults (Objective-C 에서는 NSUserDefaults) 는 대체로 앱의 설정 값을 저장하고 나중에 읽기 위한 용도로 사용된다. 별도의 파일이나 데이터베이스 엑세스 없이 쓸 수 있다.

  - UserDefaults는 KeyValue 스타일 Dictionary와 비슷한 클래스인데, 여기다 파일에 기록하고 나중에 불러올 수 있는 기능까지 제공한다.

  - 대체로 standard 라는 이름의 싱글톤을 이용해 데이터에 접근하기 때문에 UserDefaults 자체를 인스턴스화하는 일은 거의 없을 것이라고 함.

  - **값 저장**

    - value의 타입이 Swift 에서 제공되는 기본 타입이라면 왠만하면 별 다른 추가작업 없이 데이터가 저장됨

    - 참고로, nil 값을 저장하면 해당 데이터를 지우는 것과 동일한 효과이기 때문에 필요없다면 nil 을 넣으면 된다.

    - 두번째 줄의 synchronize() 메소드는 UserDefaults 에 기록된 값을 파일에 쓰는 역할. 

      - 여러 값을 변경할 경우 매번 synchronize() 를 호출할 필요 없이 다 쓰고 난 다음에 마지막에 딱 한번만 synchronize()를 호출하면 된다.
      - 만약 synchronize() 를 호출하지 않은채로 앱을 종료하더라도 UserDefaults 자체는 특정 인터벌이나 클래스 deinit 시를 기준으로 synchronize() 를 알아서 호출한다.
      - 근데 주의할 점은 synchronize가 호출되지 못하는 비정상적인 상황이 생길 수 있기 때문에 아래와 같이 동기화 코드를 추가한다

      ```swift
      UserDefaults.standard.set(value, forKey: "Some Key Name")
      UserDefaults.synchronize()
      ```

  - **값 읽기**

    - 원래 데이터의 타입과 관계없이 호출하는 경우, 타입 캐스팅을 해줘야함

      ```swift
      let value = UserDefaults.standard.object(forKey: "Some Key Name") as? String
      ```

    - 타입 명시해서 호출하는 경우

      ```swift
      let value = UserDefaults.standard.string(forKey: "Some Key Name")
      ```

  - **복잡한 데이터의 경우**

    - 콜렉션 타입은 들어가게 되는 아이템의 타입에 종속적이지 않다보니 쉽게 기록하거나 읽을 수 없다.
    - 대신 NSKeyedArchiver 나 NSKeyedUnarchiver 를 이용해 Data(NSData) 형식으로 인코딩한 후 기록하고나 디코딩해서 읽을 수 있다.

    - 기본적인 사전형 데이터를 UserDefaults 에 쓰기 위한 예제

      ```swift
      let data = NSKeyedArchiver.archivedData(withRootObject: someDictionary)
      UserDefaults.standard.set(data, forKey: "Some Dictionary Data")
      ```

      ```swift
      if let data = UserDefaults.standard.object(forKey: "Some Dictionary Data") as? Data {
        let someDictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [AnyHashable : Any]
      }
      ```

    - 반대로 읽을 때는 읽은 데이터에서 언아카이버로 디코딩을 해야함.
    - 두 단계로 나눠서 읽거나 써야하는 만큼 귀찮아 지긴 하지만 콜렉션 타입의 경우 내부에 들어오는 타입을 명확히 알기가 힘든 경우가 있으므로 종종 이용해야 할 수 있다.

  - **UserDefaults의 내용 저장 위치**

    - UserDefaults의 내용은 plist 형식의 파일로 저장되며 저장되는 위치는 OS에 따라 다르다.

    - macOS 의 경우 아래의 디렉토리를 보면, 앱의 번들아이디(Bundle Identifier) 디렉토리를 찾아서 들어가보면 plist 파일을 발견할 수 있는데 바로 이 파일이다. 내용을 보며 알겠지만, UserDefaults 를 통해 저장한 내용 뿐만 아니라 인터페이스 빌더 등에서 이용하는 AutoSave 항목들도 여기에 저장되는 등 여러가지 앱의 정보가 기록된다.

      ```swift
      /Users/사용자이름/Library/Preferences/
      ```

    - iOS Simulator의 경우 우선 아래 디렉토리를 들어가보면, 앱의 GUID 에 해당하는 값을 이름으로 하는 디렉토리가 잔뜩 있는데 여기서 원하는 것을 찾아서 해당 디렉토리에 들어간 다음 Library/Preferences/를 찾아보면 plist파일이 있다

      ```swift
      /Users/사용자이름/Library/Application Support/iPhone Simulator/버전/Applications
      ```

  - **성능 이슈(Performance Issues)**

    - UserDefaults 는 기본적으로 메모리 상에서 메모리 캐싱을 한다.
    - 읽을 때 plist 에서 내용을 읽은 다음 메모리 상에 저장하고 다음에 동일한 키의 데이터를 읽으려고 하면 파일이 아니라 메모리의 내용을 돌려준다. 따라서 막 읽는다고 해서 파일 엑세스를 통한 퍼포먼스 저하 문제는 딱히 걱정하지 않아도 된다.
    - 쓰기의 경우에는 synchronize() 메소드를 호출해야 메모리의 내용이 파일로 동기화되니 그 이전에는 역시 퍼포먼스 문제를 걱정할 필요는 없다. 대신 synchronize() 가 호출되지 못 하는 비정상적인 상황 때문에 데이터를 잃어버리는 경우가 있다는 것을 인지하면 된다

  - [출처](http://seorenn.blogspot.com/2017/01/userdefaults-nsuserdefaults.html)

  - [참고: UIColor와 같은 지원되지 않는 타입을 저장하기 위해 UserDefaults extension으로 추가하는 방법](https://www.bobthedeveloper.io/blog/store-uicolor-with-userdefaults-in-swift)

- UIImage의 URL 가져오기, URL을 통해서 UIImage 다시 생성하기 ==>

  - UIImage를 UserDefaults에 굳이 저장을 할 수 있게 extension으로 구현할 수 있지만, 그러면 이미지 사이즈가 크면 앱이 느려지거나 터지는 경우가 생겨서, UIImage의 URL을 저장하는 방법으로 구현함

  - [URL 타입이 UserDefaults에 저장가능했음](https://developer.apple.com/documentation/foundation/userdefaults/1408648-url)

    ```swift
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
    ```

    ```swift
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
    ```

  - [참고1](https://medium.com/swiftly-swift/the-secret-of-storing-and-loading-uiimage-s-48e94d080c8d)

  - [참고2](https://rasukarusan.hatenablog.com/entry/2019/01/07/233207)

- **키보드 사라지는 타이밍 이슈**

  - 프로필 수정 후 MainTableViewController로 이동할 때 먼저 수정 화면이 사라지고 키보드가 나중에 사라지는 이슈
  - 화면 dismiss 이전에 self.view.endEditing(true) 코드 추가해서 해결

- **UITableView Section Header에 button 추가 / 새로운 Cell 추가 후 reloadData**

  - http://swiftquickstart.blogspot.com/2016/10/custom-tableview-section-headers.html

  - https://www.codevscolor.com/ios-create-button-programmatically/

    ```swift
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIButton? {
        if section == 2 {
            let button = UIButton(type: .system)
            button.setTitle("친구 추가", for: .normal)
            button.tintColor = .black
            button.backgroundColor = UIColor(hexFromString: "7DB9CA")
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    
            return button
        } else {
            return nil
        }
    }
    
    @objc func buttonClicked(sender : UIButton){
        items[2].append("test")
    
        self.tableView.reloadData()
    }
    ```

- [Dealing with magic number / magic string](https://www.bignerdranch.com/blog/using-swift-enumerations-makes-segues-safer/)

  - Using Swift Enumerations Makes Segues Safer

  - 프로젝트 세그웨이에 적용한 결과

    ```swift
    enum SegueIdentifier: String {
        case configureProfileSegue = "ProfileSegue"
        case adjustSettingsSegue = "AdjustSegue"
    }
    ```

    ```swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        guard let identifier = segue.identifier,
        let identifierCase = SegueIdentifier(rawValue: identifier) else {
            return
        }
    
        switch identifierCase {
            case .configureProfileSegue:
            if let profileVC = segue.destination as? ConfigureProfileViewController {
                //넘어가기 전 설정
                profileVC.updateDelegate = self
            }
            case .adjustSettingsSegue:
            if let adjustVC = segue.destination as? AdjustSettingsViewController {
                //넘어가기 전 설정
                settingsDelegate = adjustVC
            }
        }
    }
    ```

- 

### 미해결 이슈

- 프로필 셀 터치 후 present modally 한 번에 안 넘어갈 때 있음. 여러번 그런다

- 잘되는데, 앱 깔린 상태에서 다시 빌드하면 이전 저장된 이미지를 못 가져온다. 아래처럼 에러를 출력함

  ```
  Error : The file “F34D4E68-BBA6-48FC-A098-8A44143A2C3E.jpeg” couldn’t be opened because there is no such file.
  ```

- [프로필 이미지, 프로필 이름] ==> 구조체 리스트로 관리하기

