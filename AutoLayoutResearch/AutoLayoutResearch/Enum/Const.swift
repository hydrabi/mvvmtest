//
//  Const.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

import Foundation

enum ColorControlType:Int {
    case CCT,
         HSI
    
    func title() -> String {
        switch(self) {
        case .CCT:
            return "CCT"
        case .HSI:
            return "HSI"
        }
    }
}

enum BrandType {
    case Brand1(minCCT:Int,maxCCT:Int),
         Brand2(uuid:String)
    
    func getDescription() {
        switch(self) {
        case .Brand1(let minCCT,let maxCCT):
            print("\(minCCT),\(maxCCT)")
        case .Brand2(let uuid):
            print("\(uuid)")
        }
    }
}
