//
//  CustomCollectionViewCell.swift
//  Practice
//
//  Created by 신재혁 on 21/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customNameLabel: UILabel!
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        
//        self.customNameLabel.isHidden = false
    }
}
