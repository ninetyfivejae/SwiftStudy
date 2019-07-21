# Siri Kit

## [세미나영상](https://tv.naver.com/v/4980375)

### Speech - Intent - Action - Response

- Speech: 단어 인식 (vocabulary)
- Intent: 정보 수집 (vocabulary) (app logic)
- Action: 동작 수행 (app logic)
- Response: 결과 통보 (app logic) (UI)

### Siri works in Domains: Siri는 11가지 도메인에 의해 동작한다

- Messaging
- VoIP(인터넷을 기반으로 하는 음성 통화를 의미) calling
- Payments
- Workouts
- Ride booking
- Photos
- List and Notes
- Visual Code (ex. QR 코드)
- Car Command
- Carplay
- Restaurant Reservations

### Example

- Hey Siri, send Buttercup 85 bucks on UnicornPay for rainbow polish
  - Domain: Payments
  - Intent: sendPayment
  - App: UnicornPay
  - Payee: Buttercup
  - Amout: 85
  - Currency: USD
  - Note: Rainbow polish

### Intent

- 어떤 동작을 하기 위한 액션. 구문에서 파라미터를 뽑아내줘서 해당 도메인이 처리될 수 있는 필요한 요소들을 제공함
- Action to be performed
- Zero-to-many parameters
- Classified into a domain
- Intent Response: 받아온 파라미터로 동작을 처리하고 그 결과를 보여주게 된다
  - Result of handling an intent
  - Response code
  - NSUserActivity: response를 통해 앱이 실행됐을 때 앱이 동작할 데이터나 동작을 정의할 수 있음

### Lifecycle of an intent

- resolve
  - 사용자가 제공한 값을 이해하는 과정
  - Help Siri understand the values the user provided
  - 내용에 원하는 요소가 전부 담겨져 있으면 바로 confirm 단계로 넘어감
  - 근데 금액이나 받는 사람이 빠진 경우, resolve를 통해서 되묻게 된다
  - resolve 단계를 여러번 거쳐서 모든 정보가 수렴하게 되면 confirm 단계로 넘어간다
- confirm
  - Tell Siri the expected result of an intent
  - 시리가 의도한 것이 맞는지 사용자에게 묻는 과정
- handle
  - Perform the requested action
  - 요청받은 동작을 수행하는 과정
  - confirm에서 확인받고 handle에서 처리

### Siri kit

- Two Extensions
  - Intents extension: 발화에서 데이터를 추출해서 처리하는 부분
  - Intents UI extension: 커스터마이징한 UI를 Siri kit을 통해서 제공하는 extension
- Provide words and phrase to aid recognition: Siri가 이해할 수 있게 단어를 제공
  - App vocabulary
  - User Vocabulary

### Intents extension

- Supports one or more intents: 하나 혹은 다중으로 intents 사용 가능
- Runs in the background while Siri is active: 백그라운드에서 Siri가 동작하기 때문에 extension으로 구현을 해놓으면 앱 실행하지 않은 상황에서도 처리 가능
- Implements resolve, confirm, and handle methods: 도메인에 따라서 resolve, confirm, handle methods를 implement할 수 있다. Handle 같은 경우 보통 required이고, resolve, confirm은 도메인에 따라 optional일 수 있다

### Intents UI Extension

- Provide a UIViewController
- Optional: Intent extension에서 제공한 intent의 종류에 따라서 필요할 수도 필요 없을 수도 있기 때문에 optional
- Updates status
- Not interactive
- Resolve
  - Use INIntentResolutionResult's methods
  - Success: 값이 완전히 일치
  - notRequired: Handle에서 해당 값이 불필요
  - disambiguation: 값이 불분명하여 모호한 값 중에 선택 필요. 이게 넘어오면 resolve 단계에서 다시 물어보면 된다
  - confirmRequired: 해당 값에 대해 재확인 필요
  - needsMoreDetails: 더 구체적인 정보를 요구
  - needsValue: 제공된 정보 중 부재가 있어, 정보 필요 요구
  - Unsupported: 해당 값을 사용할 수 없을 경우
  - You have to return the result from those methods with the completion block
- Confirm
  - You can use it to validate the information to perform handling method.
  - You should know the intents you have to use for appropriate purpose
- Handle
  - Perform the task associated with the intent
  - Return a response object with information about what your app did
    - with NSUserActivity
  - Call the completion block with a response
- https://developer.apple.com/documentation/sirikit#//apple_ref/doc/uid/TP40016875-CH9-SW2

### Vocabulary

- User-Specific Vocabulary

  - To register terms that are specific to a single user, use an 'INVocabulary' object
  - 사용자 의존적인 단어
  - 적금 통장을 안 만든 사람한테 적금 단어가 굳이 필요 없는 것처럼
  - 적금 통장을 만든 사람한테만 적금이라는 단어가 동작을 할 수 있게
  - 런타임에 'INVocabulary' object를 통해서 등록을 하게 된다
  - InVocabulary is a shared object
  - Terms must belong to one of the following categories
    - Contact names(only if they are not managed by the contacts framework)
    - Photo tags
    - Photo album names
    - workout name

  ```swift
  let workoutNames = self.sortedWorkoutNames()
  
  let vocabulary = INVocabulary.shared()
  vocabulary.setVocabularyStrings(workoutNames, of: .workoutActivityName)
  ```

- App-Specific Vocabulary

  - To register terms common to all users of your app, add an AppIntentVocabulary.plist file to your iOS app.
  - 앱에서 필요한 단어들을 추가할 수 있음. 가령, QR코드를 보여주는 것, QR코드를 보여줘. 결제 코드를 보여줘, 송금 코드를 보여줘. 이런 것들, 앱 기반에서 사용자 상관없이 공통적으로 사용하는 단어들이 동작함. 그래서 빌드 타임에 정의되어 들어가기 때문에 plist에 적게 된다
  - 유저와 상관없이 앱에서 공통적으로 사용하게 되는 것
  - Aka Global vocabulary
  - Terms must belong to one of the following categories
    - ride options
    - workout names
  - a property list file name must be 'AppIntentVocabulary.plist'
  - You can create localized versions automatically from the file inspector in Xcode

### Custom Interface

- An intents UI extension may support multiple intents, but all of those intents share the same view controller
- no user interactions. 유저 인터렉션 받을 수 없음
- info.plist keys
  - NSExtensionAttributes
  - NSExtensionMainStoryboard
  - NSExtensionPointIndentifier
- Intent UI Guides
  - Incorporate your brand into your interface
  - Use child view controllers to switch between different types of content
  - Configure any animated content to run only when your view controller is visible
  - Configure your view controller's view as quickly as possible so that Siri can display it
  - Do not include advertising in your interface

- Default interface
  - Messaging: message content and recipients
  - Ride booking: user's location
- Replacing the default interface: INUIHostedViewSiriProviding protocol

- Permissions
  - Request authorization
  - Explain what data goes to Siri
- 참고
  - https://www.raywenderlich.com/600-sirikit-tutorial-for-ios
  - https://www.shinobicontrols.com/blog/ios-10-day-by-day-day-9-sirikit-intents/