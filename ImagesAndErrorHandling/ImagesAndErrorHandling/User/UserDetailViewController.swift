//
//  UserDetailViewController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet var largeImage: UIImageView!
    @IBOutlet var nameAgeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var cellLabel: UILabel!
    
    var user: Users?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    
    func updateUI() {
        
        guard let validUser = user else {
            fatalError("could not load user")
        }
        
        locationLabel.text = """
        \(validUser.name.lastName.capitalized), \(validUser.name.firstName.capitalized)
        
        \(validUser.location.street.name.capitalized)
        \(validUser.location.city.capitalized), \(validUser.location.state.capitalized) \(validUser.location.postcode.extractValue().capitalized)
        """
        
        
        phoneLabel.text = "Phone: \(validUser.phone)"
        cellLabel.text = "Cell: \(validUser.cell)"
        
        ImageClient.fetchImage(for: validUser.picture.large) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.largeImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
        
    }
    
}
