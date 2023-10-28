//
//  SideEffect.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

import Foundation

//函数副作用（side effect）指当调用函数时，除了返回可能的函数值之外，还对主调用函数产生附加的影响。例如修改全局变量（函数外的变量），修改参数，向主调方的终端、管道输出字符或改变外部存储信息等。
class SideEffect {
    
    var globalP1:Int = 10
    
    
    func add(parm1:Int,parm2:Int) -> Int {
        return parm1 + parm1
    }
    
    func addForGlobalP1(param2:Int) -> Int {
        return globalP1 + param2
    }
}
