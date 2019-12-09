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

//        loadUser()
//        comicLoad()

    }
    
    func loadUser() {
        RandomUserAPIClient.getUser { (result) in
            switch result {
            case .failure(let appError):
                print("Error is.... \(appError)")
            case .success(let comic):
                print(comic)
            }
        }
    }
    
    func comicLoad() {
        ComicAPIClient.getComic { (result) in
            switch result {
            case .failure(let error):
                print("the error was \(error)")
            case .success(let comic):
                print(comic.day)
            }
        }
    }
    
}
