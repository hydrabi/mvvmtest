//
//  ModelTableViewCell.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

import UIKit

class ModelTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var tapBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
