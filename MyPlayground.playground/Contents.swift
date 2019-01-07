import UIKit

enum Weekday{
    case mon
    case tue
}
print(Weekday.mon.hashValue)

var yourName: String? = "jae"
print(yourName)

if let name = yourName {
    print(name)
}

yourName! + "aaa"

var myName: String! = "yagom"
print(myName) //yagom
myName = nil
