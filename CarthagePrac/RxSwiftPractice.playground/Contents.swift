import UIKit
import RxSwift

let disposeBag = DisposeBag()


let zoo4 = Observable<String>.create { observer in
	observer.onNext("TEST1")
	observer.onNext("TEST2")
	let error = NSError(domain: "dummyError", code: 0, userInfo: nil)
	observer.onError(error)
	return Disposables.create()
}
zoo4.debug().retryWhen { (_) -> Observable<Int> in
	return Observable<Int>.timer(3, scheduler: MainScheduler.asyncInstance)
}.subscribe { (event) in
	print(event)
}.disposed(by: disposeBag)




let timer = Observable<Int>.create { observer in
	let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
	timer.schedule(deadline: DispatchTime.now() + 1, repeating: 1)
	let cancel = Disposables.create {
		timer.cancel()
	}
	var next = 0
	timer.setEventHandler {
		if cancel.isDisposed {
			return
		}
		if next < 3 {
			observer.onNext(next)
			next += 1
		}
	}
	timer.resume()
	return cancel
}

timer.debug().timeout(2, scheduler: MainScheduler.instance).subscribe().disposed(by: disposeBag)
