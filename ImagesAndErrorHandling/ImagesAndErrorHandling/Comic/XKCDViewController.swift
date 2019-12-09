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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        comicLoad()

    }
    
    
    func comicLoad() {
        ComicAPIClient.getComic(number: Int.random(in: 1...2238)) { (result) in
            switch result {
            case .failure(let error):
                print("the error was \(error)")
            case .success(let comic):
                print(comic.day)
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
    
}
