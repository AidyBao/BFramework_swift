//
//  VC1.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/27.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

let code1 = "\u{e600}"
let code2 = "\u{e612}"
let code3 = "\u{e613}"
let code4 = "\u{e616}"

class VC1: UIViewController {
    
    @IBOutlet weak var fontAndColorBtn: MQUIButton!
    @IBOutlet weak var lbMark: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var txtF: UITextField!
    @IBOutlet weak var countDownLB: MQCountDownLabel!
    
    var type = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.title = "VC1"
        
        //
        self.mq_addKeyboardNotification()
        //
//        self.requestForUserLogin()
    }
    
    //MARK: - 分段控制器视图
    @IBAction func testSegmentView(_ sender: UIButton) {
        let testVC: Test01Controller = Test01Controller.init()
        testVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    //MARK: - 播放声音
    @IBAction func playSound(_ sender: UIButton) {
        
        let index = type % 3
        switch index {
        case 0:
            //MARK: - Check Location
            MQAudioUtils.vibrate()
        case 1:
            MQAudioUtils.play(forResource: "soundA.caf", ofType:nil)
        case 2:
            MQAudioUtils.play(withId: 1016)
        default: break
            
        }
        type += 1
        type = type % 100

    }
    
    @IBAction func font(_ sender: MQUIButton) {
        //Main UI Color
        self.view.backgroundColor = UIColor.mq_backgroundColor
        
        self.fontAndColorBtn.backgroundColor = UIColor.mq_tintColor
        self.fontAndColorBtn.layer.borderWidth = 3
        self.fontAndColorBtn.layer.borderColor = UIColor.mq_borderColor.cgColor
        
        //Text Color
        self.lbTitle.textColor  = UIColor.mq_textColorTitle //Title Color
        self.lbBody.textColor   = UIColor.mq_textColorBody  //Body Color
        self.lbMark.textColor   = UIColor.mq_textColorMark  //Mark Color
        
        //Font
        self.lbTitle.font   = UIFont.mq_titleFont           //Title Font
        self.lbBody.font    = UIFont.mq_bodyFont            //Body Font
        self.lbMark.font    = UIFont.mq_markFont            //Mark Text Font
        //self.lbTitle.font   = UIFont.mq_bodyFont(14)
        self.lbTitle.font    = UIFont.mq_iconFont(30)    //Iconfont
        //self.lbIconFont.font    = UIFont(name: UIFont.mq_iconFontName, size: 30)
        //self.lbIconFont.font    = UIFont.mq_iconFont //默认正文字体大小
        self.lbTitle.text        =   "IconFont,\(code1)"
        self.lbTitle.textColor   =   UIColor.mq_customCColor
        
        self.mq_clearNavbarBackButtonTitle()
        
        //Add Bar Button Item
        self.mq_navbarAddBarButtonItems(iconFontTexts: [code2,code3], fontSize: 30, color: UIColor.orange, at: .left)
        self.mq_navbarAddBarButtonItems(textNames: ["Call"], font: nil, color: UIColor.white, at: .right)
    }
    
    @IBAction func mapAndAlert(_ sender: UIButton) {
        let testVC: MapViewController = MapViewController.init()
        testVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    @IBAction func getUserLogin(_ sender: UIButton) {
        let user = ZXUser.user
        print(user.userSex ?? "")
    }
    
    //MARK: - 获取并清除缓存
    @IBAction func getAndClearCache(_ sender: Any) {
        //获取缓存
        print(MQCache.returnCacheSize())
        
        //清除缓存
        MQCache.cleanCache {}
    }
    
    //MARK: - AppStore评分
    @IBAction func storeReview(_ sender: Any) {
        let Appstore_ID = "" //替换为对应的APPID
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            let nsStringToOpen:String = String.init(format: "itms-apps://itunes.apple.com/app/id%@?action=write-review", Appstore_ID)//替换为对应的APPID
            UIApplication.shared.openURL(URL.init(string: nsStringToOpen)!)
        }
    }
    
    //MARK: - 倒计时
    @IBAction func mqCoundown(_ sender: UIButton) {
        if countDownLB == nil {
            countDownLB = MQCountDownLabel(frame: CGRect.zero)
            countDownLB.maxSecond = 5
            countDownLB.prefix = "倒计时"
        }
        countDownLB.start()
        countDownLB.countDownCompleteClosure = { [unowned self] in
            //
            if self.countDownLB != nil {
            }
        }
    }
    
    
    //MARK: - Left Bar Button Action
    override func mq_leftBarButtonAction(index: Int) {
        print("Left Action At Index:\(index)")
    }
    //MARK: Right Bar Button Action
    override func mq_rightBarButtonAction(index: Int) {
        print("Right Action At Index:\(index)")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - KeyBoard Notice
    override func mq_keyboardWillShow(duration dt: Double, userInfo: Dictionary<String, Any>) {
        print("Show Animation Duration:\(dt)")
    }
    
    override func mq_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        print("Hide Animation Duration:\(dt)")
    }
    
    override func mq_keyboardWillChangeFrame(beginRect: CGRect, endRect: CGRect, duration dt: Double, userInfo: Dictionary<String, Any>) {
        print("BeginRect:\(beginRect) EndRect:\(endRect)")
    }
    
    
    deinit {
        self.mq_removeKeyboardNotification()
    }
}

//MARK: - HTTP
extension VC1 {
    //MARK: - 登录
    func requestForUserLogin() {
        var params = Dictionary<String,Any>.init()
        params["userName"] = "waibu"
        params["passWord"] = "123456"
        //params.mq_signDic() 签名
        MQNetwork.asyncRequest(withUrl: MQAPI.api(address: ZXAPIConst.User.telLogin), params: params, method: .post) { (success, status, content, stringValue, error) in
            if success {
                if status == ZXAPI_SUCCESS {
                    if let data = content["data"] as? Dictionary<String,Any> {
                        
                        
                        let model = ZXUserModel.deserialize(from: data)
                        //保存用户登录信息
                        ZXUser.user.save(data)
                        //友好提示
                        MQHUD.showSuccess(in: self.view, text: "登录成功", delay: ZX.HUDDelay)
                    }
                }else{
                    MQHUD.showFailure(in: self.view, text: "登录失败", delay: ZX.HUDDelay)
                }
            }else if status != ZXAPI_LOGIN_INVALID {
                //
                MQHUD.showFailure(in: self.view, text: (error?.description)!, delay: ZX.HUDDelay)
                //没有网络
                MQEmptyView.show(in: self.view, below: nil, type: .networkError, text: "没有网络", subText:  "", topOffset: 10, retry: {
                    self.requestForUserLogin()
                    MQEmptyView.hide(from: self.view)
                })
            }
        }
    }
}
