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
    var coordinator: SimpsonsCoordinator?
    var urlString: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let configurationPlistPath = Bundle.main.path(forResource: Bundle.main.infoDictionary?["CONFIGURATION_PLIST"] as? String, ofType: "plist"),
           let configuration = NSDictionary(contentsOfFile: configurationPlistPath),
           let url = configuration["url"] as? String {
            self.urlString = url
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        
        coordinator = SimpsonsCoordinator(window: window, urlString: urlString)
        
        self.window = window
        
        coordinator?.start()
        
        return true
    }

}

