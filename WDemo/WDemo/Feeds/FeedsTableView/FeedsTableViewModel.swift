//
//  FeedsTableModelView.swift
//  WDemo
//
//  Created by Admin on 14/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire

class FeedsTableViewModel {
    
    var feedsUsecase: FeedsUsecaseType? = FeedsUsecase()
    
    func fetchFeeds(completion: @escaping (_ result: Array<Feed>) -> Void) {
        feedsUsecase?.fetchFeeds(completion: { (result) in
            switch result {
            case .success(let response):
                    completion(response)
            case .error:
                completion([])
            }
        })
    }
}
