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
        case abilityDetialSection: return 1
        case pokemonCellSection: return pokemons.count
        default: return 0
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
            
        default: ()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case abilityDetialSection: return abilityDetailCellHeight
        default: return UITableViewCell().frame.height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Constrain.sectionHeaderViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constant.Constrain.sectionHeaderViewHeight))
        sectionHeaderView.backgroundColor = DBColor.AppObject.sectionBackground
        
        switch section {
        case abilityDetialSection: sectionHeaderView.addSubview(abilityDetailLbl)
        case pokemonCellSection: sectionHeaderView.addSubview(segmentControl)
        default: ()
        }
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == pokemonCellSection else { return }
        AudioPlayer.play(audio: .select)
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
        
        abilityDetailLbl = SectionUILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constant.Constrain.sectionHeaderViewHeight))
        abilityDetailLbl.layer.cornerRadius = 0
        abilityDetailLbl.text = "Ability Detail"
        
        segmentControl = RoundUISegmentedControl(items: ["All", "Hidden"])
        segmentControl.frame.origin = CGPoint(x: spacing, y: spacing)
        segmentControl.frame.size.width = tableView.frame.width - spacing * 2
        segmentControl.tintColor = DBColor.AppObject.sectionText
        segmentControl.layer.borderColor = segmentControl.tintColor.cgColor
        segmentControl.backgroundColor = UIColor.white
        segmentControl.selectedSegmentIndex = pokemonWithAbilitySegIndex
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentControlValueChanged(_ sender: RoundUISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case pokemonWithAbilitySegIndex: pokemons = Variable.allPokemonsSortedById.filter(forAbility: ability.name)
        case pokemonWithAbilityAsHiddenSegIndex: pokemons = Variable.allPokemonsSortedById.filter(forAbility: ability.name, hiddenOnly: true)
        default: ()
        }
        tableView.reloadData()
    }
}
