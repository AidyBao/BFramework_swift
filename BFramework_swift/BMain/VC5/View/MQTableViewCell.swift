//
//  MQTableViewCell.swift
//  MQCountDownCell
//
//  Created by 120v on 2018/9/14.
//  Copyright © 2018年 MQ. All rights reserved.
//

import UIKit

typealias MQTableViewCellCallBack = (MQTimeModel) -> Void

class MQTableViewCell: UITableViewCell {
    
    static let MQTableViewCellID = "MQTableViewCell"
    
    @IBOutlet weak var timeLB: UILabel!
    var zxFCallBack: MQTableViewCellCallBack?
    var model: MQTimeModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.countDownNotification), name: .ZXCountDownNotification, object: nil)
        
    }
    
    func zx_loadData(_ model: MQTimeModel?, _ idx:Int) {
        if let mod = model {
            self.model = mod
            if let time = mod.timeInterval {
                if time > 0 {//不能陪小象玩
                    if time < 180 {//显示倒计时

                    }else{//不显示倒计时

                    }
                }else{//可以陪小象玩

                }
            }
        }
    }
    
    @objc private func countDownNotification() {
        if let mod = self.model {
                if mod.timeOut == true {
                    return
                }
                // 计算倒计时
                let timeInterval: Int
                if mod.countDownSource == nil {
                    timeInterval = ZXCountDownManager.share.timeInterval
                }else {
                    timeInterval = ZXCountDownManager.share.timeIntervalWithIdentifier(identifier: mod.countDownSource!)
                }
                if let time = mod.timeInterval {
                    let countDown = Int(time) - timeInterval
                    if (countDown <= 0) {
                        mod.timeOut = true
                        if self.zxFCallBack != nil {
                            self.zxFCallBack?(mod)
                        }
                        return;
                    }
                    self.timeLB.text = String(format: "%02d分%02d秒", (countDown/60)%60, countDown%60)
                }
            }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
