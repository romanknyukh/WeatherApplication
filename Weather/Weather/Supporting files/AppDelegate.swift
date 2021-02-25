//
//  AppDelegate.swift
//  Weather
//
//  Created by Roman Kniukh on 19.02.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = self.window {
            window.rootViewController = ViewController()
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

