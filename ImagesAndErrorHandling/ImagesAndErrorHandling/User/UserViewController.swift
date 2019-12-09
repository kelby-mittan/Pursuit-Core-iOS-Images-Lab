//
//  UserViewController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/9/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUser()
    }
    
    func loadUser() {
        RandomUserAPIClient.getUser { (result) in
            switch result {
            case .failure(let appError):
                print("Error is.... \(appError)")
            case .success(let comic):
                print(comic)
            }
        }
    }

}
