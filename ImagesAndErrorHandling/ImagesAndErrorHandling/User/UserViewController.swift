//
//  UserViewController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/9/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var userArr = [Users]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUser()
    }
    
    func loadUser() {
        RandomUserAPIClient.getUser { (result) in
            switch result {
            case .failure(let appError):
                print("Error is.... \(appError)")
            case .success(var users):
                print(users)
                users = users.sorted { $0.name.lastName < $1.name.lastName }
                self.userArr = users
            }
        }
    }

}
