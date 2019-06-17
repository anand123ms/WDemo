//
//  Feed.swift
//  WDemo
//
//  Created by Admin on 14/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct Enclosure: Codable {
    var url: String
    
    enum CodingKeys : String, CodingKey {
        case url = "@url"
    }
    
    public init( url: String) {
        self.url = url
    }
}

struct Feed: Codable
{
    var title: String?
    var description: String?
    var link: String?
    var enclosure: Enclosure?
    
    init() {
        title = ""
        description = ""
        link = ""
        enclosure = Enclosure(url: "")
    }
}
