//
//  CustomCell.swift
//  EngineeringAITest
//
//  Created by Swaminath-Ojas on 15/10/19.
//  Copyright © 2019 Swaminath-Ojas. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var label_CreatedDate: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
