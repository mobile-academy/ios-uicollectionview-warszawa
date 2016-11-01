//
//  Copyright © 2016 Mobile Academy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var device = UIDevice.current

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let configuration = ConfigurationFactory().applicationConfiguration()
        Configurator().configureApplication(configuration: configuration, launchOptions: launchOptions)
        modifyAppearance()
        return true
    }
}

extension AppDelegate {
    fileprivate func modifyAppearance() {
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

