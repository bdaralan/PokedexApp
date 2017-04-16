//
//  GenericTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

enum GenericCell: String {
    case TypeCell
    case MoveCell
    case AbilityCell
}

class GenericTVC: UITableViewController {
    
    var genericCell: GenericCell! // will be passed from segue
    
    var types: [String]!
    var moves: [Move]!
    var abilities: [Ability]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let genericCell: GenericCell = self.genericCell
        switch genericCell {
        case .TypeCell: types = loadData.allType()
        case .MoveCell: moves = loadData.allMoves()
        case .AbilityCell: abilities = loadData.allAbilities(by: .name)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let genericCell: GenericCell = self.genericCell
        
        switch genericCell {
        case .TypeCell: return types.count
        case .MoveCell: return moves.count
        case .AbilityCell: return abilities.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let genericCell: GenericCell = self.genericCell
        let cell = tableView.dequeueReusableCell(withIdentifier: genericCell.rawValue, for: indexPath)
        
        switch genericCell {
        case .TypeCell: print(self.tableView.subviews.count)
            if let cell = cell as? TypeCell {
                cell.configureCell(type: types[indexPath.row])
                return cell
            }
            
        case .MoveCell: print(self.tableView.subviews.count)
            if let cell = cell as? MoveCell {
                cell.configureCell(for: moves[indexPath.row])
                return cell
            }
            
        case .AbilityCell: print(self.tableView.subviews.count)
            if let cell = cell as? AbilityCell {
                cell.configureCell(ability: abilities[indexPath.row])
                return cell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
