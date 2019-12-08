//
//  PokemonCard.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/8/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let name: String
    let set: String
    let imageUrl: String
}
