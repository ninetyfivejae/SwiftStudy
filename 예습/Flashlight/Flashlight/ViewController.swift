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
        
        flashImageView.image = isOn ? #imageLiteral(resourceName: "onBG") : #imageLiteral(resourceName: "offBG")
        switchButton.setImage(isOn ? #imageLiteral(resourceName: "onSwitch") : #imageLiteral(resourceName: "offSwitch"), for: .normal)
    }
}
