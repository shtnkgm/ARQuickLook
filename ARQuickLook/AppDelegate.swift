//
//  AppDelegate.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2018/07/11.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ListViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

