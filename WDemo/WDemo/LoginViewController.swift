//
//  ViewController.swift
//  WDemo
//
//  Created by Admin on 13/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        if (!NetworkReachabilityManager()!.isReachable) {
            let alert = UIAlertController(title: "Error", message: internetError, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if (userNameField.text == "admin" && passwordField.text == "admin") {
             let feedsTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedsTableViewController") as! FeedsTableViewController
             let navigationController = UINavigationController.init(rootViewController: feedsTableViewController)
            self.present(navigationController, animated: true) { [weak self] in
                self?.saveDataInUserDefault(userName: "admin", password: "admin")
            }
        } else {
            let alert = UIAlertController(title: "Error", message: loginError, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
    }
    
    func saveDataInUserDefault(userName:String, password:String) {
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(password, forKey: "password")
    }
}

