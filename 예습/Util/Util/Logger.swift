//
//  Logger.swift
//  Util
//
//  Created by 신재혁 on 28/10/2018.
//  Copyright © 2018 ninetyfivejae. All rights reserved.
//

import Foundation

//access control 아무 것도 명시를 하지 않으면 기본 internal로 설정이 된다
//internal같은 경우 모듈이 다른 경우 노출이 되지 않음
//그래서 클래스를 노출하기 위해서는 open이나 public으로 설정을 해줘야함

//enum은 상속이 안 되기 때문에 open으로 access control 지정 못함. 에러남
public enum LogLevel: String{
    case none = ""
    case success = "✅"
    case info = "ℹ️"
    case warning = "⚠️"
    case error = "🛑"
}

open class OpenLogger{
    //함수를 호출하는 곳의 파일 이름과 라인 위치를 가져올 수 있음
    open static func openLogMessage(log : String, level: LogLevel, file: String = #file, line: Int = #line){
        print(level.rawValue, file, line, log)
    }
    public static func publicLogMessage(log : String){
        print(log)
    }
    internal static func internalLogMessage(log : String){
        print(log)
    }
    fileprivate static func fileprivateLogMessage(log : String){
        print(log)
    }
    private static func privateLogMessage(log : String){
        print(log)
    }
}

public class PublicLogger{
    open static func openLogMessage(log : String){
        print(log)
    }
    public static func publicLogMessage(log : String){
        print(log)
    }
    internal static func internalLogMessage(log : String){
        print(log)
    }
    fileprivate static func fileprivateLogMessage(log : String){
        print(log)
    }
    private static func privateLogMessage(log : String){
        print(log)
    }
}

internal class InternalLogger{
    open static func openLogMessage(log : String){
        print(log)
    }
    public static func publicLogMessage(log : String){
        print(log)
    }
    internal static func internalLogMessage(log : String){
        print(log)
    }
    fileprivate static func fileprivateLogMessage(log : String){
        print(log)
    }
    private static func privateLogMessage(log : String){
        print(log)
    }
}
