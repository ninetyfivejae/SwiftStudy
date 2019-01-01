# SwiftStudy

## 1. [SwiftBasicExamples](https://github.com/ninetyfivejae/SwiftStudy/blob/master/SwiftBasicExamples.md#swiftbasicexamples)

## 2. 애플리케이션

### Flashlight Application

- 1x 이미지는 아이폰 3gs와 대응이 되고,

- 2x 나머지

- 3x 이미지는 아이폰  6+, 6s+, 7+, 8+, X와 대응되는 이미지

- Asset Catalog Creator 애플리케이션으로 1024x1024이미지 추가 후 프로젝트 Asset폴더로 export를 하게되면 알아서 앱 아이콘 사이즈별로 등록을 해줌

- UI control 및 소스코드 연동, 사운드 효과 추가

  - UI control들을 코드와 연결하기 위해서 변수 선언을 해줘야함

    - 이것도 마찮가지로 버튼 drag drop하면 해당 위치에 변수를 선언해준다.
    - UI control과 소스코드를 연동할 때 outlet(콘센트라고 보면 된다) connection으로 연결한다
    - 변수 키워드, 변수 명, 콜론:, 타입
    - weak는 버튼이 메모리에서 해제되는 시점과 관련이 있고 나중에 설명
    - At Interface Builder, 예전에 interface builder라고 UI를 구성하는 프로그램이 따로 있었는데, xcode version 4부터 interface builder와 xcode프로그램이 하나로 합쳐져서 지금과 같은 프로그램으로 됐음
    - interface builder의 UI control과 코드를 연결한다라는 뜻

    ```swift
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var flashImageView: UIImageView!
    
    var isOn = false;
    
    var soundPlayer: AVAudioPlayer?
    ```

  - 버튼을 눌렀을 때 Action에 해당하는 코드 연결

    - UI control drag drop(마우스 우클릭 drag drop) 두손가락으로 하면, 함수 이름 설정/이벤트 설정 등등 지정하여 connect를 해줌
    - 주로 touch up inside 이벤트를 사용
    - 버튼 눌렀을 때 버튼 이미지 변경 및 배경 이미지 변경
    - UI control에서 이벤트가 발생했을 때 해당하는 action을 처리하기위한 함수가 연결돼있다라는 뜻

    ```swift
        @IBAction func switchTapped(_ sender: Any) {
            isOn = !isOn        
            soundPlayer?.play()
            
            
            if isOn == true {
                //특정한 파일 이름과 연결돼있는 이미지를 return해주는 UIImage함수로 이미지 가져오고,
                //normal 평상시 상태일때 이 이미지로 설정하겠다라는 뜻
                switchButton.setImage(UIImage(named: "onSwitch"), for: .normal)
                flashImageView.image = UIImage(named: "onBG")
            }
            else{
                //특정한 파일 이름과 연결돼있는 이미지를 return해주는 UIImage함수로 이미지 가져오고,
                //normal 평상시 상태일때 이 이미지로 설정하겠다라는 뜻
                switchButton.setImage(UIImage(named: "offSwitch"), for: .normal)
                flashImageView.image = UIImage(named: "offBG")
            }
            
            
            
            //image literal 사용. 이미지 자체를 넣는다는 의미. image치면 image literal이 나오는거로 설정하면 된다. Asset에 있는 이미지만 사용 가능
            if isOn == true {
                switchButton.setImage(#imageLiteral(resourceName: "onSwitch"), for: .normal)
                flashImageView.image = #imageLiteral(resourceName: "onBG")
            }
            else{
                //특정한 파일 이름과 연결돼있는 이미지를 return해주는 UIImage함수로 이미지 가져오고,
                //normal 평상시 상태일때 이 이미지로 설정하겠다라는 뜻
                switchButton.setImage(#imageLiteral(resourceName: "offSwitch"), for: .normal)
                flashImageView.image = #imageLiteral(resourceName: "offBG")
            }
            
            
            
            //함수형 언어로 3줄로 줄여봄
            flashImageView.image = isOn ? #imageLiteral(resourceName: "onBG") : #imageLiteral(resourceName: "offBG")
            switchButton.setImage(isOn ? #imageLiteral(resourceName: "onSwitch") : #imageLiteral(resourceName: "offSwitch"), for: .normal)
        }
    ```

  - 최종 코드

    ```swift
    import UIKit
    import AVFoundation
    
    class ViewController: UIViewController {
        @IBOutlet weak var switchButton: UIButton!
        @IBOutlet weak var flashImageView: UIImageView!
        
        var isOn = false;
        
        var soundPlayer: AVAudioPlayer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            prepareSound()
        }
        
        //AVAudioPlayer is part of the AVFoundation framework, so you'll need to import that
        func prepareSound(){
            let path = Bundle.main.path(forResource: "switch.wav", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: url)
                soundPlayer?.prepareToPlay()
            } catch {
                // couldn't load file :(
            }
        }
        
        //실제 아이폰 flashlight 켜는 함수
        //You will need to import the AVFoundation framework, because that's where the AVCaptureDevice class comes from.
        func toggleTorch(on: Bool) {
            guard let device = AVCaptureDevice.default(for: .video) else { return }
            
            if device.hasTorch {
                do {
                    try device.lockForConfiguration()
                    
                    if on == true {
                        device.torchMode = .on
                    } else {
                        device.torchMode = .off
                    }
                    
                    device.unlockForConfiguration()
                } catch {
                    print("Torch could not be used")
                }
            } else {
                print("Torch is not available")
            }
        }
    
        @IBAction func switchTapped(_ sender: Any) {
            isOn = !isOn
            soundPlayer?.play()
            toggleTorch(on: isOn)
    
            //image literal 사용. 이미지 자체를 넣는다는 의미. image치면 image literal이 나오는거로 설정하면 된다. Asset에 있는 이미지만 사용 가능
            if isOn == true {
                switchButton.setImage(#imageLiteral(resourceName: "onSwitch"), for: .normal)
                flashImageView.image = #imageLiteral(resourceName: "onBG")
            }
            else{
                //특정한 파일 이름과 연결돼있는 이미지를 return해주는 UIImage함수로 이미지 가져오고,
                //normal 평상시 상태일때 이 이미지로 설정하겠다라는 뜻
                switchButton.setImage(#imageLiteral(resourceName: "offSwitch"), for: .normal)
                flashImageView.image = #imageLiteral(resourceName: "offBG")
            }
            
            /*
            flashImageView.image = isOn ? #imageLiteral(resourceName: "onBG") : #imageLiteral(resourceName: "offBG")
            switchButton.setImage(isOn ? #imageLiteral(resourceName: "onSwitch") : #imageLiteral(resourceName: "offSwitch"), for: .normal)
            */
        }
    }
    ```

- iOS 개발 초기에 안 익숙할 때 주의할 점

  - 코드 상에서 UI control이름을 바꾸면 바꾼 이름을 스토리보드에서도 바꿔줘야함. 우클릭 이름 바꾸는 기능 사용해서 바꿔주면 되거나 / 연결 끊고 다시 처음부터 연결을 해주면 된다. 안드로이드처럼 xml파일에서 찾아서 이름을 바꿔주는 방법도 있음
  - Action을 연결한 함수를 코드 상에서 지우게 되면 스토리보드에서도 지워줘야함.
  - 스토리보드랑 ViewController랑 항상 같게 만들어줘야함

- 폴더 추가 시 주의할 점. 알아야하는 점

  - new group(노란 폴더) : 실제로 폴더가 생김
  - new group without folder(노란 폴더 + 화살표) : 실제에서는 폴더가 안 생기는데, 옆에 프로젝트 트리에서만 참고로 볼 수 있음
  - folder reference(파란색 폴더) : 디렉토리를 참조하는거라 안에 파일들을 사용하려면 경로를 명시를 해줘야함(아직 자세한 것은 아님)

- 아이폰에서 앱 실행

  - 설정 - 일반 - 기기관리 - 신뢰
  - signing에서 provisioning profile은 무료로 앱을 아이폰에 설치가능한데 기간이 일주일이라 일주일 지나면 앱을 사용못하니까 다시 설치를 해주면 된다.

- 