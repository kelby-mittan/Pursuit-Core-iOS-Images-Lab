//
//  Comic.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation


struct Comic: Decodable {
    let month: String
    let year: String
    let img: String
    let title: String
    let day: String
    
}
