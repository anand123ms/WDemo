//
//  ViewController.swift
//  WDemo
//
//  Created by Admin on 13/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    struct DefaultUserCredentials {
        static let username = "admin"
        static let password = "admin"
    }
    
    @IBAction func endEditing(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let isReachable = NetworkReachabilityManager()?.isReachable, isReachable == true else {
            self.showAlert(withTitle: AppConstants.kError, message: AppConstants.internetErrorMessage)
            return
        }
        
        if (userNameField.text == DefaultUserCredentials.username && passwordField.text == DefaultUserCredentials.password)  {
             let feedsTableViewController = self.viewController(withId: "FeedsTableViewController") as! FeedsTableViewController
             let navigationController = UINavigationController.init(rootViewController: feedsTableViewController)
            self.present(navigationController, animated: true) { [weak self] in
                self?.saveCredentials(username: self?.userNameField.text, password: self?.passwordField.text)
            }
        } else {
            self.showAlert(withTitle: AppConstants.kError, message: AppConstants.loginErrorMessage)
            return
        }
    }
    
    func saveCredentials(username: String?, password: String?) {
        if let usernameString = username, let passwordString = password {
            KeychainWrapper.standard.set(usernameString, forKey: KeyConstants.kUsername)
            KeychainWrapper.standard.set(passwordString, forKey: KeyConstants.kPassword)
        }
    }
}

