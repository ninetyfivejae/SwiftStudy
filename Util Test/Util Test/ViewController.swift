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

import os.log

//open access 레벨이 아닌 이상 다른 모듈에서 상속이 안 됨
class Test: OpenLogger{
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        OpenLogger.openLogMessage(log: #function, level: .success)
        
        NSLog("✅ viewDidLoad")
        NSLog("✅ viewDidLoad")
        NSLog("✅ viewDidLoad")
        
        //NSLog 함수는 속도가 느리다는 치명적인 단점이 있음
        //그래서 애플에서 통합 로깅 시스템을 발표함
        //가끔 앱에 문제가 있어서 로그를 남겨서 어디가 문제인지 확인을 하려다가, 발생했던 문제가 로그로 인한 속도저하로 재현이 안 되는 경우가 있음
        //이런 문제를 옵저버 이펙트라고 하는데, 이런 옵저버 이펙트의 문제를 해결하기 위해 통합 로깅 시스템을 소개했음
        //통합로깅의 특징은 일단 빠르다. 빠른 로깅을 위해 로그데이터를 압축한다던가 필요에 따라 디스크나 메모리에 로그를 남긴다던가, 앱의 성능에 영향을 가하는 것을 최소화 하기 위해 로그의 작업 시점을 변경하는 등 여러가지 방법을 통해서 옵저버 이팩트를 최소화 하고 있다고 함
        //logging 시스템은 iOS 10 이상에서 사용 가능. 배포 버전도 iOS 10 이상이어야한다는 말
        os_log("os_log ✅ viewDidLoad")
        os_log("os_log ✅ viewDidLoad")
        os_log("os_log ✅ viewDidLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
