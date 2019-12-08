//
//  ComicAPIClient.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    
    static func getComic(completion: @escaping (Result<Comic, AppError>) -> ()) {
        
//        number: Int, 
//        let num = Int.random(in: 1...2238)
        let url = "http://xkcd.com/618/info.0.json"
        
//        let url = "http://xkcd.com/\(number.description)/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let comic = try JSONDecoder().decode(Comic.self, from: data)
                    completion(.success(comic))
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
