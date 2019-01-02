import UIKit

var str = "Hello, playground"

func test(number x: Int, numbers list: Int...) -> Int{
    return list[0]
}

func calculate(multiflyFirstNumber num1: Int, bySecondNumber num2: Int) -> Int{
    return num1 + num2
}

test(number: 1, numbers: 1,2,3,4,5)



func add(_ a: Int, _ b: Int) -> Int{
    print(#function)
    return a+b
}

let calc: (Int, Int) -> Int = add

var result = add(1, 2)
print(result)

result = calc(1, 2)
print(result)
