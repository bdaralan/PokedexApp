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

// TODO: - Fix viewLauncher goes behind navigationController after search ended

class GenericTVC: UITableViewController, UISearchResultsUpdating {
    
    var genericCell: GenericCell! // will be assigned when perform segue
    
    var pokemons: [Pokemon]!
    var types: [String]!
    var moves: [Move]!
    var abilities: [Ability]!
    var items: [Item]!
    
    var searchResultController: UISearchController!
    
    var segmentControllSelectedIndex: Int?
    var viewLauncher: ViewLauncher?
    var textView: UITextView?
    
    var currentGenericCell: GenericCell { return genericCell }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = true
        
        prepareNecessaryData()
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if viewLauncher != nil {
            viewLauncher?.dismiss()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentGenericCell {
        case .PokedexCell: return pokemons.count
        case .TypeCell: return types.count
        case .MoveCell: return moves.count
        case .AbilityCell: return abilities.count
        case .TMCell: return items.count
        case .ItemCell: return items.count
        case .BerryCell: return items.count
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
            
        case .TMCell:
            if let cell = cell as? ItemCell {
                cell.configureCell(tm: items[indexPath.row])
            }
        case .ItemCell:
            if let cell = cell as? ItemCell {
                cell.configureCell(item: items[indexPath.row])
            }
        case .BerryCell:
            if let cell = cell as? ItemCell {
                cell.configureCell(berry: items[indexPath.row])
            }
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
        case .TMCell:
            tableView.deselectRow(at: indexPath, animated: true)
            handleItemCell(selectedRow: indexPath.row)
        case .ItemCell:
            tableView.deselectRow(at: indexPath, animated: true)
            handleItemCell(selectedRow: indexPath.row)
        case .BerryCell:
            tableView.deselectRow(at: indexPath, animated: true)
            handleItemCell(selectedRow: indexPath.row)
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
                pokemons = CONSTANTS.allPokemonsSortedById.filter(for: searchText)
            case .TypeCell:
                types = CONSTANTS.allTypes.filter({$0.range(of: searchText, options: .caseInsensitive) != nil})
            case .MoveCell:
                moves = CONSTANTS.allMoves.filter(for: searchText)
            case .AbilityCell:
                abilities = CONSTANTS.allAbilities.filter(for: searchText)
            case .TMCell:
                items = CONSTANTS.allItems.machines.filter(for: searchText)
            case .ItemCell:
                items = CONSTANTS.allItems.excludeBerriesMachines.filter(for: searchText)
            case .BerryCell:
                items = CONSTANTS.allItems.berries.filter(for: searchText)
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
            case .TMCell:
                items = CONSTANTS.allItems.machines
            case .ItemCell:
                if segmentControllSelectedIndex == 0 {
                    items = CONSTANTS.allItems.excludeBerriesMachines
                } else {
                    items = CONSTANTS.allItems.excludeBerriesMachines
                }
                
            case .BerryCell:
                items = CONSTANTS.allItems.berries
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        present(searchResultController, animated: true) {
            self.searchResultController.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Functions
    func prepareNecessaryData() {
        
        switch currentGenericCell {
        case .PokedexCell:
            pokemons = CONSTANTS.allPokemonsSortedById
        case .TypeCell:
            types = CONSTANTS.allTypes
        case .MoveCell:
            moves = CONSTANTS.allMoves
        case .AbilityCell:
            abilities = CONSTANTS.allAbilities
        case .TMCell:
            items = CONSTANTS.allItems.machines
            configureItemCellTextView()
        case .ItemCell:
            items = CONSTANTS.allItems.excludeBerriesMachines
            configureItemCellTextView()
        case .BerryCell:
            items = CONSTANTS.allItems.berries
            configureItemCellTextView()
        }
    }
    
    func handleSegmentControllValueChange(_ sender: UISegmentedControl) {
        
        self.segmentControllSelectedIndex = sender.selectedSegmentIndex
        
        switch  currentGenericCell {
        case .PokedexCell:
            if segmentControllSelectedIndex == 0 {
                pokemons = CONSTANTS.allPokemonsSortedById
            } else { //must be 1
                pokemons = pokemons.sortByAlphabet()
            }
            
        case .ItemCell:
            if segmentControllSelectedIndex == 0 {
                items = CONSTANTS.allItems.excludeBerriesMachines
            } else { //must be 1
                items = CONSTANTS.allItems.excludeBerriesMachines.sorted(by: {$0.category < $1.category})
            }
        default: ()
        }
        
        tableView.reloadData()
    }
    
    func handleItemCell(selectedRow: Int) {
        
        if !items[selectedRow].hasCompletedInfo {
            items[selectedRow].parseCompletedInfo()
        }
        
        if let textView = textView, let viewLauncher = viewLauncher {
            textView.text = items[selectedRow].effect
            textView.sizeToFit()
            textView.frame.size.width = viewLauncher.launchView.frame.width - (CONSTANTS.constrain.margin * 2)
            textView.frame.size.height = textView.contentSize.height
            
            viewLauncher.launchView.frame.size.height = textView.contentSize.height
            viewLauncher.launch()
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
            let segmentControll: DBUISegmentedControl = {
                let sc = DBUISegmentedControl(items: ["0-9", "A-Z"])
                sc.awakeFromNib()
                sc.selectedSegmentIndex = 0
                sc.addTarget(self, action: #selector(handleSegmentControllValueChange), for: .valueChanged)
                
                return sc
            }()
            
            navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: segmentControll))
            self.segmentControllSelectedIndex = segmentControll.selectedSegmentIndex
            
        } else if currentGenericCell == .ItemCell {
            let segmentControll: DBUISegmentedControl = {
                let sc = DBUISegmentedControl(items: ["A-Z", "Cat"])
                sc.awakeFromNib()
                sc.selectedSegmentIndex = 0
                sc.addTarget(self, action: #selector(handleSegmentControllValueChange), for: .valueChanged)
                
                return sc
            }()
            
            navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: segmentControll))
            self.segmentControllSelectedIndex = segmentControll.selectedSegmentIndex
        }
    }
    
    func configureItemCellTextView() {
        
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            let y = UIApplication.shared.statusBarFrame.height + navigationBarFrame.height + 0.5
            let width = self.view.frame.width
            let launchViewFrame = CGRect(x: 0, y: y, width: width, height: 50)
            let dimViewFrame = CGRect(x: 0, y: y, width: width, height: self.view.frame.height - y)
            
            viewLauncher = {
                let vlauncher = ViewLauncher(launchViewFrame: launchViewFrame, dimViewFrame: dimViewFrame, swipeToDismissDirection: .right)
                
                vlauncher.isRemoveSubviewsAfterDimissed = false
                vlauncher.dismissOrigin = CGPoint(x: launchViewFrame.width, y: launchViewFrame.origin.y)
                
                if let keyWindow = UIApplication.shared.keyWindow {
                    vlauncher.setSuperview(keyWindow)
                }
                
                return vlauncher
            }()
            
            textView = {
                let x = CONSTANTS.constrain.margin
                let width = launchViewFrame.width - (x * 2)
                let height = launchViewFrame.height
                
                let tv = UITextView(frame: CGRect(x: x, y: 0, width: width, height:height))
                tv.isScrollEnabled = false
                tv.isEditable = false
                tv.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
                
                return tv
            }()
            
            viewLauncher?.launchView.addSubview(textView!)
        }
    }
}
