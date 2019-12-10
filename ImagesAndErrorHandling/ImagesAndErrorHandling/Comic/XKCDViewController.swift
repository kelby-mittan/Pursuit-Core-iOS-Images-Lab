//
//  XKCDViewController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class XKCDViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var comicImage: UIImageView!
    @IBOutlet var stepperControl: UIStepper!
    @IBOutlet var textField: UITextField!
    
    var recent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        configureStepper()
        comicLoad()
    }
    
    
    
    
    func comicLoad() {
        ComicAPIClient.getComic(recent: recent, number: Int(stepperControl.value)) { (result) in
            switch result {
            case .failure(let error):
                print("the error was \(error)")
            case .success(let comic):

                DispatchQueue.main.async {
                    self.titleLabel.text = comic.title
                }
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

extension XKCDViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return false
        }
        let currentText = text + string
        
//        let num = ["1","2","3","4","5","6","7","8","9","0"]
        let numbers = "1234567890"
        
        if currentText.count > 4 || !numbers.contains(string) {
            return false
        }
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text else {
            return false
        }
        if !text.isEmpty {
            let textAsDouble = Double(text) ?? 0
            stepperControl.value = textAsDouble
            comicLoad()
        }
        
        textField.text = ""
        return true
    }
    
}
