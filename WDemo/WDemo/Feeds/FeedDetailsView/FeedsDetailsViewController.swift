//
//  FeedsDetailsViewController.swift
//  WDemo
//
//  Created by Admin on 14/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Alamofire

class FeedsDetailsViewController: UIViewController ,WKNavigationDelegate {
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var feedsDetailsWebView: WKWebView!
    var link:String?
    
    override func viewDidLoad() {
        self.title = AppConstants.feedsDetailsTitle
        guard let isReachable = NetworkReachabilityManager()?.isReachable, isReachable == true else {
            self.showAlert(withTitle: AppConstants.kError, message: AppConstants.internetErrorMessage)
            return
        }
        
        if let urlString = link, let url = URL(string: urlString) {
            let myRequest = URLRequest(url: url)
            feedsDetailsWebView.load(myRequest)
            feedsDetailsWebView.navigationDelegate = self
            activeIndicator.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activeIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activeIndicator.stopAnimating()
    }
}
