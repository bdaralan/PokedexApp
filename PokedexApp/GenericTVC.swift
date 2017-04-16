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


class GenericTVC: UITableViewController {
    
    var genericCell: GenericCell! // will be assigned when perform segue
    
    var pokemons: [Pokemon]!
    var types: [String]!
    var moves: [Move]!
    var abilities: [Ability]!
    
    var currentGenericCell: GenericCell { return genericCell }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch currentGenericCell {
        case .PokedexCell: pokemons = loadData.allPokemons(by: .id)
        case .TypeCell: types = loadData.allType()
        case .MoveCell: moves = loadData.allMoves()
        case .AbilityCell: abilities = loadData.allAbilities(by: .name)
        case .TMCell: ()
        case .ItemCell: ()
        case .BerryCell: ()
        }
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
    }
}
