//
//  FeedsTableViewModelTest.swift
//  WDemoTests
//
//  Created by Admin on 17/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import WDemo
@testable import WDemo

class FeedsUsecaseMock: FeedsUsecaseType {
    
    func fetchFeeds(completion: @escaping (ResultSet<[Feed]>) -> Void) {
        
        let jsonString = """
        [{"title ":"Fin24.com | MTN faces new Nigeria headache as local unit probed over listing ","description ":"MTN’s Nigeria listing is being investigated by local authorities, the latest in a series of disputes in the wireless carrier’s largest market. ","link ":"https://www.fin24.com/Companies/ICT/mtn-faces-new-nigeria-headache-as-local-unit-probed-over-listing-20190525 ","pubDate ":"Sat, 25 May 2019 13:59:47 +0200 ","enclosure ":{"@url ":"https://scripts.24.co.za/img/sites/fin24.png ","@length ":"1 "}},{"title ":"Fin24.com | The Tesla stock bubble has burst, sparking existential questions ","description ":"For Elon Musk and Tesla, the blows from Wall Street came one after another this week - a relentless barrage that left the stock so beat up that some now wonder if it can ever regain its status as the ultimate 21st century disrupter. ","link ":"https://www.fin24.com/Companies/ICT/the-tesla-stock-bubble-has-burst-sparking-existential-questions-20190525 ","pubDate ":"Sat, 25 May 2019 11:05:28 +0200 ","enclosure ":{"@url ":"https://scripts.24.co.za/img/sites/fin24.png ","@length ":"1 "}},{"title ":"Fin24.com | Microsoft pulls Huawei products from one of its cloud server catalogues ","description ":"Microsoft has removed Huawei from one of its websites offering cloud gear, a week after the US government blacklisted the Chinese company. ","link ":"https://www.fin24.com/Companies/ICT/microsoft-pulls-huawei-products-from-one-of-its-cloud-server-catalogues-20190524 ","pubDate ":"Fri, 24 May 2019 10:53:40 +0200 ","enclosure ":{"@url ":"https://scripts.24.co.za/img/sites/fin24.png ","@length ":"1 "}}]
        """
        
        let data = jsonString.data(using: .utf8)
        let decoder = JSONDecoder()
        guard let feedData = try? decoder.decode([Feed].self, from: data) else {
            completion(.error)
            return
        }
        completion(.success(feedData))
    }
}
