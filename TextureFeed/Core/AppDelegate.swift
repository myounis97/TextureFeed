//
//  AppDelegate.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import UIKit
import AsyncDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        
        window?.backgroundColor = .white

        let viewController = FeedViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

