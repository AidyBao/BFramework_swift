//
//  MQQRCodeScanViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import AVFoundation

protocol MQScanCodeDelegate:class {
    func mqScanCode(resultString:String?,jsonValue:Any?,control callBack:((_ code:Int,_ success:Bool,_ msg:String) -> Void)?)
}

class MQQRCodeScanViewController: MQUIViewController {

    weak var delegate:MQScanCodeDelegate?
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTipsInfo: UILabel!
    @IBOutlet weak var scanFrame: UIView!
    
    //Animation Layer
    var animationImage:UIImageView?
    var session:AVCaptureSession?
    
    //
    var checking = false
    var isScanAction = true
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
        self.fd_prefersNavigationBarHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not init")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.scanFrame.backgroundColor = UIColor.clear
        self.lbTitle.font = UIFont.mq_titleFont(MQNavBarConfig.titleFontSize)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.s_enterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.s_enterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        
        self.lbTitle.text = "二维码"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkAuthorization { (status) in
            if status == .authorized || status == .notDetermined {
                self.beginScanning()
            }else{
                MQHUD.showFailure(in: self.view, text: "未授权,无法使用相机", delay: MQ_DELAY_INTERVAL)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopScan()
    }
    
    
    func s_enterBackground() {
        self.animationImage?.layer.timeOffset = CACurrentMediaTime()
    }
    
    func s_enterForeground() {
        self.resumeAnimation()
    }
    
    //返回
    @IBAction func backAction(_ sender: Any) {
        self.dismissAction()
    }
}

extension MQQRCodeScanViewController {
    func checkAuthorization(completion:((_ status:AVAuthorizationStatus) -> Void)?) {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch status {
        case .authorized:
            completion?(.authorized)
        case .denied:
            completion?(.denied)
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                DispatchQueue.main.async {
                    if granted{
                        completion?(.authorized)
                    }else {
                        completion?(.denied)
                    }
                }
            })
        case .restricted:
            completion?(.restricted)
        }
    }
    
    func stopScan() {
        if let session = self.session,session.isRunning {
            session.stopRunning()
        }
        self.animationImage?.layer.removeAllAnimations()
    }
    
    func restartScan() {
        if let session = session {
            if session.isRunning {return}
            session.startRunning()
            self.resumeAnimation()
        }
    }
    
    func resumeAnimation() {
        if let image = animationImage {
            if image.layer.animation(forKey: "translationAnimation") != nil {
                let pauseTime = image.layer.timeOffset
                let beginTime = CACurrentMediaTime() - pauseTime
                image.layer.timeOffset = 0
                image.layer.beginTime = beginTime
                image.layer.speed = 1.0
            }else {
                let scanNetImageViewH = self.scanFrame.frame.size.height
                let scanNetImageViewW = self.scanFrame.frame.size.width
                self.animationImage?.frame = CGRect(x: 0, y: -scanNetImageViewH, width: scanNetImageViewW, height: scanNetImageViewH)
                let scanNetAnimation = CABasicAnimation()
                scanNetAnimation.keyPath = "transform.translation.y"
                scanNetAnimation.byValue = (scanNetImageViewH)
                scanNetAnimation.duration = 1.0
                scanNetAnimation.repeatCount = MAXFLOAT
                self.animationImage?.layer.add(scanNetAnimation, forKey: "translationAnimation")
                if let image = self.animationImage {
                    self.scanFrame.addSubview(image)
                }
            }
        }
    }
    
    func beginScanning() {
        if session == nil {
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            do {
                let input = try AVCaptureDeviceInput.init(device: device)
                let output = AVCaptureMetadataOutput()
                //设置代理 在主线程里刷新
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                //设置有效扫描区域
                let scanCrop = self.getScanCrop(toRect: self.scanFrame.frame, readerViewBounds: self.view.bounds)
                //设置扫描范围CGRectMake(Y,X,H,W),1代表最大值 右上角基准
                output.rectOfInterest = scanCrop
                //
                self.session = AVCaptureSession()
                self.session?.sessionPreset = AVCaptureSessionPresetHigh
                self.session?.addInput(input)
                self.session?.addOutput(output)
                output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode]
                
                if let layer = AVCaptureVideoPreviewLayer.init(session: self.session!) {
                    layer.videoGravity = AVLayerVideoGravityResizeAspectFill
                    layer.frame = self.view.bounds
                    self.view.layer.insertSublayer(layer, at: 0)
                }
                //添加漏空遮罩层
                self.addMaskLayer()
            } catch  {
                MQAlertUtils.showAlert(withTitle: "提示", message: "相机不可用")
                return
            }
        }
        self.restartScan()
    }
    //MARK: - 漏空遮罩层
    fileprivate func addMaskLayer() {
        let maskLayer = CALayer()
        maskLayer.frame = UIScreen.main.bounds
        maskLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        let empty = CAShapeLayer()
        let frame = self.scanFrame.frame
        let path = UIBezierPath(roundedRect: self.view.bounds, cornerRadius: 0)
        path.append(UIBezierPath(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height), cornerRadius: 0).reversing())
        empty.path = path.cgPath
        maskLayer.mask = empty
        self.view.layer.insertSublayer(maskLayer, below: self.lbTipsInfo.layer)
        self.animationImage = UIImageView.init(image: #imageLiteral(resourceName: "scan_net"))
    }
    
    //MARK: - 获取扫描框比例关系
    fileprivate func getScanCrop(toRect rect:CGRect,readerViewBounds bounds:CGRect) -> CGRect {
        let x = rect.origin.y / bounds.size.height
        let y = (bounds.size.width - rect.size.width) / 2 / bounds.size.width
        let width = rect.size.height / bounds.size.height
        let height = rect.size.width / bounds.size.width
        return CGRect(x: x, y: y, width: width, height: height)//(Y, X, W, H)
    }
    
    func dismissAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func show(at vc:UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            self.checkAuthorization { (status) in
                if status == .authorized || status == .notDetermined {
                    if vc.navigationController != nil {
                        vc.navigationController?.pushViewController(self, animated: true)
                    }else{
                        vc.present(self, animated: true, completion: nil)
                    }
                }else{
                    if status == .denied {
                        MQAlertUtils.showAlert(wihtTitle: "提示", message: "您阻止了相机访问权限,请在设置中开启", buttonTexts: ["取消","马上打开"], action: { (index) in
                            if index == 1 {
                                MQCommonUtils.openURL(UIApplicationOpenSettingsURLString)
                            }
                        })
                    }else{
                        MQHUD.showFailure(in: vc.view, text: "相机功能被禁用", delay: MQ_DELAY_INTERVAL)
                    }
                }
            }
        }else{
            MQHUD.showFailure(in: vc.view, text: "相机功能不可用", delay: MQ_DELAY_INTERVAL)
        }
    }
}
//MARK: - MetadataOutputDelegate
extension MQQRCodeScanViewController: AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if checking {
            return
        }
        checking = true
        self.stopScan()
        if metadataObjects.count > 0 {
            if let metaDataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                let result = metaDataObject.stringValue ?? ""
                if let delegate = delegate {

                    if self.navigationController != nil {
                        self.navigationController?.popViewController(animated: false)
                    }else{
                        self.dismiss(animated: false, completion: nil)
                    }
                    delegate.mqScanCode(resultString: result, jsonValue: result.mj_JSONObject(), control: nil)
                }
            }else {
                self.restartScan()
                checking = false
            }
        }else {
            self.restartScan()
            checking = false
        }
    }
}
