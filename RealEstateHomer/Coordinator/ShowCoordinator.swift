//
//  ShowCoordinator.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/18/23.
//

import Foundation
import UIKit

class ShowCoordinator {
    
    var window: UIWindow?
    var splitVC: UISplitViewController
    var urlString: String?

    init(window: UIWindow?, urlString: String?) {
        self.window = window
        self.urlString = urlString
        self.splitVC = ShowSplitViewController()
    }
    
    func start() {
        guard let urlString = urlString else {
            print("Error: url is nil")
            return
        }
        
        let dataManager = ShowDataManager()
        let viewModel = ShowViewModel(dataManager: dataManager, urlString: urlString)
        let simpsonsListVC = PersonalityListViewController(viewModel: viewModel)
        simpsonsListVC.coordinator = self
        
        splitVC.viewControllers = [
            UINavigationController(rootViewController: simpsonsListVC),
            UINavigationController(rootViewController: UIViewController()),
        ]

        window?.rootViewController = splitVC
    }
    
    func didSelectRow(personality: Personality) {
        let detailsViewModel = DetailsViewModel(personality: personality)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        let detailsNavController = UINavigationController(rootViewController: detailsViewController)
        splitVC.showDetailViewController(detailsNavController, sender: self)
    }
}
