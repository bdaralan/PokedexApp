//
//  GenericTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

enum GenericCell: String {
    case PokedexCell = "00"
    case TypeCell = "01"
    case MoveCell = "02"
    case AbilityCell = "03"
    case TMCell = "10"
    case ItemCell = "11"
    case BerryCell = "12"
}


class GenericTVC: UITableViewController, UISearchResultsUpdating {
    
    var genericCell: GenericCell! // will be assigned when perform segue
    
    var pokemons: [Pokemon]!
    var types: [String]!
    var moves: [Move]!
    var abilities: [Ability]!
    
    var searchResultController: UISearchController!
    
    var currentGenericCell: GenericCell { return genericCell }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNecessaryData()
        configureSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        globalCache.removeAllObjects()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentGenericCell {
        case .PokedexCell: return pokemons.count
        case .TypeCell: return types.count
        case .MoveCell: return moves.count
        case .AbilityCell: return abilities.count
        case .TMCell: return 0
        case .ItemCell: return 0
        case .BerryCell: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(currentGenericCell)", for: indexPath)
        
        switch currentGenericCell {
        case .PokedexCell:
            if let cell = cell as? PokedexCell {
                cell.configureCell(pokemon: pokemons[indexPath.row])
                return cell
            }
            
        case .TypeCell:
            if let cell = cell as? TypeCell {
                cell.configureCell(type: types[indexPath.row])
                return cell
            }
            
        case .MoveCell:
            if let cell = cell as? MoveCell {
                cell.configureCell(for: moves[indexPath.row])
                return cell
            }
            
        case .AbilityCell:
            if let cell = cell as? AbilityCell {
                cell.configureCell(ability: abilities[indexPath.row])
                return cell
            }
            
        case .TMCell: return cell
        case .ItemCell: return cell
        case .BerryCell: return cell
        }
        
        return cell //should never reach this line
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch currentGenericCell {
        case .PokedexCell:
            performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
        case .TypeCell: ()
        case .MoveCell: ()
        case .AbilityCell: ()
        case .TMCell: ()
        case .ItemCell: ()
        case .BerryCell: ()
        }
    }
    
    // MARK: - Preapre segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pokemon = sender as? Pokemon, let pokemonInfoVC = segue.destination as? PokemonInfoVC {
            pokemonInfoVC.pokemon = pokemon
        }
    }
    
    // MARK: - Search
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.isActive, let searchText = searchController.searchBar.text, searchText != "" {
            
            switch currentGenericCell {
            case .PokedexCell:
                pokemons = CONSTANTS.allPokemons.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .TypeCell:
                types = CONSTANTS.allTypes.filter({$0.range(of: searchText, options: .caseInsensitive) != nil})
            case .MoveCell:
                moves = CONSTANTS.allMoves.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .AbilityCell:
                abilities = CONSTANTS.allAbilities.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .TMCell: ()
            case .ItemCell: ()
            case .BerryCell: ()
            }
        } else {
            
            switch currentGenericCell {
            case .PokedexCell:
                pokemons = CONSTANTS.allPokemons
            case .TypeCell: ()
            types = CONSTANTS.allTypes
            case .MoveCell:
                moves = CONSTANTS.allMoves
            case .AbilityCell:
                abilities = CONSTANTS.allAbilities
            case .TMCell: ()
            case .ItemCell: ()
            case .BerryCell: ()
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Functions
    func configureSearchController() {
        
        searchResultController = UISearchController(searchResultsController: nil)
        searchResultController.loadViewIfNeeded()
        searchResultController.searchResultsUpdater = self
        searchResultController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchResultController.searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presentSearch))
    }
    
    func presentSearch() {
        
        present(searchResultController, animated: true, completion: {
            self.searchResultController.searchBar.becomeFirstResponder()
        })
    }
    
    func prepareNecessaryData() {
        
        switch currentGenericCell {
        case .PokedexCell: pokemons = CONSTANTS.allPokemons
        case .TypeCell: types = CONSTANTS.allTypes
        case .MoveCell: moves = CONSTANTS.allMoves
        case .AbilityCell: abilities = CONSTANTS.allAbilities
        case .TMCell: ()
        case .ItemCell: ()
        case .BerryCell: ()
        }
    }
}
