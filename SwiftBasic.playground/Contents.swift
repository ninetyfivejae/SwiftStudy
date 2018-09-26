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

let month = 3
let toDo = "Travel"

var toDoArray: Array<String> = ["Travel", "Work", "Call"]
var evenNumber: [Int] = [2,4,6,8]

toDoArray[0] = "Play"
toDoArray[1]
toDoArray[2]

evenNumber.append(10)
evenNumber.insert(12, at: 0)
evenNumber.remove(at: 0)
print(evenNumber)

for toDo in toDoArray{
    print(toDo)
}

var toDoDic: Dictionary<Int, String>  = [17: "Play", 25: "Watch Movies", 28: "Travel"]
var toDoDic2: Dictionary<String, String> = ["17": "Play", "25": "Watch Movies", "28": "Travel"]
toDoDic2["17"]
toDoDic2["31"] = "Study"
print(toDoDic2)
toDoDic2["31"] = ""
print(toDoDic2)
toDoDic2.removeValue(forKey: "31")
print(toDoDic2)
toDoDic2["28"] = nil
toDoDic2.removeAll()
print(toDoDic2)
for (k, v) in toDoDic2{
    print("key: \(k), value: \(v)")
}
