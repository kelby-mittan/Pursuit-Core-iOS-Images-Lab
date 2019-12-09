//
//  PokemonDetailController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/8/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class PokemonDetailController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var weaknessLabel: UILabel!
    @IBOutlet var setLabel: UILabel!
    
    var theCard: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardImage.layer.cornerRadius = 10
        updateUI()
    }
    
    func updateUI() {
        guard let card = theCard else {
            fatalError()
        }
        nameLabel.text = card.name
//        weaknessLabel.text = "Weaknesses: \(card.weaknesses.type)"
        setLabel.text = "Set: \(card.set)"
        
        ImageClient.fetchImage(for: card.imageUrlHiRes) { [weak self](result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cardImage.image = image
                }

            }
        }
    }
    
    
    
}
