//
//  GoodsPropertyRootCell.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/14.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class GoodsPropertyRootCell: UICollectionViewCell {
    
    static let GoodsPropertyRootCellID: String = "GoodsPropertyRootCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.groupTableViewBackground
        self.layer.cornerRadius = 3.0
        self.layer.masksToBounds = true
    }
}
