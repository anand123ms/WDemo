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
    var viewModel: LoginViewModel!
    
    let imageArray = [UIImage(named: "login"), UIImage(named: "feeds"), UIImage(named: "feedsDetail") ]
    
    override func viewDidLoad() {
        viewModel = LoginViewModel()
        if UserDefaults.standard.bool(forKey: KeyConstants.kIsFirstLaunch) {
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
        if (viewModel.isUserValid(username: userNameField.text, password: passwordField.text))  {
             let feedsTableViewController = self.viewController(withId: "FeedsTableViewController") as! FeedsTableViewController
             let navigationController = UINavigationController.init(rootViewController: feedsTableViewController)
            self.present(navigationController, animated: true) { [weak self] in
            self?.viewModel.saveCredentials(username: self?.userNameField.text, password: self?.passwordField.text)
            }
        } else {
            self.showAlert(withTitle: AppConstants.kError, message: AppConstants.loginErrorMessage)
            return
        }
    }
}

extension LoginViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
