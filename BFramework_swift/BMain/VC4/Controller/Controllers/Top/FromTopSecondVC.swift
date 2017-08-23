//
//  FromTopSecondVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class FromTopSecondVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
    }
    
    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width * 0.65, height: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? 270 : 270);
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
