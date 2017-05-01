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
    var items: [Item]!
    
    var searchResultController: UISearchController!
    var segmentControllSelectedIndex: Int?
    var currentGenericCell: GenericCell { return genericCell }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = true
        
        prepareNecessaryData()
        configureNavigationBar()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentGenericCell {
        case .PokedexCell: return pokemons.count
        case .TypeCell: return types.count
        case .MoveCell: return moves.count
        case .AbilityCell: return abilities.count
        case .TMCell: return 0
        case .ItemCell: return items.count
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
        case .ItemCell:
            if let cell = cell as? SimpleCell {
                cell.configureCell(item: items[indexPath.row])
            }
        case .BerryCell: return cell
        }
        
        return cell //should never reach this line
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        switch currentGenericCell {
        case .PokedexCell:
            performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
        case .TypeCell:
            performSegue(withIdentifier: "TypeDetailVC", sender: nil)
        case .MoveCell:
            performSegue(withIdentifier: "MoveDetailVC", sender: moves[indexPath.row])
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
        } else if let move = sender as? Move, let moveVC = segue.destination as? MoveDetailVC {
            moveVC.move = move
        }
    }
    
    // MARK: - Search
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.isActive, let searchText = searchController.searchBar.text, searchText != "" {
            
            switch currentGenericCell {
            case .PokedexCell:
                pokemons = CONSTANTS.allPokemonsSortedById.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .TypeCell:
                types = CONSTANTS.allTypes.filter({$0.range(of: searchText, options: .caseInsensitive) != nil})
            case .MoveCell:
                moves = CONSTANTS.allMoves.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .AbilityCell:
                abilities = CONSTANTS.allAbilities.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .TMCell: ()
            case .ItemCell:
                items = CONSTANTS.allItems.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            case .BerryCell: ()
            }
        } else {
            
            switch currentGenericCell {
            case .PokedexCell:
                if segmentControllSelectedIndex == 0 {
                    pokemons = CONSTANTS.allPokemonsSortedById
                } else {
                    pokemons = CONSTANTS.allPokemonsSortedById.sortByAlphabet()
                }
            case .TypeCell: ()
                types = CONSTANTS.allTypes
            case .MoveCell:
                moves = CONSTANTS.allMoves
            case .AbilityCell:
                abilities = CONSTANTS.allAbilities
            case .TMCell: ()
            case .ItemCell:
                if segmentControllSelectedIndex == 0 {
                    items = CONSTANTS.allItems
                } else {
                    items = CONSTANTS.allItems.sorted(by: {$0.category < $1.category})
                }
                
            case .BerryCell: ()
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Functions
    func configureNavigationBar() {
        
        searchResultController = UISearchController(searchResultsController: nil)
        searchResultController.loadViewIfNeeded()
        searchResultController.searchResultsUpdater = self
        searchResultController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchResultController.searchBar
        
        if currentGenericCell == .PokedexCell {
            let segmentControll: DBUISegmentedControl = {
                let sc = DBUISegmentedControl(items: ["0-9", "A-Z"])
                sc.awakeFromNib()
                sc.selectedSegmentIndex = 0
                sc.addTarget(self, action: #selector(segmentControllValueChanged), for: .valueChanged)
                
                return sc
            }()
            
            navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: segmentControll))
            self.segmentControllSelectedIndex = segmentControll.selectedSegmentIndex
            
        } else if currentGenericCell == .ItemCell {
            let segmentControll: DBUISegmentedControl = {
                let sc = DBUISegmentedControl(items: ["A-Z", "Cat"])
                sc.awakeFromNib()
                sc.selectedSegmentIndex = 0
                sc.addTarget(self, action: #selector(segmentControllValueChanged), for: .valueChanged)
                
                return sc
            }()
            
            navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: segmentControll))
            self.segmentControllSelectedIndex = segmentControll.selectedSegmentIndex
        }
    }
    
    func prepareNecessaryData() {
        
        switch currentGenericCell {
        case .PokedexCell: pokemons = CONSTANTS.allPokemonsSortedById
        case .TypeCell: types = CONSTANTS.allTypes
        case .MoveCell: moves = CONSTANTS.allMoves
        case .AbilityCell: abilities = CONSTANTS.allAbilities
        case .TMCell: ()
        case .ItemCell: items = CONSTANTS.allItems
        case .BerryCell: ()
        }
    }
    
    func segmentControllValueChanged(_ sender: UISegmentedControl) {
        
        self.segmentControllSelectedIndex = sender.selectedSegmentIndex
        
        switch  currentGenericCell {
        case .PokedexCell:
            switch sender.selectedSegmentIndex {
            case 0:
                pokemons = CONSTANTS.allPokemonsSortedById
            case 1:
                pokemons = pokemons.sortByAlphabet()
            default: ()
            }
            
        case .ItemCell:
            switch sender.selectedSegmentIndex {
            case 0:
                items = CONSTANTS.allItems
            case 1:
                items = CONSTANTS.allItems.sorted(by: {$0.category < $1.category})
            default: ()
            }
        default: ()
        }
        
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        present(searchResultController, animated: true) { 
            self.searchResultController.searchBar.becomeFirstResponder()
        }
    }
}
