# UIViewControllers

## UITableView

1. ViewController에 TableView를 얹은 다음, UITableViewDelegate와 UITableViewDatasource 프로토콜을 채택하여 구현하는 방법

   - 스토리보드의 테이블뷰를 코드로 끌어와서 IBOutlet 프로퍼티로 지정해야함

   - ViewController 클래스가 UITableViewDelegate/Datasource 프로토콜을 준수해야함

   - 테이블뷰의 delegate, datasource가 ViewController 자신(self)임을 지정해야함

     - 저번시간 예제 코드

     ```swift
     import UIKit
     
     class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
         @IBOutlet weak var tableView: UITableView!
         
         var models: [Person] = [Person(profile: "Blah Blah", name: "Name 1", age: Int.random(in: 1...100), description: String.randomString()]
         
         override func viewDidLoad() {
             super.viewDidLoad()
             self.tableView.delegate = self
             self.tableView.dataSource = self
             
             //테이블뷰의 높이를 내용에 맞게 제각각으로 설정
             self.tableView.rowHeight = UITableView.automaticDimension
             self.tableView.estimatedRowHeight = 20
         }
         
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             //모델 배열에 있는 Person 객체만큼 section 생성
             return self.models.count
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             //CustomTableViewCell로 타입 변경하여 가져옴
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
                 return UITableViewCell()
             }
             
             cell.profileImageView.backgroundColor = .green
             cell.nameLabel.text = self.models[indexPath.row].name
             cell.ageLabel.text = String(self.models[indexPath.row].age)
             cell.descriptionLabel.text = self.models[indexPath.row].description
             
             return cell
         }
     }
     ...
     ```

2. 스토리보드에서 TableViewController와 새로 만든 UITableViewController 클래스를 연결시키는 방법

   - 스토리보드의 테이블뷰와 연결된 tableView 프로퍼티가 기본적으로 제공됨

   - 해당 TableViewController를 UITableViewController 클래스에 연결하면 delegate, datasource 자동으로 지정된다

     ```swift
     import UIKit
     
     class TableViewController: UITableViewController {
         
         @IBOutlet weak var numberOfObjectsLabel: UILabel!
         
         var data = ["First", "Second", "Third"]
     
         override func viewDidLoad() {
             super.viewDidLoad()
             
             numberOfObjectsLabel.text = "\(data.count)"
         }
     
         override func numberOfSections(in tableView: UITableView) -> Int {
             return 1
         }
     
         override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return data.count
         }
     
         override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
             let selectedItem = data[indexPath.row]
             print("Item \(selectedItem) selected")
         }
         
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
                 return UITableViewCell()
             }
             
             let cellData = data[indexPath.row]
             cell.customTextField.text = cellData
             print("Function call \(indexPath)")
     
             return cell
         }
     }
     ```

- override func tableView(_ tableView: UITableView, **cellForRowAt** indexPath: IndexPath) -> UITableViewCell {...}
  - 이 함수가 몇 번 호출되는지 확인해보면, **테이블뷰의 셀 갯수만큼 호출**이 되는 것을 알 수 있음
  - **또 화면에서 사라졌다가 다시 화면으로 셀이 보이게 되면 그때 다시 호출이 된다**
  - indexPath는 [section, row]로 이루어져 있는 행을 식별하는 상대적인 경로이다

### dequeueReusableCell 사용 이유

- dequeueReusableCell(withIdentifier:for:): Returns a reusable table-view cell object for the specified reuse identifier(TableViewCell의 identifier) and adds it to the table.
- 천 개, 만 개 이상의 항목(엔트리)을 가지는 테이블이 있을 때, 천 개의 엔트리를 셀마다 만들고 모든 테이블 뷰 셀에 대해 메모리 할당이 이루어지게된다. 이렇게 되면 메모리 낭비가 되기 때문에 효과적으로 메모리를 사용하기 위해서 dequeueReusableCell 사용한다.
- 이 dequeueReusableCell을 사용하게 되면 화면에서 보이는 테이블 뷰 셀만 메모리에 할당하면 된다. 그리고 스크롤하면 화면에는 여전히 동일한 셀이 사용되지만, 데이터소스(DataSource)를 기반으로 셀 내용이 바뀌게 된다. 셀이 스크롤 화면 밖으로 밀려나면, 이 셀은 reuse pool에 들어가게 되고, 우리가 dequeueReusableCell을 호출할 때 테이블 셀에 의해 반환이 된다.
- [Cell 재사용하는 경우와 그렇지 않은 경우 메모리 비교](https://medium.com/ios-seminar/why-we-use-dequeuereusablecellwithidentifier-ce7fd97cde8e)

### Cell 재사용 시 주의사항

- 말 그대로 Cell을 재사용하는 것이기 때문에 **이전에 사용하고 남은 흔적들**이 있을 수 있다.

- 이와 같은 문제를 방지하기 위해서는 **재사용될 때 속성 값이 초기화가 되어야한다**

- ![prepareForReuseImage](https://github.com/ninetyfivejae/SwiftStudy/blob/master/Image/prepareReuseImage.png?raw=true)

- func tableView(**_** tableView: UITableView, cellForRowAt indexPath: IndexPath) 메소드는 Cell이 화면에 보여질 때마다 호출이 되는데, cell 재사용시 cell 객체가 재사용 가능하면 이 메소드 전에 prepareForReuse라는 메소드가 호출된다.

- 그래서 prepareForReuse 메소드에 cell 속성들을 재설정해주면 된다

  - If a `UITableViewCell` object is reusable, prepareForReuse method is invoked just before the object is returned from the `UITableView` method [`dequeueReusableCell(withIdentifier:)`](https://developer.apple.com/documentation/uikit/uitableview/1614891-dequeuereusablecell).
  - For performance reasons, you should only reset attributes of the cell that are not related to content, for example, alpha, editing, and selection state.
  - The table view's delegate in [`tableView(_:cellForRowAt:)`](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614861-tableview) should *always* reset all content when reusing a cell. If the cell object does not have an associated reuse identifier, this method is not called. If you override this method, you must be sure to invoke the superclass implementation.

  ```swift
  import UIKit
  
  class CustomTableViewCell: UITableViewCell {
  
      @IBOutlet weak var customTextField: UITextField!
      @IBOutlet weak var taskLabel: UILabel!
      @IBOutlet weak var checkLabel: UILabel!
      
      override func awakeFromNib() {
          super.awakeFromNib()
      }
  
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
      }
      
      override func prepareForReuse() {
          super.prepareForReuse()
          
          //Cell 초기화해주는 코드
          self.checkLabel.isHidden = false
      }
  }
  ```

- 출처: https://fluffy.es/solve-duplicated-cells/

## UICollectionView

- UITableView와 비슷함

  ```swift
  import UIKit
  
  private let reuseIdentifier = "Cell"
  
  class CollectionViewController: UICollectionViewController {
      
      var collectionData = ["1 🐶", "2 🐱", "3 🐭", "4 🐹", "5 🐰", "6 🦊", "7 🐻", "8 🐼", "9 🐨", "10 🐯"]
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      }
  
      override func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
  
      override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 100
      }
  
      override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionViewCell else {
              return UICollectionViewCell()
          }
          
          cell.customNameLabel.text = "✅"
  
          if indexPath.row % 2 == 0 {
              cell.customNameLabel.isHidden = true
          }
      
          return cell
      }
  }
  ```

  ```swift
  class CustomCollectionViewCell: UICollectionViewCell {
      
      @IBOutlet weak var customImageView: UIImageView!
      @IBOutlet weak var customNameLabel: UILabel!
      
      override func prepareForReuse() {
          super.prepareForReuse()
          
          self.customNameLabel.isHidden = false
      }
  }
  ```

- 마찬가지로 Cell 재사용 시 cell 속성 재설정해주는 부분 주의할 것

## TabBar

### 스토리보드 이용

- Embed in Tab Bar Controller 방법
- ViewController 5개 생성하여 TabBarController에서 RelationShip Segue 세그웨이를 각각 연결
- 탭바의 아이콘을 원하는 아이콘으로 변경하기 위해서는 TabBarController의 TabBar를 클릭하지 말고, 아이템을 변경하고 싶은 ViewController의 TabBar attributes inspector에 아이콘을 설정 해주면 된다. 
  기본으로 제공되는 아이콘은 System Item에 있으며, 사용자가 원하는 이미지는 Bar Item 섹션의 Image에서 선택해주면 된다.
- [출처](https://twer.tistory.com/6)

### 코드상에서만 이용

- 스토리보드에 빈 ViewController 연결 및 UITabBarController 프로토콜 채택

  ```swift
  import UIKit
  
  class ViewController: UITabBarController, UITabBarControllerDelegate {
  
      override func viewDidLoad() {
          super.viewDidLoad()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          // Create First Tab
          let tabOne = FirstViewController()
          let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
          tabOne.tabBarItem = tabOneBarItem
          
          // Create Second Tab
          let tabTwo = SecondViewController()
          let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
          tabTwo.tabBarItem = tabTwoBarItem2
          
          self.viewControllers = [tabOne, tabTwo]
      }
      
      // UITabBarControllerDelegate method
      func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
          print("Selected \(viewController.title!)")
      }   
  }
  ```

- 각 TabBar에 해당하는 ViewController 파일 생성 및 각각의 작업 구현

  ```swift
  import UIKit
  
  class FirstViewController: UIViewController {
  
      override func viewDidLoad() {
          super.viewDidLoad()
          
          //backgroundColor 지정 안 해주면 검은색으로 설정된다
          self.view.backgroundColor = .blue
          self.title = "Tab 1"
      }
      
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
  }
  ```

  ```swift
  import UIKit
  
  class SecondViewController: UIViewController {
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          //backgroundColor 지정 안 해주면 검은색으로 설정된다
          self.view.backgroundColor = .red
          self.title = "Tab 2"
      }
      
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
  }
  ```

- [출처](http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/)

- UICollectionView 사용 이미지 검색 프로그램 만들기

  - https://www.raywenderlich.com/9334-uicollectionview-tutorial-getting-started
  - https://www.raywenderlich.com/9477-uicollectionview-tutorial-reusable-views-selection-and-reordering

- 참고: https://www.youtube.com/watch?v=NSryf0YJHHk

