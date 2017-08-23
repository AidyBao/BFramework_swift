//
//  FromRightSecondVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/28.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class FromRightSecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
        
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize  = CGSize(width: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? self.view.bounds.width - 66 : self.view.bounds.width - 88, height: self.view.bounds.size.height)
    }

}
