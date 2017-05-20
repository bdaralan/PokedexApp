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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case abilityDetialSection:
            return abilityDetailCellHeight
            
        default:
            return UITableViewCell().frame.height
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pokemonInfoVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon {
            pokemonInfoVC.pokemon = pokemon
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CONSTANTS.constrain.sectionHeaderViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView: SectionUILabel = {
            let label = SectionUILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CONSTANTS.constrain.sectionHeaderViewHeight))
            label.layer.cornerRadius = 0
            return label
        }()
                
        switch section {
            
        case abilityDetialSection:
            sectionHeaderView.text = "Ability Detail"
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
