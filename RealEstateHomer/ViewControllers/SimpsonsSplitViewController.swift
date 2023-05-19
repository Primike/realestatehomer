//
//  SimpsonsSplitViewController.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/19/23.
//

import Foundation
import UIKit

class SimpsonsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .oneBesideSecondary
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}
