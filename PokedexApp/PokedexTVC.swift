//
//  PokedexTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokedexTVC: UITableViewController, UISearchResultsUpdating {
    
    var pokemons = POKEMONS
    var searchController: UISearchController!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
    }
    
    // MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath) as? PokedexCell {
            
            cell.configureCell(pokemon: pokemons[indexPath.row])
            
            return cell
        }
        
        return PokedexCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "PokemonInfo", sender: pokemons[indexPath.row])
        if searchController.searchBar.isFirstResponder {
            searchController.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - SearchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, searchText != "" {
            pokemons = POKEMONS.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
        } else {
            pokemons = POKEMONS
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonInfo", let pokemon = sender as? Pokemon, let pokemonInfoVC = segue.destination as? PokemonInfoVC {
            
            pokemon.parseAllInfo()
            pokemonInfoVC.pokemon = pokemon
        }
    }
    
    // MARK: - IBActions
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        present(searchController, animated: true) {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Functions
    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
