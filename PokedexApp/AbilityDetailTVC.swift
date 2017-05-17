//
//  AbilityDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 5/16/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityDetailTVC: UITableViewController {

    var ability: Ability! //will be assigned from segue
    var pokemons: [Pokemon]!
    
    var abilityDetailCellHeight: CGFloat = 45
    
    let abilityDetialSection = 0
    let pokemonSection = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ability.name
        
        prepareNecessaryData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case abilityDetialSection:
            return 1
            
        case pokemonSection:
            return pokemons.count
            
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case abilityDetialSection:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityDetailCell", for: indexPath) as? AbilityDetailCell {
                cell.configureCell(for: ability)
                abilityDetailCellHeight = cell.height
                return cell
            }
            
        case pokemonSection:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath) as? PokedexCell {
                cell.configureCell(for: pokemons[indexPath.row])
                return cell
            }
        
        default:()
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case abilityDetialSection:
            return abilityDetailCellHeight
            
        default:
            return UITableViewCell().frame.height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CONSTANTS.height.sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView: SectionUILabel = {
            let view = SectionUILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CONSTANTS.height.sectionHeaderView))
            return view
        }()
        
        sectionHeaderView.layer.cornerRadius = 0
        
        switch section {
            
        case abilityDetialSection:
            sectionHeaderView.text = "Description"
            return sectionHeaderView
            
        case pokemonSection:
            sectionHeaderView.text = "Pokemon"
            return sectionHeaderView
            
        default:
            return UIView()
        }
    }
}


extension AbilityDetailTVC {
    
    func prepareNecessaryData() {
        
        pokemons = CONSTANTS.allPokemonsSortedById.filter(forAbility: ability.name)
    }
}
