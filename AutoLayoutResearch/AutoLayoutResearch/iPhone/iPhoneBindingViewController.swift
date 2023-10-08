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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
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
