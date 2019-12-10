//
//  RandomUserAPIClient.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct RandomUserAPIClient {
    
    static func getUser(completion: @escaping (Result<[Users], AppError>) -> ()) {
        
        let url = "https://randomuser.me/api/?results=50"
                
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let ranUser = try JSONDecoder().decode(UserData.self, from: data)
                    let user = ranUser.results
                    completion(.success(user))
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
