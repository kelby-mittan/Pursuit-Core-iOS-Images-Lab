//
//  PokemonCell.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/8/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var setLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardImage.layer.cornerRadius = 10
    }
    
    
    func configureCell(for card: Card) {
        nameLabel.text = card.name
        setLabel.text = card.set
        
        ImageClient.fetchImage(for: card.imageUrl) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cardImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}

