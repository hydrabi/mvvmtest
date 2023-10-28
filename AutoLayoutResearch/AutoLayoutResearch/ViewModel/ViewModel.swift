//
//  ViewModel.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
//    let dataSource = ["one","two","three","four"]
    
    var dataSourceObservable:Observable = Observable.just([
        "one",
        "two",
        "three",
        "four"
    ])
    
}
