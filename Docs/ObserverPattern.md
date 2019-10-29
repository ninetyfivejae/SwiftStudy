# Observer Pattern in Swift

## [옵저버 패턴(observer pattern)](https://ko.wikipedia.org/wiki/%EC%98%B5%EC%84%9C%EB%B2%84_%ED%8C%A8%ED%84%B4)

- 객체의 상태 변화를 관찰하는 관찰자들, 즉 옵저버들의 목록을 객체에 등록하여 상태 변화가 있을 때마다 메서드 등을 통해 객체가 직접 목록의 각 옵저버에게 통지하도록 하는 디자인 패턴이다
  - [예제 확인](https://magicmon.github.io/2017/07/04/Observer-Pattern/)

## 간단한 예제

- Protocols

  - Observable
  - Observer

  ```swift
  protocol Observable {
      func addObserver(_ observer: Observer)
      func removeObserver(_ observer: Observer)
  }
  
  protocol Observer: class {
      func update(_ temp: Float, density: Float)
  }
  ```

- Observation

  ```swift
  class Observation: Observable {
      var observers = [Observer]()
      
      func addObserver(_ observer: Observer) {
          observers.append(observer)
      }
      
      func removeObserver(_ observer: Observer) {
          observers = observers.filter({ $0 !== observer })
      }
  }
  ```

- DustMeter

  ```swift
  class DustMeter: Observation {
      var temperature: Float = 0.0
      var density: Float = 0.0
      
      func notify() {
          for observer in observers {
              observer.update(temperature, density: density)
          }
      }
  }
  ```

- Subscriber

  ```swift
  class Subscriber: Observer {
      
      var name: String = ""
      
      func update(_ temp: Float, density: Float) {
          print("name: \(name), temp: \(temp) density: \(density)")
      }
      
      init(name: String) {
          self.name = name
      }
  }
  ```

- ViewController

  ```swift
  class ViewController: UIViewController {
  
      let dustMeter = DustMeter()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          let user1 = Subscriber(name: "Tom")
          let user2 = Subscriber(name: "Sam")
          let user3 = Subscriber(name: "Kim")
          
          // add User
          dustMeter.addObserver(user1)
          dustMeter.addObserver(user2)
  		dustMeter.addObserver(user3)
          
          // remove User
          dustMeter.removeObserver(user1)
      }
  }
  
  extension ViewController {
      @IBAction func clickedButton() {
          dustMeter.temperature = 32
          dustMeter.density = 80
          
  				dustMeter.notify()
      }
  }
  ```

- 