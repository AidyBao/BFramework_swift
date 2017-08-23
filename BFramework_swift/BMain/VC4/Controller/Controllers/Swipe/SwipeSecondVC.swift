//
//  SwipeSecondVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/28.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class SwipeSecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
        
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize  = CGSize(width: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? self.view.bounds.width - 66 : self.view.bounds.width - 88, height: self.view.bounds.size.height)
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
