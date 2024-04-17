//
//  AppDelegate.swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomePageModuleBuilder.build()
        let navigationController = NavigationConroller(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

