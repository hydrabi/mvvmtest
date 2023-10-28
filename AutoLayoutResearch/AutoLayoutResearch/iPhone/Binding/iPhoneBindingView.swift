//
//  iPhoneBindingView.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/2.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class iPhoneBindingView:UIView {
    
    lazy var nameLab = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 20)
        return lab
    }()
    
    lazy var numLab = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 20)
        return lab
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(nameLab)
        addSubview(numLab)
        
        nameLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        numLab.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp.bottom)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension Reactive where Base:iPhoneBindingView {
    var value:Binder<iPhoneBindingModel> {
        return Binder(base) { view,model  in
            view.nameLab.text = model.name
            view.numLab.text = model.num
        }
    }
}
