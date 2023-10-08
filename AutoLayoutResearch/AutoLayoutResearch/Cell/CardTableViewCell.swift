//
//  CardTableViewCell.swift
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/9/24.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
