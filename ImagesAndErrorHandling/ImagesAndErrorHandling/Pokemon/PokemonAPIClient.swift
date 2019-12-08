//
//  PokemonAPIClient.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/8/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation


struct PokemonAPIClient {
    
    static func getCards(completion: @escaping (Result<[Card], AppError>) -> ()) {
        
        let url = "https://api.pokemontcg.io/v1/cards"
        
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    let cards = pokemon.cards
                    completion(.success(cards))
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
