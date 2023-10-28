//
//  iPhoneBindingViewModel.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/2.
//

import Foundation
import RxSwift
import RxCocoa

class iPhoneBindingViewModel {
    
    lazy var observable:BehaviorSubject<iPhoneBindingModel> = {
        var model = iPhoneBindingModel()
        model.name = "Ted"
        model.num = "100"
        return BehaviorSubject(value: model)
    }()
    
    func nextModel() {
        var model = iPhoneBindingModel()
        model.name = "Barney"
        model.num = "83"
        observable.onNext(model)
    }
}
