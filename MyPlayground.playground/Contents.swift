import UIKit

var str = "Hello, playground"

func hello(name: String) -> String{
    return "Hello~ " + name
}

func hello2(name: String){
    
}

let message = hello(name: "jae")



func addTwoNumbers(num1: Int, num2: Int = 100) -> Int {
    return num1 + num2
}

addTwoNumbers(num1: 5, num2: 10)
addTwoNumbers(num1: 5)



func addNumbers(numbers: Int...) -> Int{
    var sum = 0
    for num in numbers{
        sum += num
    }
    return sum
}

addNumbers(numbers: 1,2,3,4,5)

func myInfo() -> (name: String, weight: Int){
    return ("jae", 70)
}

let info = myInfo()
print(info.name)
print(info)
