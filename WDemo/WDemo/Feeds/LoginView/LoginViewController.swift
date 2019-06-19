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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var walkthroughView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let imageArray = [UIImage(named: "login"), UIImage(named: "feeds"), UIImage(named: "feedsDetail") ]
    
    struct DefaultUserCredentials {
        static let username = "admin"
        static let password = "admin"
    }
    
    override func viewDidLoad() {
        if !UserDefaults.standard.bool(forKey: KeyConstants.kFirstTimeLogin) {
            walkthroughView.isHidden = false
            walkthroughScreens()
            pageControl.currentPage = 0
            pageControl.numberOfPages = imageArray.count
            scrollView.delegate = self
        }
    }
    
    func walkthroughScreens() {
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            let xPosition = scrollView.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
    }
    
    @IBAction func endEditing(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func getStarted(_ sender: UIButton) {
        walkthroughView.isHidden = true
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
            UserDefaults.standard.set(true, forKey: KeyConstants.kFirstTimeLogin)
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

extension LoginViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
