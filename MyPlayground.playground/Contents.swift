import UIKit

////배열 리터럴, 이 경우에는 빈 배열 생성 불가
//let stringArray = ["one", "two", "three"]
////생성자
////let stringArray = Array<Int>(["one", "two", "three"])
//
////빈 array 생성
//var integers: Array<Int> = Array<Int>()
//integers.append(1)
//integers.append(100)
//integers.append(100)
//
//integers.contains(100)
//integers.contains(99)
//
//integers.remove(at: 0)
//integers.removeFirst()
//integers.removeLast()
//integers.removeAll()
//integers.popLast()
//
//
//integers.removeAll(keepingCapacity: true) //요소를 모두 삭제를 하지만 메모리공간을 할당 해제를 하지 않음. 삭제 후 요소들을 다시 채우게 되는 경우 사용하면 불필요한 메모리 할당해제가 일어나지 않아서 좋음
//
//integers.count
//
//if !integers.isEmpty{
//    print("\(integers.count) element(s)")
//}else{
//    print("Empty array")
//}
//
//integers.startIndex
//integers.endIndex
//
//integers.index(of: 1)
//
//var alphabet = ["A", "B", "C", "D", "E"]
//var lower = ["a", "b", "c", "d", "e"]
//if alphabet == lower{
//    print("alphabet == lower")
//}else{
//    print("alphabet != lower")
//}
//if alphabet.elementsEqual(lower, by: {$0.lowercased() == $1.lowercased()}){
//    print("alphabet == lower")
//}else{
//    print("alphabet != lower")
//}
//
//alphabet.replaceSubrange(0..<2, with: ["X", "Y"])
//alphabet.replaceSubrange(alphabet.startIndex..<alphabet.endIndex.advanced(by: -1), with: ["X", "Y"])
//alphabet[alphabet.startIndex..<alphabet.endIndex.advanced(by: -1)] = ["X", "Y"]
//
//alphabet.sorted() //배열을 변경하지는 않음
//alphabet
//alphabet.sort() //새롭게 정렬한 배열로 변경
//alphabet
//
//alphabet.reverse()
//alphabet.reverse()
//alphabet.reversed()
//var result2: [String] = alphabet.reversed()
//result2
//
//let subArray = alphabet[1..<3]
//print(subArray)
//var result = alphabet.dropLast()
//result = alphabet.dropFirst(2)
//
//
//
//
//
//
//
//let words = ["A": "Apple", "B": "Banana", "C": "City"]
//let anotherWords = ["B": "Banana", "C": "City", "A": "Apple"]
//let countryCodes = ["KR": "South Korea", "US": "United States"]
//let upperWords = ["A": "APPLE", "B": "BANANA", "C": "CITY"]
//
//let countOfWords = words.count
//
//if !words.isEmpty{
//    print("\(countOfWords) element(s)")
//}else{
//    print("empty dictionary")
//}
//
//let keys = Array(words.keys)
//print(keys)
//
//let values = Array(words.values)
//print(values)
//
//if words.contains(where: {(key, value) -> Bool in return key == "A"}){
//    print("contains A key.")
//}
//
//if words.contains(where: {$0.1 == "City"}){
//    print("contains City value.")
//}
//
//if words == anotherWords{
//    print("words == anotherWords")
//}else{
//    print("word != anotherWords")
//}
//
//if words == countryCodes{
//    print("words == countryCodes")
//}else{
//    print("word != countryCodes")
//}
//
//let equals = words.elementsEqual(upperWords){(lhs, rhs) -> Bool in
//    return lhs.0.lowercased() == rhs.0.lowercased()
//        && lhs.1.lowercased() == rhs.1.lowercased()
//}
//
//print(equals)
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//let array = ["Apple", "Orange", "Melon"]
//for value in array {
//    if let index = array.index(of: value){
//        print("\(index) ~ \(value)")
//    }
//}
//
//let set = Set(array)
//for value in set{
//    print(value)
//}
//
////enumerate() 메소드를 사용하면 순회의 각 단계마다 인덱스와 값으로 구성된 튜플을 얻을 수 있다. 배열을 순회할 때마다 인덱스를 사용할 때 유용
//for t in alphabet.enumerated(){
//    print("\(t.0) - \(t.1)")
//}
//
//for (index, char) in alphabet.enumerated(){
//    print("\(index) - \(char)")
//}
//
//class AClass{
//    static var typeProperty: Int = 0
//}
////static var typeProperty: Int = 0
//
//
//var person: (String, Int, Double) = ("yagom", 100, 182.5)
//print("\(person.0), \(person.1), \(person.2)")
//
//var person2: (name: String, age: Int, height: Double) = ("yagom", 100, 182.5)
//print("\(person2.name), \(person2.age), \(person2.height)")
//
//typealias PersonTuple = (name: String, age: Int, height: Double)
//let yagom: PersonTuple = ("yagom", 100, 178.5)
//let eric: PersonTuple = ("eric", 100, 178.5)
//
//print("\(yagom.name), \(yagom.age), \(yagom.height)")
//
//
//
//
//
//
//
//
//let englishClassStudents: Set<String> = ["john", "chulsoo", "yagom"]
//let koreanClassStudents: Set<String> = ["jenny", "yagom", "chulsoo", "haha", "minsoo"]
//
//let intersectSet: Set<String> = englishClassStudents.intersection(koreanClassStudents)
//let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents)
//let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents)
//let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents)
//
//print(unionSet.sorted())
//
//let 새: Set<String> = ["비둘기", "닭", "기러기"]
//let 포유류: Set<String> = ["사자", "호랑이", "곰"]
//let 동물: Set<String> = 새.union(포유류)
//
//print(새.isDisjoint(with: 포유류))
//print(새.isSubset(of: 동물))
//print(동물.isSuperset(of: 포유류))
//print(동물.isSuperset(of: 새))
//
//
//
//

enum Weekday{
    case mon
    case tue
}

print(Weekday.mon.hashValue)
//
//class Calculate {
//
//    func add(_ num1: T, _ num2: T) -> T {
//        return num1 + num2
//    }
//
//    func subtract(_ num1: T, _ num2: T) -> T {
//        return num1 - num2
//    }
//
//    func multiply(_ num1: T, _ num2: T) -> T {
//        return num1 * num2
//    }
//}
//
//var calculateTest: Calculate = Calculate()
//
//var result = calculateTest.add(1, 2)
//
//print(result)

var yourName: String? = "aaa"
print(yourName)  //nil값이라서 런타임 오류 발생
if let name = yourName {
    print(name)
}

yourName! + "aaa"
