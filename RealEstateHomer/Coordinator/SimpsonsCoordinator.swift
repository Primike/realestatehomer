//
//  SimpsonsCoordinator.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/18/23.
//

import Foundation
import UIKit

class SimpsonsCoordinator {
    
    var window: UIWindow?
    var splitVC: UISplitViewController
    var urlString: String?

    init(window: UIWindow?, urlString: String?) {
        self.window = window
        self.urlString = urlString
        self.splitVC = SimpsonsSplitViewController()
    }
    
    func start() {
        guard let urlString = urlString else { return }
        
        let dataManager = SimpsonsDataManager()
        let viewModel = SimpsonsViewModel(dataManager: dataManager, urlString: urlString)
        let simpsonsListVC = SimpsonsListViewController(viewModel: viewModel)
        simpsonsListVC.coordinator = self
        
        splitVC.viewControllers = [
            UINavigationController(rootViewController: simpsonsListVC),
            UINavigationController(rootViewController: UIViewController()),
        ]

        window?.rootViewController = splitVC
    }
    
    func didSelectRow(simpson: Simpson) {
        //maybe not init a new one
        let detailsViewModel = DetailsViewModel(simpson: simpson)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        let detailsNavController = UINavigationController(rootViewController: detailsViewController)
        splitVC.showDetailViewController(detailsNavController, sender: self)
    }
}
