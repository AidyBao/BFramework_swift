//
//  MQSildeFilterView.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/13.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

extension MQSideFilterView: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension MQSideFilterView: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GoodsPropertyRootCell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsPropertyRootCell.GoodsPropertyRootCellID, for: indexPath) as! GoodsPropertyRootCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let cell: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell", for: indexPath)
            cell.backgroundColor = UIColor.mq_backgroundColor
            return cell
        }
        return UICollectionReusableView.init()
    }
}

extension MQSideFilterView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 14, bottom: 10, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (MQ_BOUNDS_WIDTH * 0.85 - 14 * 4) / 3.0
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: MQ_BOUNDS_WIDTH * 0.85, height: 30)
    }
    
    
    
}
