//
//  ViewController.swift
//  Util Test
//
//  Created by 신재혁 on 28/10/2018.
//  Copyright © 2018 ninetyfivejae. All rights reserved.
//

import UIKit

//빌드 성공한 Util framework를 새 애플리케이션 Embedded binaries에 추가한 후에 import하면 사용 가능
//빌드 할 때 ios 디바이스에서 테스트를 하게 되면 빌드 설정을 ios 디바이스로 해줘야함
//근데 simulator로 하게 되면 mac os cpu에 최적화된 프레임워크가 만들어지기 때문에 ios 디바이스에서는 빌드가 안 됨
import Util

//open access 레벨이 아닌 이상 다른 모듈에서 상속이 안 됨
class Test: OpenLogger{
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        OpenLogger.openLogMessage(log: #function, level: .success)
    }

}
