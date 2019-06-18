//
//  ResultSet.swift
//  WDemo
//
//  Created by Admin on 17/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

public enum ResultSet<T> {
    case success(T)
    case error
}
