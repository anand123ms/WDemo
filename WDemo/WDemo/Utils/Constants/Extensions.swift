//
//  Extensions.swift
//  WDemo
//
//  Created by Admin on 18/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle: String, message: String) {
        let alert = UIAlertController(title:withTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppConstants.kOk, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func viewController(withId: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: withId)
    }
}
