//
//  User.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct RanUser: Decodable {
    let results: [User]
}

struct User: Decodable {
    let gender: String
}
