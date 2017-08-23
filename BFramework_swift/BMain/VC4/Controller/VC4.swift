//
//  VC4.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/27.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class VC4: UIViewController {
    
    fileprivate lazy var dissolveFromVC: DissolveFirstVC = DissolveFirstVC()
    fileprivate lazy var bottomFirstVC: BottomFirstVC = BottomFirstVC()
    fileprivate lazy var swipeFirstVC: SwipeFirstVC = SwipeFirstVC()
    
    fileprivate lazy var fromRightFirstVC: FromRightFirstVC = FromRightFirstVC()
    
    fileprivate lazy var topVC: FromTopFirstVC = FromTopFirstVC()
    fileprivate lazy var adaptiveVC : AdaptiveFirstControl = AdaptiveFirstControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.brown
        self.title = "VC4"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func present_Bottom() {
        navigationController?.pushViewController(bottomFirstVC, animated: true)
    }
    
    @IBAction func from_Right() {
        
        navigationController?.pushViewController(fromRightFirstVC, animated: true)
    }
    @IBAction func Dissolve() {
        
        
        navigationController?.pushViewController(dissolveFromVC, animated: true)
        
        
    }
    @IBAction func Swipe() {
        //        navigationController?.pushViewController(swipeFirstVC, animated: true)
        
    }
    
    @IBAction func Top() {
        
        navigationController?.pushViewController(topVC, animated: true)
    }
    
    @IBAction func Adaptive() {
        navigationController?.pushViewController(adaptiveVC, animated: true)
        
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
