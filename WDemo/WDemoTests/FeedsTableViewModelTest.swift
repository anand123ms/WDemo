//
//  FeedsTableViewModelTest.swift
//  WDemoTests
//
//  Created by Admin on 17/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import WDemo

class FeedsTableViewModelTest: XCTestCase {
    var viewModel: FeedsTableViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = FeedsTableViewModel()
        viewModel.feedsUsecase = FeedsUsecaseMock()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testfetchFeeds() {
        let exp = expectation(description: "Feeds data fetch successfully")
        viewModel.fetchFeeds { feedsArray in
            if feedsArray.count > 0 {
                 exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5) { (error) in
            guard let error = error else { return }
            XCTFail("\(error)")
        }
    }
}
