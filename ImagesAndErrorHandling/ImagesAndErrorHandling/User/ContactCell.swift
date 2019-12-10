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
        nameAgeLabel.text = "\(user.name.lastName), \(user.name.firstName) - \(user)"
        phoneLabel.text = user.phone
        
        
    }
}
