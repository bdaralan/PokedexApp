//
//  MoveDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailTVC: UITableViewController, TypeUILabelDelegate {
    
    var move: Move! //will be assigned during segue
    var moves = [Move]()
    var pokemons = [Pokemon]()
    var learnMovePokemons = [PokemonLearnMove]()
    
    var currentPokemons = [Pokemon]()
    
    var segmentControl: RoundUISegmentedControl!
    
    let moveDetailCellSection = 0
    let pokemonCellSection = 1

    var moveDetailCellHeight: CGFloat = 240
    
    var currentSCIndex: Move.LearnMethod {
        
        return Move.LearnMethod(rawValue: segmentControl.selectedSegmentIndex)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = move.name

        configureAttributes()
        configureSegmentControl()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case moveDetailCellSection: return 1
        case pokemonCellSection: return currentPokemons.count > 0 ? currentPokemons.count : 1 // return 1 for a regular cell, with text "None"
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case moveDetailCellSection:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MoveDetailCell", for: indexPath) as? MoveDetailCell {
                cell.configureCell(for: move)
                moveDetailCellHeight = cell.height
                return cell
            }
            
        case pokemonCellSection:
            if currentPokemons.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath) as? PokedexCell {
                cell.configureCell(for: currentPokemons[indexPath.row])
                return cell
            } else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "None"
                cell.isUserInteractionEnabled = false
                return cell
            }
            
        default: ()
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case moveDetailCellSection: return moveDetailCellHeight
        default: return UITableViewCell().frame.height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sectionHeaderViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
            
        case moveDetailCellSection:
            let sectionHeaderView = SectionUILabel(frame: CGRect(x: 0, y: 0, width: sectionHeaderViewWidth, height: sectionHeaderViewHeight))
            sectionHeaderView.layer.cornerRadius = 0
            sectionHeaderView.text = "Move Detail"
            return sectionHeaderView
            
        case pokemonCellSection:
            let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: sectionHeaderViewWidth, height: sectionHeaderViewHeight))
            sectionHeaderView.backgroundColor = DBColor.AppObject.sectionBackground
            sectionHeaderView.addSubview(segmentControl)
            return sectionHeaderView
            
        default: return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == pokemonCellSection else { return }
        performSegue(withIdentifier: "PokemonInfoTVC", sender: currentPokemons[indexPath.row])
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pokemonInfoTVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon else { return }
        pokemonInfoTVC.pokemon = pokemon
    }
    
    // MARK: - Protocol
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "TypeDetailTVC", sender: move.type)
    }
    
    // MARK: - Initializer and Handler
    
    func configureAttributes() {
        
        // moves
        moves = Variable.allMoves.filter(forType: move.type)
        
        // learnMovePokemons
        guard let moveDic = Constant.pokemonLearnMoveJSON[move.name] as? Dictionary<String, [String]> else { return }
        learnMovePokemons = PokemonLearnMove.initArray(moveName: move.name, moveDictionary: moveDic)
        
        // pokemons
        for learnMovePokemon in learnMovePokemons {
            pokemons = pokemons + Variable.allPokemonsSortedById.filter(forId: learnMovePokemon.pokemonId)
        }
        pokemons = pokemons.sortById()
        
        // currentPokemons
        currentPokemons = pokemons
    }
    
    func configureSegmentControl() {
        
        let spacing: CGFloat = 8
        
        segmentControl = RoundUISegmentedControl(items: ["All", "Level Up", "Breed / Others"])
        segmentControl.frame.origin = CGPoint(x: spacing, y: spacing)
        segmentControl.frame.size.width = sectionHeaderViewWidth - spacing * 2
        segmentControl.tintColor = DBColor.get(color: move.type)
        segmentControl.layer.borderColor = segmentControl.tintColor.cgColor
        segmentControl.backgroundColor = UIColor.white
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentControlValueChanged(_ sender: RoundUISegmentedControl) {
        
        switch currentSCIndex {
        case .any:
            currentPokemons = pokemons
        
        case .levelup:
            currentPokemons = []
            let learnPokemons = learnMovePokemons.filter({ $0.learnMethod == .levelUp })
            for learnPokemon in learnPokemons { currentPokemons += pokemons.filter(forId: learnPokemon.pokemonId) }
            currentPokemons = currentPokemons.sortById()
        
        case .breedOrMachine:
            currentPokemons = []
            let learnPokemons = learnMovePokemons.filter({ $0.learnMethod == .breed || $0.learnMethod == .breedOrLevelUp })
            for learnPokemon in learnPokemons { currentPokemons += pokemons.filter(forId: learnPokemon.pokemonId) }
            currentPokemons = currentPokemons.sortById()
        }
        
        tableView.reloadData()
        
//        let pokemonCellSectionRows = tableView.numberOfRows(inSection: pokemonCellSection)
//        
//        if pokemonCellSectionRows != 0 {
//            tableView.scrollToRow(at: IndexPath.init(row: 0, section: pokemonCellSection), at: .top, animated: true)
//            //tableView.separatorColor = UIColor.myColor.tableViewSeparator
//            
//        } else {
//            tableView.scrollToRow(at: IndexPath.init(row: 0, section: moveDetailCellSection), at: .top, animated: true)
//            //tableView.separatorColor = UIColor.clear
//        }
    }
}

// MARK: - Computed Property

extension MoveDetailTVC {
    
    var sectionHeaderViewWidth: CGFloat {
        
        return tableView.frame.width
    }
    
    var sectionHeaderViewHeight: CGFloat {
        
        return Constant.Constrain.sectionHeaderViewHeight
    }
}
