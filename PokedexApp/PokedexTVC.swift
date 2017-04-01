//
//  PokedexTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokedexTVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var pokemons = POKEMONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonInfo", let pokemon = sender as? Pokemon, let pokemonInfoVC = segue.destination as? PokemonInfoVC {
            
            pokemonInfoVC.pokemon = pokemon
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func searchBtnTapped(_ sender: Any) {

        
//        let searchResult = UITableViewController(style: .plain)
//        let searchController = UISearchController(searchResultsController: searchResult)
//        
//        self.present(searchController, animated: true, completion: nil)
    }
}
