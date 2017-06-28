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


class GenericTVC: UITableViewController, UISearchResultsUpdating, ViewLauncherDelegate {
    
    var genericCell: GenericCell! // will be assigned when perform segue
    
    var pokemons: [Pokemon]!
    var types: [String]!
    var moves: [Move]!
    var abilities: [Ability]!
    var items: [Item]!
    
    var searchResultController: UISearchController!
    var viewLauncher: ViewLauncher!
    
    var indexPath: IndexPath! //use to deselect row on viewLauncher dismissed
    var segmentControllSelectedIndex: Int?
    
    var currentGenericCell: GenericCell { return genericCell }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNecessaryData()
        configureNavigationBar()
        configureViewLauncher()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewLauncher.dismiss(animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewLauncher.removeFromSuperview()
    }

    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentGenericCell {
            
        case .PokedexCell:
            return pokemons.count
            
        case .TypeCell:
            return types.count
            
        case .MoveCell:
            return moves.count
            
        case .AbilityCell:
            return abilities.count
            
        case .TMCell:
            return items.count
            
        case .ItemCell:
            return items.count
            
        case .BerryCell:
            return items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(currentGenericCell)", for: indexPath)
        
        switch currentGenericCell {
            
        case .PokedexCell:
            guard let cell = cell as? PokedexCell else { return UITableViewCell() }
            cell.configureCell(for: pokemons[indexPath.row])
            return cell
            
        case .TypeCell:
            guard let cell = cell as? TypeCell else { return UITableViewCell() }
            cell.configureCell(type: types[indexPath.row])
            return cell
            
        case .MoveCell:
            guard let cell = cell as? MoveCell else { return UITableViewCell() }
            cell.configureCell(for: moves[indexPath.row])
            return cell
            
        case .AbilityCell:
            guard let cell = cell as? AbilityCell else { return UITableViewCell() }
            cell.configureCell(ability: abilities[indexPath.row])
            return cell
            
        case .TMCell:
            guard let cell = cell as? ItemCell else { return UITableViewCell() }
            cell.configureCell(tm: items[indexPath.row])
            return cell
            
        case .ItemCell:
            guard let cell = cell as? ItemCell else { return UITableViewCell() }
            cell.configureCell(item: items[indexPath.row])
            return cell
            
        case .BerryCell:
            guard let cell = cell as? ItemCell else { return UITableViewCell() }
            cell.configureCell(berry: items[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        audioPlayer.play(audio: .select)
        
        switch currentGenericCell {
            
        case .PokedexCell:
            performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
            
        case .TypeCell:
            performSegue(withIdentifier: "TypeDetailTVC", sender: types[indexPath.row])
            
        case .MoveCell:
            performSegue(withIdentifier: "MoveDetailTVC", sender: moves[indexPath.row])
            
        case .AbilityCell:
            performSegue(withIdentifier: "AbilityDetailTVC", sender: abilities[indexPath.row])
            
        case .TMCell:
            self.indexPath = indexPath
            handleSelectedItemCellRow(item: items[indexPath.row])
            
        case .ItemCell:
            self.indexPath = indexPath
            handleSelectedItemCellRow(item: items[indexPath.row])
            
        case .BerryCell:
            self.indexPath = indexPath
            handleSelectedItemCellRow(item: items[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch sender {
            
        case is Pokemon:
            guard let pokemonInfoVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon else { return }
            pokemonInfoVC.pokemon = pokemon
            
        case is String: // type
            guard let typeDetailTVC = segue.destination as? TypeDetailTVC, let type = sender as? String else { return }
            typeDetailTVC.type = type
            
        case is Move:
            guard let moveDetailTVC = segue.destination as? MoveDetailTVC, let move = sender as? Move else { return }
            moveDetailTVC.move = move
            
        case is Ability:
            guard let abilityDetailTVC = segue.destination as? AbilityDetailTVC, let ability = sender as? Ability else { return }
            abilityDetailTVC.ability = ability
            
        default: ()
        }
    }
    
    
    
    // MARK: - Protocol
    
    func viewLauncherWillDismiss(viewlauncher: ViewLauncher) {
        
        guard indexPath != nil else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - IBActions
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        present(searchResultController, animated: true) {
            self.searchResultController.searchBar.becomeFirstResponder()
        }
    }
    
    
    
    // MARK: - Search
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.isActive, let searchText = searchController.searchBar.text, searchText != "" {
            
            switch currentGenericCell {
                
            case .PokedexCell:
                pokemons = Variable.allPokemonsSortedById.filter(for: searchText, options: .caseInsensitive)
                
            case .TypeCell:
                types = Variable.allTypes.filter({$0.range(of: searchText, options: .caseInsensitive) != nil})
                
            case .MoveCell:
                moves = Variable.allMoves.filter(forName: searchText, options: .caseInsensitive)
                
            case .AbilityCell:
                abilities = Variable.allAbilities.filter(for: searchText, options: .caseInsensitive)
                
            case .TMCell:
                items = Variable.allItems.machines.filter(for: searchText, options: .caseInsensitive)
                
            case .ItemCell:
                items = Variable.allItems.excludeBerriesMachines.filter(for: searchText, options: .caseInsensitive)
                
            case .BerryCell:
                items = Variable.allItems.berries.filter(for: searchText, options: .caseInsensitive)
            }
            
        } else {
            
            switch currentGenericCell {
                
            case .PokedexCell:
                if segmentControllSelectedIndex == 0 {
                    pokemons = Variable.allPokemonsSortedById
                } else {
                    pokemons = Variable.allPokemonsSortedByName
                }
                
            case .TypeCell:
                types = Variable.allTypes
                
            case .MoveCell:
                moves = Variable.allMoves
                
            case .AbilityCell:
                abilities = Variable.allAbilities
                
            case .TMCell:
                items = Variable.allItems.machines
                
            case .ItemCell:
                if segmentControllSelectedIndex == 0 {
                    items = Variable.allItems.excludeBerriesMachines
                } else {
                    items = Variable.allItems.excludeBerriesMachines
                }
                
            case .BerryCell:
                items = Variable.allItems.berries
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    
    // MARK: - Initializer and Handler
    
    func prepareNecessaryData() {
        
        switch currentGenericCell {
            
        case .PokedexCell:
            pokemons = Variable.allPokemonsSortedById
            
        case .TypeCell:
            types = Variable.allTypes
            
        case .MoveCell:
            moves = Variable.allMoves
            
        case .AbilityCell:
            abilities = Variable.allAbilities
                        
        case .TMCell:
            items = Variable.allItems.machines
            
        case .ItemCell:
            items = Variable.allItems.excludeBerriesMachines
            
        case .BerryCell:
            items = Variable.allItems.berries
        }
    }
    
    func configureNavigationBar() {
        
        searchResultController = UISearchController(searchResultsController: nil)
        searchResultController.loadViewIfNeeded()
        searchResultController.searchResultsUpdater = self
        searchResultController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchResultController.searchBar
        
        if currentGenericCell == .PokedexCell {
            searchResultController.searchBar.placeholder = "Name, ID, Type, TypeType, Ability"
            
            let segmentControll: RoundUISegmentedControl = {
                let sc = RoundUISegmentedControl(items: ["0-9", "A-Z"])
                sc.selectedSegmentIndex = 0
                return sc
            }()
            
            segmentControll.addTarget(self, action: #selector(handleSegmentControllValueChange), for: .valueChanged)
            navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: segmentControll))
            
            self.segmentControllSelectedIndex = segmentControll.selectedSegmentIndex
            
        } else if currentGenericCell == .ItemCell {
            let segmentControll: RoundUISegmentedControl = {
                let sc = RoundUISegmentedControl(items: ["A-Z", "Cat"])
                sc.selectedSegmentIndex = 0
                return sc
            }()
            
            segmentControll.addTarget(self, action: #selector(handleSegmentControllValueChange), for: .valueChanged)
            navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: segmentControll))
            
            self.segmentControllSelectedIndex = segmentControll.selectedSegmentIndex
        }
    }
    
    func configureViewLauncher() {
        
        viewLauncher = ViewLauncher(frame: Constant.Constrain.viewlauncherFrameUnderNavBar)
        UIApplication.shared.keyWindow?.addSubview(viewLauncher)
        viewLauncher.dismiss(animated: false)
        viewLauncher.delegate = self
    }
    
    func handleSelectedItemCellRow(item: Item) {
        
        viewLauncher.launchView.removeAllSubviews()
        viewLauncher.launchView.addTextView(text: item.effect)
        viewLauncher.launch()
    }
    
    func handleSegmentControllValueChange(_ sender: UISegmentedControl) {
        
        self.segmentControllSelectedIndex = sender.selectedSegmentIndex
        
        switch  currentGenericCell {
            
        case .PokedexCell:
            if segmentControllSelectedIndex == 0 {
                pokemons = Variable.allPokemonsSortedById
            } else { //must be 1
                pokemons = pokemons.sortByAlphabet()
            }
            
        case .ItemCell:
            if segmentControllSelectedIndex == 0 { //A-Z
                items = Variable.allItems.excludeBerriesMachines.sorted(by: {$0.name < $1.name})
            } else { //must be 1, Cat.
                items = Variable.allItems.excludeBerriesMachines.sorted(by: {$0.category < $1.category})
            }
            
        default: ()
        }
        
        tableView.reloadData()
    }
}
