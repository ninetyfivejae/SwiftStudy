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

//---------------------------------------------------

prefix operator ++

struct Position {
    var x: Int
    var y: Int
}

extension Position {
    static func + (left: Position, right: Position) -> Position {
        return Position(x: left.x + right.x, y: left.y + right.y)
    }
    
    static prefix func - (vector: Position) -> Position {
        return Position(x: -vector.x, y: -vector.y)
    }
    
    static func += (left: inout Position, right: Position) {
        left = left + right
    }
}

extension Position {
    static func == (left: Position, right: Position) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }

    static func != (left: Position, right: Position) -> Bool {
        return !(left == right)
    }
}

extension Position {
    static prefix func ++ (position: inout Position) -> Position {
        position.x += 1
        position.y += 1
        return position
    }
}

var myPosition: Position = Position(x: 10, y: 10)
var yourPosition: Position = Position(x: -5, y: -5)

print(myPosition + yourPosition)
print(-myPosition)

myPosition += yourPosition
print(myPosition)

print(myPosition == yourPosition)
print(myPosition != yourPosition)

print(++myPosition)

//---------------------------------------------------

//public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]

let names: [String] = ["wizplan", "eric", "yagom", "jenny"]



func backwards(first: String, second: String) -> Bool {
    print("\(first) \(second) 비교 중")
    return first > second
}
let firstReversed: [String] = names.sorted(by: backwards)
print(firstReversed)



let secondReversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
    return first > second
})
print(secondReversed)



let thirdReversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first > second
}
print(thirdReversed)



let fourthReversed: [String] = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}
print(fourthReversed)



let fifthReversed: [String] = names.sorted() {
    return $0 > $1
}
print(fifthReversed)



let sixthReversed: [String] = names.sorted { $0 > $1 }
print(sixthReversed)

//---------------------------------------------------

