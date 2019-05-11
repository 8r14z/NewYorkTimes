//
//  AppDelegate.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()

        let homeViewController = HomeRouter.makeHomeView()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

