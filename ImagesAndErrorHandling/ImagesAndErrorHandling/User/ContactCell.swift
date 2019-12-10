//
//  ContactCell.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/9/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var nameAgeLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    

    func configureCell(for user: Users) {
        nameAgeLabel.text = "\(user.name.lastName), \(user.name.firstName) - \(user.dob.age.description)"
        phoneLabel.text = user.phone
        
        ImageClient.fetchImage(for: user.picture.thumbnail) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.thumbnailImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
