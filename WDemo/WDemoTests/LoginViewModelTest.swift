//
//  LoginViewModelTest.swift
//  WDemoTests
//
//  Created by Admin on 19/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
import WDemo
@testable import WDemo


class LoginViewModelTest: XCTestCase {
    var viewModel: LoginViewModel!
    
    override func setUp() {
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
    
    func testSaveData() {
     let isSaved = viewModel.saveCredentials(username: "admin", password: "admin")
        XCTAssertEqual(isSaved, true)
     let isNotSaved = viewModel.saveCredentials(username: "", password: "admin")
        XCTAssertFalse(isNotSaved)
    }
}
