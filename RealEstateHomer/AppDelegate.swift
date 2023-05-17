//
//  AppDelegate.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        
        let viewModel = SimpsonsViewModel(dataManager: SimpsonsDataManager())
    
        window.rootViewController = SimpsonsViewController(viewModel: viewModel)
        self.window = window
        
        return true
    }

}

