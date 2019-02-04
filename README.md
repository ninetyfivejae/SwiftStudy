# SwiftStudy

## 예습

- [SwiftBasicExamples](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/SwiftBasicExamples.md#swiftbasicexamples)
- [Flashlight App](https://github.com/ninetyfivejae/SwiftStudy/blob/master/%EC%98%88%EC%8A%B5/FlashlightApp.md#flashlight-app)

## En#SwiftStudy

- 스터디 방식

  - 과제
    - 각자 분야 조사 및 공부, 정리해와서 설명해주기(내 분야가 아닌건 그날 스터디 종료 후 바로 설명들은거로 공부하기)
    - 각자 10분씩 총 30분 서로 설명해주고, 나머지 30분은 상욱이형이 추가적으로 부족한 부분 설명하고 실습 진행으로 2~3시간씩 스터디 진행
    - 다음 스터디 일정은 바로 전주에 만나서 정하는걸로하고, 내가 먼저 장소 프로젝트 가능한 곳으로 괜찮은데 알아봐야함
    - 3주차때는 형 여행가니까 평일에 금요일이나 월요일 중으로 만나서 하는걸로

- 일정


```
1주차 - Swift에서 타입이란
- 상수와 변수
- 함수 정의 및 사용법
- Property(Stored, Computed, Class)
- 콜렉션(Array, Dictionary, Set)
- Class / Struct / Enum
- Optional / Optional Binding

실습
- Calculate 클래스 만들어보기

함수
    Formal Parameter와 Argument
    Argument Label & Parameter Name
    파라미터 기본 값 설정
    가변 파라미터 ...
    입출력 파라미터 inout
    복합 Return 값
    Function Types
    Nested Functions
Property(Stored, Computed, Class)
	Stored Property
	Lazy Stored Property
	Computed Property
	Type Property
	Property Observer
	전역변수와 지역변수
Collection (Array, Dictionary, Set)
	Array
	Dictionary
	Set
```

```
2주차 - UIKit 사용해보기
- 스토리보드
- Frame, Bounds
- Autolayout
- UILabel
- UIButton
- UITextview
- UITextField
실습
- Autolayout 실습
- UIResponder, User Interaction
- 버튼 동작해보기
```

```
3주차 - Protocol Oriented Programming 개요
- 상속에 관한 이야기
- Protocol 과 Extension
- 타입 캐스팅
- 제네릭 개요

---

Type Casting
- 기존 언어의 타입 변환 vs 스위프트의 타입 변환
- 데이터 타입 확인 연산자 is
- Metatype Type. 메타타입 타입
- 다운캐스팅
- Any, AnyObject의 타임캐스팅

제네릭
- 제네릭 함수
- 제네릭 타입
- 타입 제약
- 프로토콜의 연관 타입
- 제네릭 서브스크립트

Protocol
- 프로퍼티 / 메소드 / 가변 메소드 / 이니셜라이저 요구
- 프로토콜의 상속과 클래스 전용 프로토콜
- 프로토콜 조합과 프로토콜 준수 확인
- 프로토콜의 선택적 요구
- 프로토콜 변수와 상수
- 위임을 위한 프로토콜

Extension
- 연산 프로퍼티 / 메소드 / 이니셜라이저 / 서브스크립트 / 중첩 데이터 추가

UITableView / UICollectionView
- dequeueReusableCell 사용 이유
- Cell 재사용 시 주의사항

Segue
- performSegueWithIdentifer
- instantiateViewController
- Custom Segue
... 더 정리해야함
```

```
+ Swift 기본 패턴
- Delegate
- KVO: Key-Value Observing

4주차 - 클로저와 ARC
- Closure
- 고차함수(Map, Filter, Reduce)
- Generic

+ ARC

실습
- Array 확장해보기(제네릭 사용)
- ARC
- 순환참조 해결하기
```

```
5주차 ~ 8주차 - 미니 프로젝트 선정 및 진행해보기
- 사진 앨범 or 미니 Todo 앱
```

## 추가 정리

- Typealias는 static 으로 설정이 된다
- 도큐먼트 맨 마지막 conform to(준수하다) 많이 참고하게 될 것
- protocol document에 required 표시 돼있으면 필수 구현해야하는 것들이 있음