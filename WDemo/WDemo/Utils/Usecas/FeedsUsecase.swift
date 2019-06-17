//
//  FeedsUsecase.swift
//  WDemo
//
//  Created by Admin on 17/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire

protocol FeedsUsecaseType: class {
   func fetchFeeds(completion: @escaping (_ result: ResultSet<[Feed]>) -> Void)
}

class FeedsUsecase: FeedsUsecaseType {
    func fetchFeeds(completion: @escaping (ResultSet<[Feed]>) -> Void) {
        Alamofire.request(url).responseJSON { [weak self]response in
            if let data = response.data {
                XMLConverter.convertXMLData(data, completion: { (flag,  dictionary, error) in
                    if (error != nil) {
                        completion(.error)
                    }
                    
                    var nsmutableDictionary = dictionary
                    if (NetworkReachabilityManager()!.isReachable) {
                        if let datsDictionary = nsmutableDictionary {
                            self?.saveDataOffline(data: datsDictionary)
                        }
                    } else {
                        nsmutableDictionary = self?.reterviewData()
                    }
                    
                    let channel = (((nsmutableDictionary?.value(forKey: "rss") as? NSDictionary)?.value(forKey: "channel") as? NSDictionary) as? NSDictionary)?.value(forKey: "item")
                    var feedsArray = [Feed]()
                    let feedsItemsArray = (channel as? NSArray) ?? []
                    if feedsItemsArray.count > 0 {
                        for item in (channel as? NSArray) ?? [] {
                            let itemDict = item as? NSDictionary
                            var feedObj = Feed()
                            feedObj.title = itemDict?.value(forKey: "title") as? String ?? ""
                            feedObj.description = itemDict?.value(forKey: "description") as? String ?? ""
                            feedObj.link = itemDict?.value(forKey: "link") as? String ?? ""
                            
                            let url = ((itemDict?.value(forKey: "enclosure") as? NSDictionary)?.value(forKey: "-url") as? String) ?? ""
                            let enclosure = Enclosure(url: url)
                            feedObj.enclosure = enclosure
                            feedsArray.append(feedObj)
                        }
                    completion(.success(feedsArray))
                        
                    } else {
                            completion(.success([]))
                    }
                })
            }
        }
    }
    
    func getFeedsFilePath() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/feeds.plist")
        return path
    }
    
    func saveDataOffline(data: NSMutableDictionary?) {
        let pathFile = getFeedsFilePath()
        data?.write(toFile: pathFile, atomically: true)
    }
    
    func reterviewData() -> NSMutableDictionary? {
        return NSMutableDictionary(contentsOfFile: getFeedsFilePath())
    }
    
}

