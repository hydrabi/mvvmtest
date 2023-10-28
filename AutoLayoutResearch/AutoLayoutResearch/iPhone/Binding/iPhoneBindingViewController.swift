//
//  iPhoneBindingViewController.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/9/30.
//

import UIKit
import RxSwift
import RxCocoa
class iPhoneBindingViewController: UIViewController {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var delegateProxyBtn: UIButton!
    
    var viewModel = iPhoneBindingViewModel()
    
    var customView = iPhoneBindingView()
    
    var proxyModel:DelegateProxyExplantion? = nil
    
    var nextBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("next", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(64)
            make.height.equalTo(100)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        bindViewModel()

    }
    

    func bindViewModel() {
        
        viewModel.observable
            .bind(to: customView.rx.value)
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext:{
            [weak self] _ in guard let strongSelf = self else { return }
            strongSelf.viewModel.nextModel()
        }).disposed(by: disposeBag)
        
        delegateProxyBtn.rx.tap.subscribe(onNext:{
            [weak self] _ in guard let strongSelf = self else { return }
            strongSelf.proxyModel = DelegateProxyExplantion()
        }).disposed(by: disposeBag)
        
        let textObserval = textField.rx.text.orEmpty.asDriver().throttle(.milliseconds(300))
        
        textField.rx.text.orEmpty.subscribe(onNext:{
            print($0)
        }).disposed(by: disposeBag)
        
        textObserval.drive(titleLab.rx.text).disposed(by: disposeBag)
        textObserval.map { $0.count >= 6 }.drive(confirmBtn.rx.isEnabled).disposed(by: disposeBag)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
