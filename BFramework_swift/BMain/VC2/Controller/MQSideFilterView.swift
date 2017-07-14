//
//  MQSideFilterView.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/13.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class MQSideFilterView: UIView {
    
    let animationDuration = 0.35
    var isAnimating = false
    var isTypeFilterShow = false
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableViewGap: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    
    //MARK: - Load
    class func loadNib() -> MQSideFilterView {
        let view: MQSideFilterView = Bundle.main.loadNibNamed(String.init(describing: MQSideFilterView.self), owner: self, options: nil)?.first as! MQSideFilterView
        return view
    }
    
    func show() {
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        //
        self.setCollectionViewUI()
        //
        self.showFilterView(true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
        self.collectionView.width = MQ_BOUNDS_WIDTH*0.85
    }
    
    //MARK: - LoadData
    func loadData(dataArray array: NSMutableArray) {
        
    }
    
    //MARK: - CollectionView
    func setCollectionViewUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: String.init(describing: GoodsPropertyRootCell.self), bundle: nil), forCellWithReuseIdentifier: GoodsPropertyRootCell.GoodsPropertyRootCellID)
        self.collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell")
    }
    
    //MARK: - 显示/隐藏筛选视图
    func showFilterView(_ show: Bool) {
        
        if isTypeFilterShow == show {
            return
        }
        
        if isAnimating {
            return
        }
        
        isAnimating = true
        self.tableViewGap.constant = MQ_BOUNDS_WIDTH
        
        if show {
            self.hideMaskView(false)
            self.tableViewGap.constant = MQ_BOUNDS_WIDTH * 0.15
            UIView.animate(withDuration: animationDuration, animations: {
                self.layoutIfNeeded()
            }, completion: { (finished) in
                self.isAnimating = false
                self.isTypeFilterShow = true
            })
        }else{
            self.hideMaskView(true)
            self.tableViewGap.constant = MQ_BOUNDS_WIDTH
            UIView.animate(withDuration: animationDuration, animations: {
                self.layoutIfNeeded()
            }, completion: { (finished) in
                self.isAnimating = false
                self.isTypeFilterShow = false
            })
        }
    }
    
    //MARK: - 显示/隐藏背景视图
    private func hideMaskView(_ hide:Bool) {
        if self.backView.isHidden == hide {
            return
        }
        if hide {
            UIView.animate(withDuration: animationDuration, animations: {
                self.backView.alpha = 0.0
                self.alpha = 0.0
            }, completion: { (finished) in
                self.backView.isHidden = true
                self.isHidden = true
            })
        }else {
            self.isHidden = false
            self.isHidden = false
            UIView.animate(withDuration: animationDuration, animations: {
                self.backView.alpha = 1.0
            }, completion: { finished in
            })
        }
    }
    
    //MARK: - 右扫手势
    @IBAction func tapTableViewAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizerDirection.right {
            self.showFilterView(false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showFilterView(false)
    }
}
