//
//  DataSource.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class DataSource {
    
    weak var viewModel:ViewModel!
    
    weak var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    

    required init (viewModel:ViewModel,tableView:UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
        registerCell(classType: CardTableViewCell.self, identifier: String(describing: CardTableViewCell.self))
        bindViewModel(classType: CardTableViewCell.self, identifier: String(describing: CardTableViewCell.self))
    }

    /// 为UITableView注册指定类型的cell
    /// - Parameters:
    ///   - classType: cell的类型
    ///   - identifier: cell的唯一标识
    func registerCell(classType:AnyClass,identifier:String) {
        let className = String(describing: classType)
        let nib = UINib(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func bindViewModel(classType:AnyClass,identifier:String) {
        
        viewModel.dataSourceObservable.bind(to: tableView.rx.items(cellIdentifier: String(describing: CardTableViewCell.self),
                                                                   cellType: CardTableViewCell.self)) { [weak self] row, text, cell in guard let strongSelf = self else {return}
            
            
            cell.titleLab.text = text
        }
        .disposed(by: disposeBag)
    }
}

