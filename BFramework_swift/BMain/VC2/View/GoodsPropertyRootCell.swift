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
        self.layer.cornerRadius = self.height/2.0
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.height/2.0
    }
}
