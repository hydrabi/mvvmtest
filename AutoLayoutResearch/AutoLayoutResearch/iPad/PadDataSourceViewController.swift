//
//  PadDataSourceViewController.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/9/24.
//

import UIKit

class PadDataSourceViewController:UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:DataSource!
    
    lazy var viewModel:ViewModel = {
        return ViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 64
        tableView.separatorStyle = .none
        dataSource = DataSource(viewModel: viewModel, tableView: tableView)
        tableView.reloadData()
    }
}
