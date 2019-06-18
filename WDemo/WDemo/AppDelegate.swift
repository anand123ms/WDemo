//
//  AppDelegate.swift
//  WDemo
//
//  Created by Admin on 13/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //reset keychain data at first time launch
        if !UserDefaults.standard.bool(forKey: KeyConstants.kIsFirstLaunch) {
            KeychainWrapper.standard.removeObject(forKey: KeyConstants.kUsername)
            KeychainWrapper.standard.removeObject(forKey: KeyConstants.kPassword)
            UserDefaults.standard.set(true, forKey: KeyConstants.kIsFirstLaunch)
        }
        
        
        let userName = KeychainWrapper.standard.string(forKey: KeyConstants.kUsername)
        let password = KeychainWrapper.standard.string(forKey: KeyConstants.kPassword)
        
        if userName?.count ?? 0 > 0, password?.count ?? 0 > 0 {
            let feedsTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedsTableViewController") as! FeedsTableViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController.init(rootViewController: feedsTableViewController)
            self.window?.rootViewController = navigationController
        }
        return true
    }
}

