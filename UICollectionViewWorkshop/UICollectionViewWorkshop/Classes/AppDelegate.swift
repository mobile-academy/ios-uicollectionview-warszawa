//
//  AppDelegate.swift
//  UICollectionViewWorkshop
//
//  Created by Maciej Oczko on 29.10.2016.
//  Copyright © 2016 Mobile Academy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var device = UIDevice.current

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        modifyAppearance()
        
        if device.userInterfaceIdiom == .phone {
            
        } else {

        }
        
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        return true
    }


    func modifyAppearance() {
        let workshopBackgroundColor = UIColor.barsBackgroundTint
        let tintColor = UIColor.text

        UINavigationBar.appearance().barTintColor = workshopBackgroundColor
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName : tintColor
        ]

        UITabBar.appearance().barTintColor = workshopBackgroundColor
        UITabBar.appearance().tintColor = tintColor

        UIRefreshControl.appearance().tintColor = tintColor
    }
}

