//
//  XKCDViewController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class XKCDViewController: UIViewController {

    
    @IBOutlet var comicImage: UIImageView!
    @IBOutlet var stepperControl: UIStepper!
    @IBOutlet var textField: UITextField!
    
    var recent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStepper()
        comicLoad()
    }
    
    
    
    
    func comicLoad() {
        ComicAPIClient.getComic(recent: recent, number: Int(stepperControl.value)) { (result) in
            switch result {
            case .failure(let error):
                print("the error was \(error)")
            case .success(let comic):

                ImageClient.fetchImage(for: comic.img) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        DispatchQueue.main.async {
                            self?.comicImage.image = image
                        }
                    }
                }
            }
        }
    }
    
    func configureStepper() {
        stepperControl.minimumValue = 1.0
        stepperControl.maximumValue = 2239.0
        stepperControl.stepValue = 1.0
        // default start value
        stepperControl.value = 2239.0
    }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        recent = false
        comicLoad()
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        recent = false
        stepperControl.value = Double(Int.random(in: 1...2239))
        comicLoad()
    }
    
    @IBAction func recentButtonPressed(_ sender: UIButton) {
        recent = true
        comicLoad()
    }
    
}
