//
//  MQDateSelectUtils.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/26.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

typealias MQDateCallBack = (_ date:Date) -> Void

class MQDateSelectUtils: MQUIViewController {
    
    var date = Date()
    
    var callback:MQDateCallBack?
    var minDate:Date?
    var maxDate:Date?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    static func show(_ at:UIViewController,min:Date?,max:Date?,completion:@escaping MQDateCallBack) {
        let vc = MQDateSelectUtils()
        vc.minDate = min
        vc.maxDate = max
        vc.callback = completion
        at.present(vc, animated: true, completion: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        
        if let minDate = minDate {
            self.datePicker.minimumDate = minDate
        } else {
            self.datePicker.minimumDate = MQDateUtils.beijingDate()
        }
        
        if let maxDate = maxDate {
            self.datePicker.maximumDate = maxDate
        } else {
            self.datePicker.maximumDate = Date()
        }
        self.datePicker.date = Date()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        callback?(date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        self.date = sender.date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MQDateSelectUtils:UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MQDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}


