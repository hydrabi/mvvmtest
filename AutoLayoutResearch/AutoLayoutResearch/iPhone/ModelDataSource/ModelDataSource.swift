//
//  ModelDataSource.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

struct CellModel {
    var name:String = ""
    var num:Int = 0
}

struct CellSectionModel<Section,ItemType> {
    var model:Section
    var items:[ItemType]
    
    init(model: Section, items: [ItemType]) {
        self.model = model
        self.items = items
    }
}

extension CellSectionModel:SectionModelType {
    init(original: CellSectionModel<Section, ItemType>, items: [ItemType]) {
        self.model = original.model
        self.items = items
    }
    
//    public typealias Identity = Section
    public typealias Item = ItemType
    
//    public var identity: Section {
//        model
//    }
    
}

extension Reactive where Base:UITableViewCell {
    public var reuseBag:DisposeBag {
        //主线程中运行
        MainScheduler.ensureExecutingOnScheduler()
        
        var prepareFroReuseBag:Int8 = 0
        
        //动态获取属性bag
        if let bag = objc_getAssociatedObject(base, &prepareFroReuseBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        //动态添加属性bag
        objc_setAssociatedObject(base,
                                 &prepareFroReuseBag,
                                 bag,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        //当cell重用
        _ = sentMessage(#selector(Base.prepareForReuse))
            .subscribe(onNext:{ [weak base] _ in
                let newBag = DisposeBag()
                guard let base = base else {return}
                objc_setAssociatedObject(base,
                                         &prepareFroReuseBag,
                                         newBag,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            })
        
        return bag
    }
}

class ModelDataSourceViewController:UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    
    lazy var dataSource:RxTableViewSectionedReloadDataSource<CellSectionModel<String,CellModel>> = {
        return RxTableViewSectionedReloadDataSource { ds, tableView, indexPath, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ModelTableViewCell.self)) as! ModelTableViewCell
            cell.nameLab.text = element.name
            cell.numLab.text = "\(element.num)"
            cell.tapBtn.rx.tap.subscribe(onNext:{
                
            }).disposed(by: cell.rx.reuseBag)
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.just([
            CellSectionModel(model: "First", items: [
                CellModel(name: "Ted",num: 1),
                CellModel(name: "Barney",num: 2)
            ])
        ])
        
        let nib = UINib(nibName: String(describing: ModelTableViewCell.self),
                        bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: ModelTableViewCell.self))
        
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext:{
            [weak self] indexPath in guard let strongSelf = self else { return }
            let model = strongSelf.dataSource[indexPath]
            
            let alertView = UIAlertController(title: "Tips", message: "\(model.name),\(model.num)", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            })
            strongSelf.present(alertView, animated: true)
        }).disposed(by: disposeBag)
    }
}
