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

func hello(name: String) -> String{
    return "Hello~ " + name
}

func hello2(name: String){
    
}

let message = hello(name: "jae")

//개발자 문서 보는 방법
//option 누르면서 마우스 갖다대면 물음표 표시
//맨 오른쪽 레이아웃 물음표 표시
//help - developer documentation 검색

print("Hi~~")
print(123)
print(message)
//separator : 사이사이 구분하는 문자, 기본은 빈칸 하나
//terminator : 마지막을 알려주는 문자, \n으로 끝내고 싶지 않다 하면 terminator:"" 이렇게 써주면된다
print(123, "Hello", true, 123.456, separator:"---", terminator:"")

func addTwoNumbers(num1: Int, num2: Int = 100) -> Int {
    return num1 + num2
}

addTwoNumbers(num1: 5, num2: 10)
addTwoNumbers(num1: 5)

//let 상수
//var 변수
//차이는 초기화 후 값이 변경되면 변수, 안 바뀌면 상수
//스코프 변수와 상수의 사용 가능 범위, 메모리 효율적 사용과 관계가 있음,

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

//argument label을 통해서 입력값에 대한 설명을 명시해줄 수 있다
//함수를 외부에 노출할 때 argument label을 통해서 입력값에 대한 설명을 보여줄 수 있음
//함수 내부에서는 간략한 parameter naming을 가지고 간결하게 구현할 수 있음
//생략하려고 하면 _ underscore로 표시
func calculate(multiflyFirstNumber num1: Int, bySecondNumber num2: Int) -> Int{
    return num1 + num2
}

func calculate(_ num1: Int, _ num2: Int) -> Int{
    return num1 * num2
}

//argument label이 달라도 함수 오버로딩이 된다
calculate(1, 2)
calculate(multiflyFirstNumber: 1, bySecondNumber: 10)

//매개변수들은 let키워드로 상수임을 알 수 있다.
//함수 인자로 전달해준 값들을 실수로 함수 안에서 값을 변경하지 못하게 하기 위해서이다
func addTwoNumber(num1: Int, num2: inout Int) -> Int{
    num2 = 7
    return num1 + num2
}

var test1 = 1
var test2 = 2

//test1에 저장돼있는 값이 복사되어서 넘어감. call by value
//test2 변수 자체가 넘어가서(변수의 메모리 주소를 넘겨줌) 값이 변경되면 똑같이 test2 변수도 변함. call by reference
addTwoNumber(num1: test1, num2: &test2)
print(test2)

//bit 2가지 정보, 전기적인 신호가 거의 없거나 0, 전기적인 신호가 일정 이상인 경우 1
//bit는 2가지만 저장가능하여 큰 의미가 없고, bit를 8개로 묶어서 1byte단위로 정보를 저장
//1byte 0~255 256가지 정보를 저장 가능
0 == 0x0
255 == 0xff

//byte가 하나 올라갈 때마다 16진수는 2자리씩 딱딱 맞게 올라감
//데이터 저장단위 byte와 16진수랑 딱 맞아떨어지기 때문에 16진수 사용
//컴퓨터는 2진수를 사용하는데 2진수로 숫자를 표현하면 너무 길어져서 불편함. 2진수 데이터를 간결하게 표현할 수 있기 때문
//2바이트 최대값 65535 16진수로 표현
65535 == 0xffff

0b1111 == 0xf
0b11111111 == 0xff

