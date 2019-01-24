//
//  CustomTableViewCell.swift
//  Practice
//
//  Created by 신재혁 on 21/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var customTextField: UITextField!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        
//        self.checkLabel.isHidden = false
    }
}
