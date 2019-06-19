//
//  LoginViewModel.swift
//  WDemo
//
//  Created by Admin on 19/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol LoginViewModelType {
    func saveCredentials(username: String?, password: String?)
    func isUserValid(username: String?, password: String?) -> Bool
}

class LoginViewModel {
    
    struct DefaultUserCredentials {
        static let username = "admin"
        static let password = "admin"
    }
    
    func saveCredentials(username: String?, password: String?) -> Bool {
        if let usernameString = username, usernameString.count > 0, let passwordString = password, passwordString.count > 0 {
            KeychainWrapper.standard.set(usernameString, forKey: KeyConstants.kUsername)
            KeychainWrapper.standard.set(passwordString, forKey: KeyConstants.kPassword)
            return true
        }
        return false
    }
    
    func isUserValid(username: String?, password: String?) -> Bool {
        if (username == DefaultUserCredentials.username && password == DefaultUserCredentials.password) {
            return true
        }
        return false
    }
}
