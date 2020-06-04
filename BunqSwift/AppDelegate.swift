//
//  AppDelegate.swift
//  BunqSwift
//
//  Created by Taha Darendeli on 31.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *) {
            print("SceneDelegate handles after iOS 13.")
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let viewController = ViewController()
            window?.rootViewController = viewController
            window?.backgroundColor = UIColor.white
            window?.makeKeyAndVisible()
        }
        
        return true
    }
}

