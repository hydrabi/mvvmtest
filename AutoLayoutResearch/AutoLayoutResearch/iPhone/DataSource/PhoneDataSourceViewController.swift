//
//  PhoneDataSourceViewController.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/9/24.
//

import UIKit

class PhoneDataSourceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:DataSource!
    
    lazy var viewModel:ViewModel = {
        return ViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 64
        tableView.separatorStyle = .none
        dataSource = DataSource(viewModel: viewModel, tableView: tableView)
        tableView.reloadData()
        
        
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
