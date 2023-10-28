//
//  DelegateProxyExplantion.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

import Foundation
import RxCocoa
import RxSwift

class Person:NSObject {
    weak var delegate:PersonDelegate? = nil
    
    func action() {
        delegate?.run?(km: 10)
        delegate?.jump?(meter: 0.6)
    }
}

@objc protocol PersonDelegate {
    @objc optional func run(km:Int)
    @objc optional func jump(meter:Float)
}

extension Person:HasDelegate {
    typealias Delegate = PersonDelegate
}

class PersonDelegateProxy : DelegateProxy<Person,PersonDelegate>,DelegateProxyType,PersonDelegate {
    static func registerKnownImplementations() {
        self.register { PersonDelegateProxy(parentObject: $0, delegateProxy: PersonDelegateProxy.self) }
    }
    
//    func run(km:Int) {}
//    func jump(meter:Float) {}
}

extension Reactive where Base:Person {
    var delegate:PersonDelegateProxy {
        return PersonDelegateProxy.proxy(for: base)
    }
    
    var run:Observable<Int> {
        return delegate.methodInvoked(#selector(PersonDelegate.run(km:)))
            .map {
                $0[0] as! Int
            }
    }
    
    var jump:Observable<Float> {
        return delegate.methodInvoked(#selector(PersonDelegate.jump(meter:)))
            .map { 
                $0[0] as! Float
            }
    }
}

class DelegateProxyExplantion {
    
    let disposeBag = DisposeBag()
    
    init() {
        let person = Person()
        
        person.rx.run.subscribe(onNext:{
            [weak self] km in guard let strongSelf = self else { return }
            print("\(km)")
        }).disposed(by: disposeBag)
        
        person.rx.jump.subscribe(onNext:{
            [weak self] meter in guard let strongSelf = self else { return }
            print("\(meter)")
        }).disposed(by: disposeBag)
        
        person.action()
    }
}

//extension DelegateProxyExplantion : PersonDelegate {
//    
//}
