# Delegate

- https://zeddios.tistory.com/8?category=682195

- 프로토콜은 서로간의 지켜야할 규약

- Delegate는 대리자 라는 뜻. 너가 해야할 일을 내가 해서 줄게

- swift에서 기존의 버튼이나 텍스트필드, 라벨 등의 객체들은 고유의 특징을 가지는데

  - 버튼은 누르면 동작
  - 텍스트필드는 글자를 입력할 수 있도록 해줌
  - 라벨은 글자 내용을 출력
  - 등등

- 델리게이트 패턴은 쉽게 말해서, 객체 지향 프로그래밍에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리 해야 할 일 중 일부를 다른 객체에 넘기는 것을 뜻함

- 가령, textField의 기능에는 명시 안하고, textField를 가진 뷰 컨트롤러에 명시

- viewDidLoad()함수에 textField.delegate = self 를 추가하면, delegate가 누구인지 명시하는 것임. textField의 뒷바라지는 내가 할게라는 의미. self라고 명시했기 때문에 현재클래스인 ViewController가 된다

- UITextFieldDelegate 프로토콜을 채택하여, textFieldShouldReturn(UITextFieldDelegate 안에 정의되어있는 함수)에 하고싶은 일을 구현만 하면 된다

- ```swift
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          enteredLabel.text = textField.text
          return true
  }
  ```

- @IBAction 클릭함수 대신에 처리할 함수를 구현한 것임

### Delegate 사용 데이터 전달 - 기본 예제

- 기본 ViewController 간의 Delegate 사용 데이터 전달

  - protocol

    ```swift
    protocol SendDataDelegate {
        func changeLabelText(to: String)
    }
    ```

  - Receiver

    ```swift
    import UIKit
    
    class ReceiverViewController: UIViewController {
    
        @IBOutlet weak var receiverLabel: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "PassDataVC"{
                let senderViewController = segue.destination as! SenderViewController
                senderViewController.delegate = self
            }
        }
    }
    
    extension ReceiverViewController: SendDataDelegate {
        func changeLabelText(to: String) {
            receiverLabel.text = to
        }
    }
    ```

  - Sender

    ```swift
    import UIKit
    
    class SenderViewController: UIViewController {
    
        @IBOutlet weak var senderTextField: UITextField!
        
        var delegate: SendDataDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        @IBAction func senderButton(_ sender: Any) {
            if let data = senderTextField.text {
                delegate?.changeLabelText(to: data)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    ```

- TableViewController에서 Delegate 사용 데이터 전달

  - protocol

    ```swift
    protocol SaveDataDelegate: class {
        func saveData(data saveData:[String:String])
    }
    ```

  - Receiver

    ```swift
    class TableViewController: UIViewController, UITableViewDataSource, SaveDataDelegate {
        @IBOutlet weak var friendListTableView: UITableView!
        
        private var friendList = [[String:String]]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
    
            friendListTableView.dataSource = self
            
            self.friendListTableView.rowHeight = UITableView.automaticDimension
            self.friendListTableView.estimatedRowHeight = 40
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return friendList.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
                cell.textLabel?.text = friendList[indexPath.row]["name"]
                cell.detailTextLabel?.text = friendList[indexPath.row]["phone"]
                return cell
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! SenderTableViewController
            destination.delegate = self
        }
        
        func saveData(data saveData: [String : String]) {
            friendList.append(saveData)
            friendListTableView.reloadData()
        }   
    }
    ```

  - Sender

    ```swift
    class SenderTableViewController: UIViewController {
        @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var phoneTextField: UITextField!
        
        weak var delegate: SaveDataDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        @IBAction func addButtonTapped(_ sender: Any) {
            var data = [String:String]()
            data["name"] = nameTextField.text!
            data["phone"] = phoneTextField.text!
            delegate?.saveData(data: data)
            self.navigationController?.popViewController(animated: true)
        }
    }
    ```

### Delegate 사용 데이터 전달 - <질문>

- TabBarController에 포함된 ViewController마다 Delegate를 사용하여 데이터 전달하려고 하는데 동작하지 않았습니다 ==> **ViewController들을 포함하는 상위 TabBarController에서 대리자 설정을 해주던가, prepare함수가 혹시나 호출되는지도 확인해볼 것**

  - Protocol

    ```swift
    protocol ButtonPressed {
        func changeLabelText(to: String)
    }
    ```

  - Receiver

    ```swift
    class FirstReceiverViewController: UIViewController {
        
        @IBOutlet weak var firstReceiverLabel: UILabel!
        
        var secondSenderViewController: SecondSenderViewController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
    
            secondSenderViewController?.delegate = self
        }
    }
    
    extension FirstReceiverViewController: ButtonPressed {
        func changeLabelText(to: String) {
            firstReceiverLabel.text = to
        }
    }
    ```

  - Sender

    ```swift
    class SecondSenderViewController: UIViewController {
        
        @IBOutlet weak var secondSenderTextField: UITextField!
        
        var delegate: ButtonPressed?
        
        override func viewDidLoad() {
            super.viewDidLoad() 
        }
        
        @IBAction func secondSenderButtonTapped(_ sender: Any) {
            if let text = secondSenderTextField.text {
                delegate?.changeLabelText(to: text)
            }
        }
    }
    ```

- 참고

  - [ViewController간 Delegate이용 데이터 전달](https://zeddios.tistory.com/310)
  - [테이블뷰에서의 Delegate이용 데이터 전달](https://baked-corn.tistory.com/44)
  - [객체간 소통, callback, notification, delegate](https://m.blog.naver.com/PostView.nhn?blogId=jdub7138&logNo=220937372865&proxyReferer=https%3A%2F%2Fwww.google.com%2F)

