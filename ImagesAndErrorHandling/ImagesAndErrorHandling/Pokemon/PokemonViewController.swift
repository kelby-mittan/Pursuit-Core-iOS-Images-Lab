//
//  PokemonViewController.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/8/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var cardArr = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    var searchQuery = "" {
        didSet {
            if !searchQuery.isEmpty {
                cardArr = cardArr.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadCards()
    }
    
    func loadCards() {
        PokemonAPIClient.getCards { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(var cards):
                cards = cards.sorted { $0.name < $1.name }
                self.cardArr = cards
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pokemonVC = segue.destination as? PokemonDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not load")
        }
        pokemonVC.theCard = cardArr[indexPath.row]
    }
}

extension PokemonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
            fatalError()
        }
        
        let card = cardArr[indexPath.row]
        
        cell.configureCell(for: card)
        
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            loadCards()
            return
        }
        
        searchQuery = searchText
    }
}


