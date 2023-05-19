//
//  SimpsonsCoordinator.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/18/23.
//

import Foundation
import UIKit

protocol DetailsDelegate: AnyObject {
    func didSelect()
}

class SimpsonsCoordinator: DetailsDelegate {
    
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let splitvc = UISplitViewController(style: .doubleColumn)
        let dataManager = SimpsonsDataManager()
        let viewModel = SimpsonsViewModel(dataManager: dataManager)
        let viewController = SimpsonsListViewController(viewModel: viewModel)
        
        viewController.delegate = self
        
        splitvc.viewControllers = [
            UINavigationController(rootViewController: viewController),
            UINavigationController(rootViewController: UIViewController()),
        ]

        window?.rootViewController = splitvc
    }
    
    func didSelect() {
        
    }
}
