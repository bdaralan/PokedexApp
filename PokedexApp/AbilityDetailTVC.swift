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
    
    var abilityDetailLbl: SectionUILabel!
    var segmentControl: RoundUISegmentedControl!
    
    let abilityDetialSection = 0
    let pokemonCellSection = 1
    
    let pokemonWithAbilitySegIndex = 0
    let pokemonWithAbilityAsHiddenSegIndex = 1
    
    var abilityDetailCellHeight: CGFloat = 45
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ability.name
        
        prepareNecessaryData()
        configureHeaderViews()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case abilityDetialSection:
            return 1
            
        case pokemonCellSection:
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
            
        case pokemonCellSection:
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
        
        return Constant.Constrain.sectionHeaderViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constant.Constrain.sectionHeaderViewHeight))
            view.backgroundColor = UIColor.MyColor.AppObject.sectionBackground
            return view
        }()
        
        switch section {
            
        case abilityDetialSection:
            sectionHeaderView.addSubview(abilityDetailLbl)
            return sectionHeaderView
            
        case pokemonCellSection:
            sectionHeaderView.addSubview(segmentControl)
            return sectionHeaderView
            
        default:
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == pokemonCellSection else { return }
        audioPlayer.play(audio: .select)
        performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
    }
    
    
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pokemonInfoVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon else { return }
        pokemonInfoVC.pokemon = pokemon
    }
    
    
    
    
    // MARK: - Initializer and Handler
    
    func prepareNecessaryData() {
        
        pokemons = Variable.allPokemonsSortedById.filter(forAbility: ability.name)
    }
    
    func configureHeaderViews() {
        
        let spacing: CGFloat = 8
        
        abilityDetailLbl = {
            let label = SectionUILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constant.Constrain.sectionHeaderViewHeight))
            label.layer.cornerRadius = 0
            label.text = "Ability Detail"
            return label
        }()
        
        segmentControl = {
            let sc = RoundUISegmentedControl(items: ["All", "Hidden"])
            sc.frame.origin = CGPoint(x: spacing, y: spacing)
            sc.frame.size.width = tableView.frame.width - spacing * 2
            sc.tintColor = UIColor.MyColor.AppObject.sectionText
            sc.layer.borderColor = sc.tintColor.cgColor
            sc.backgroundColor = UIColor.white
            
            sc.selectedSegmentIndex = pokemonWithAbilitySegIndex
            
            sc.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
            return sc
        }()
    }
    
    func segmentControlValueChanged(_ sender: RoundUISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case pokemonWithAbilitySegIndex:
            pokemons = Variable.allPokemonsSortedById.filter(forAbility: ability.name)
            
        case pokemonWithAbilityAsHiddenSegIndex:
            pokemons = Variable.allPokemonsSortedById.filter(forAbility: ability.name, hiddenOnly: true)
            
        default: ()
        }
        
        tableView.reloadData()
    }
}
