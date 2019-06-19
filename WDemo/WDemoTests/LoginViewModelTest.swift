//
//  LoginViewModelTest.swift
//  WDemoTests
//
//  Created by Admin on 19/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
import WDemo
import SwiftKeychainWrapper
@testable import WDemo


class LoginViewModelTest: XCTestCase {
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testIsUserValid() {
      let isValid =   viewModel.isUserValid(username: "admin", password: "admin")
        XCTAssertEqual(isValid, true)
      let isNotValid =  viewModel.isUserValid(username: "test", password: "test")
        XCTAssertFalse(isNotValid)
    }
    
    func testCredentials() {
       viewModel.saveCredentials(username: "admin", password: "admin")
        let username = KeychainWrapper.standard.string(forKey: KeyConstants.kUsername)
        let password = KeychainWrapper.standard.string(forKey: KeyConstants.kPassword)
        XCTAssertEqual(username, "admin", "Username should match")
        XCTAssertEqual(password, "admin", "password should match")
    }
}
