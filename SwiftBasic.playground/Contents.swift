import UIKit

var str = "Hello, playground"

//산술연산자
var weight = 65
weight = weight + 10
weight = weight - 10
weight = weight * 10
weight = weight / 10
weight = weight % 10

weight = 65
weight += 10
weight -= 10
weight *= 10
weight /= 10
weight %= 10

//비교연산자
let age = 14
let isAdult = age >= 20
let 중1 = age == 14

//논리연산자
let 초등학생 = ((age >= 8) && (age <= 13))

//조건문
let dust = 15
if dust <= 30 {
    print("아 공기 상쾌하다~~")
}
else if dust > 30 && dust <= 50{
    print("뭐 이정도면 나쁘지않군")
}
else if dust > 50 && dust <= 100{
    print("좋지 않아")
}
else{
    print("최악이다")
}

let weather = "비"
switch weather {
case "맑음":
    print("🌞")
case "흐림":
    print("☁️")
case "비", "장마", "소나기":
    print("🌧")
case "눈":
    print("☃️")
default:
    print("🌞")
}

//반복문
for i in 1...10{
    print(i)
}

for i in stride(from: 1, to: 10, by: 2){
    print(i)
}

for i in stride(from: 10, to: 1, by: -2){
    print(i)
}

for j in 2...9{
    print("\(j)단 시작")
    for i in 1...9{
        print("\(j) X \(i) = \(j*i)")
    }
}

var i = 0
while i < 10 {
    i += 1
    print(i)
}

i=0
repeat{
    i += 1
    print(i)
} while i < 10
