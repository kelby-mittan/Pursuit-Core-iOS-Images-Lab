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

        tableView.dataSource = self
        tableView.delegate = self
        loadUser()
    }
    
    func loadUser() {
        RandomUserAPIClient.getUser { (result) in
            switch result {
            case .failure(let appError):
                print("Error is.... \(appError)")
            case .success(var users):
//                print(users)
                users = users.sorted { $0.name.lastName < $1.name.lastName }
                self.userArr = users
            }
        }
    }

}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell else {
            fatalError()
        }
        
        let user = userArr[indexPath.row]
        
        cell.configureCell(for: user)
        
        
        return cell
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

