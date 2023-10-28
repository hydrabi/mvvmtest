//
//  POPExplantion.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

import UIKit

//面向对象 封装、继承、多态
class B: UIViewController {
    func run() {
        print("run")
    }
}

class C: UITableViewController {
    func run() {
        print("run")
    }
}

//面向协议
protocol Runnable {
    var step:Int {get}
    func run()
}

extension Runnable {
    var step:Int {
        get {
            return 100
        }
    }
    
    func run() {
        print("run")
    }
}

class BVC: UIViewController, Runnable { }
class DVC: UITableViewController, Runnable { }

class POPExplantion {
    init() {
        let b = BVC()
        b.run()
        
        let d = DVC()
        d.run()
        
        let arr:[Runnable] = [b]
        arr.forEach({
            print("\($0.step)")
        })
    }
}

protocol SliderStyle {
    func config(_ sliderView:BaseSliderView)
}

class BaseSliderView:UIView {
    var titleLabel:UILabel = UILabel()
}

class SliderView<T:SliderStyle>:BaseSliderView {
    
    private var style:T? = nil
    
    func style(_ style:T) -> Self{
        self.style = style
        style.config(self)
        return self
    }
}

class IntensitySlider:SliderStyle {
    func config(_ sliderView: BaseSliderView) {
        sliderView.titleLabel.text = "Intensity"
    }
}

class SliderCreate {
    init() {
        let slider = SliderView().style(IntensitySlider())
    }
}
