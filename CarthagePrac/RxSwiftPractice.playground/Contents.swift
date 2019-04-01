import UIKit
import RxSwift

var str = "Hello, playground"

//Observable (something which emits notifications of change)
//A Observable is a sequence of ongoing events ordered in time.ie Only one element is received at a particular time. eg in tableView delegates (did Select Row At Indexpath) only one element is received.
//Observable emits events. Event is an enum containing three types of events.Next for getting actual value , Error is sent when something goes wrong and completed is sent when an Observable wants to tell his observers that no more events will be sent.

public enum Event<Element> {
	case next(Element)
	case error(Swift.Error)
	case completed
}

//Subscribe(something listening to Observable)
//subscribe is a very important method while working with Observables.The listening to observable is called subscribing.. If you forget to call subscribe no events(next, error, completed) will ever come to you.

let helloSequence = Observable.from(["H","e","l","l","o"])
let subscription = helloSequence.subscribe { event in
	switch event {
	case .next(let value):
		print(value)
	case .error(let error):
		print(error)
	case .completed:
		print("completed")
	}
}

//DisposableBag
//Just like in notifications we remove observer to clear ARC count like that we have to remove observer in order to decrease reference count.To overcome this RxSwift gives us a tool to deallocate memory automatically .i.e DisposableBag .
//It is given in RxSwift to deal with ARC and memory management.This is a virtual “bag” of Observer objects which are disposed of when their parent object is deallocated.If object contains DisposableBag as a property, then it will automatically deallocate it.
//Without a DisposableBag, you’d get one of two results: either the Observer would create a retain cycle, hanging on to what it’s observing indefinitely, or it could get deallocated out from under your object, causing a crash.
//So it is better to use DisposableBag to cancel subscriptions.

// Creating a DisposeBag so subscribtion will be cancelled correctly
let bag = DisposeBag()
// Creating an Observable Sequence that emits a String value
let observable = Observable.just("Hello Rx!")
// Creating a subscription just for next events
let subscription2 = observable.subscribe (onNext:{
	print($0)
}).addDisposableTo(bag)
