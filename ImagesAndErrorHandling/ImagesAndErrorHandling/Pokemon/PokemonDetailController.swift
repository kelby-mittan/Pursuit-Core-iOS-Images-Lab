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
        var weaknessType = ""
        var theTypes = [String]()
        var theType = ""
        guard let card = theCard else {
            fatalError()
        }
        guard let weaknesses = card.weaknesses, let types = card.types else {
            return
        }
        for type in types {
            theTypes.append(type)
        }
        theType = theTypes.joined(separator: ", ")
        
        for weakness in weaknesses {
            weaknessType = weakness.type
        }
        nameLabel.text = card.name
        typeLabel.text = "Types: \(theType)"
        weaknessLabel.text = "Weaknesses: \(weaknessType)"
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
