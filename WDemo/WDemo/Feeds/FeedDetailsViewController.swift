//
//  FeedDetailsViewController.swift
//  WDemo
//
//  Created by Admin on 14/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Alamofire

class FeedDetailsViewController: UIViewController ,WKNavigationDelegate{
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var feedDetailsWebView: WKWebView!
    var link:String?
    override func viewDidLoad() {
        if (!NetworkReachabilityManager()!.isReachable) {
            let alert = UIAlertController(title: "Error", message: internetError, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if let urlString = link {
            let myRequest = URLRequest(url: URL(string: urlString)!)
            feedDetailsWebView.load(myRequest)
            feedDetailsWebView.navigationDelegate = self
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
