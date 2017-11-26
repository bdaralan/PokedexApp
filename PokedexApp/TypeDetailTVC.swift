//
//  TypeDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailTVC: UITableViewController, TypeUILabelDelegate { // TODO: fixed comments
    
    var type: String! //will be assigned by segue
    var pokemons: [DBPokemon]!
    var moves: [Move]!
    
    var strongAgainstTypeLbls = [TypeUILabel]()
    var weakToTypeLbls = [TypeUILabel]()
    var resistToTypeLbls = [TypeUILabel]()
    var immuneToTypeLbls = [TypeUILabel]()
    
    var segmentControl: RoundUISegmentedControl!
    var offenseDefenseLbl: UILabel!
    
    var offenseDefenseCellHeight: CGFloat = 240
    
    let margin: CGFloat = 16
    let spacing: CGFloat = 8
    
    let offenseDefenseSection = 0
    let pokemonMoveSection = 1
    let pokemonSegIndex = 0
    let moveSegIndex = 1
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() { // TODO: pokemons and moves
        super.viewDidLoad()
        pokemons = PokeData.instance.pokemons // Variable.allPokemonsSortedById.filter(forType: type)
//        moves = Variable.allMoves.filter(forType: type)
        configureHeaderViews()
        updateUI()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // NOTE: OffenseDefenseCell and Pokemon/Move Section (use segmentControl)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case offenseDefenseSection: return 1
        case pokemonMoveSection: return segmentControl.selectedSegmentIndex == pokemonSegIndex ? pokemons.count : moves.count // moveSegIndex
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case offenseDefenseSection:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OffenseDefenseCell", for: indexPath) as? OffenseDefenseCell {
                cell.configureCell(forType: type, strongAgainstTypeLbls: strongAgainstTypeLbls, weakToTypeLbls: weakToTypeLbls, resistToTypeLbls: resistToTypeLbls, immuneToTypeLbls: immuneToTypeLbls)
                self.offenseDefenseCellHeight = cell.height
                return cell
            }
            
        case pokemonMoveSection:
            if segmentControl.selectedSegmentIndex == pokemonSegIndex, let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath) as? PokedexCell {
                cell.configureCell(for: pokemons[indexPath.row])
                return cell
            } else if segmentControl.selectedSegmentIndex == moveSegIndex,
                let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath) as? MoveCell {
                cell.configureCell(for: moves[indexPath.row])
                return cell
            }
            
        default: ()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sectionHeaderViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: sectionHeaderViewWidth, height: sectionHeaderViewHeight))
        sectionHeaderView.backgroundColor = DBColor.AppObject.sectionBackground
        
        switch section {
        case offenseDefenseSection: sectionHeaderView.addSubview(offenseDefenseLbl)
        case pokemonMoveSection: sectionHeaderView.addSubview(segmentControl)
        default: ()
        }
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case offenseDefenseSection: return offenseDefenseCellHeight
        default: return UITableViewCell().frame.height
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == pokemonMoveSection else { return }
        switch segmentControl.selectedSegmentIndex {
        case pokemonSegIndex: performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
        case moveSegIndex: performSegue(withIdentifier: "MoveDetailTVC", sender: moves[indexPath.row])
        default: ()
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemonInfoTVC = segue.destination as? PokemonInfoTVC, let pokemon = sender as? DBPokemon {
            pokemonInfoTVC.pokemon = pokemon
        } else if let moveDetailTVC = segue.destination as? MoveDetailTVC, let move = sender as? Move {
            moveDetailTVC.move = move
        }
    }
    
    // MARK: - Protocol
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer) {
        guard let typeLbl = tapGesture.view as? TypeUILabel, type != typeLbl.text else { return }
        AudioPlayer.play(audio: .select)
        type = typeLbl.text
        updateUI()
    }
    
    // MARK: - Updater
    
    func updateUI() {
        self.title = type
        setDefaultState()
        
        if let _ = cache.object(forKey: type as AnyObject) as? String,
            let cachedPokemons = cache.object(forKey: "cachedPokemons\(type)" as AnyObject) as? [DBPokemon],
            let cachedMoves = cache.object(forKey: "cachedMoves\(type)" as AnyObject) as? [Move],
            let cachedStrongAgainstTypes = cache.object(forKey: "strongAgainstTypeLbls\(type)" as AnyObject) as? [TypeUILabel],
            let cachedWeakToTypes = cache.object(forKey: "weakToTypeLbls\(type)" as AnyObject) as? [TypeUILabel],
            let cachedResistToTypes = cache.object(forKey: "resisToTypeLbls\(type)" as AnyObject) as? [TypeUILabel],
            let cachedImmuneToTypes = cache.object(forKey: "immuneToTypeLbls\(type)" as AnyObject) as? [TypeUILabel] {
            
            pokemons = cachedPokemons
            moves = cachedMoves
            strongAgainstTypeLbls = cachedStrongAgainstTypes
            weakToTypeLbls = cachedWeakToTypes
            resistToTypeLbls = cachedResistToTypes
            immuneToTypeLbls = cachedImmuneToTypes
            
        } else {
//            pokemons = Variable.allPokemonsSortedById.filter(forType: type)
            moves = Variable.allMoves.filter(forType: type)
            strongAgainstTypeLbls = makeTypeLabels(from: getOffensiveTypes())
            weakToTypeLbls = makeTypeLabels(from: getDefensiveTypes(effective: "2"))
            resistToTypeLbls = makeTypeLabels(from: getDefensiveTypes(effective: "1/2"))
            immuneToTypeLbls = makeTypeLabels(from: getDefensiveTypes(effective: "0"))
        }
        
        offenseDefenseLbl.backgroundColor = DBColor.get(color: type)
        segmentControl.tintColor = offenseDefenseLbl.backgroundColor
        segmentControl.layer.borderColor = segmentControl.tintColor.cgColor
        
        tableView.reloadData()
        DispatchQueue.main.async {
            self.cacheNecessaryData()
        }
    }
    
    func setDefaultState() {
        strongAgainstTypeLbls.removeAll()
        weakToTypeLbls.removeAll()
        resistToTypeLbls.removeAll()
        immuneToTypeLbls.removeAll()
    }
    
    // MARK: - Initializer and Handler
    
    func configureHeaderViews() {
        let typeColor = DBColor.get(color: self.type)
        
        segmentControl = RoundUISegmentedControl(items: ["Pokemon", "Move"])
        segmentControl.selectedSegmentIndex = pokemonSegIndex
        segmentControl.frame.origin = CGPoint(x: spacing, y: spacing)
        segmentControl.frame.size.width = tableView.frame.width - spacing * 2
        segmentControl.tintColor = typeColor
        segmentControl.layer.borderColor = segmentControl.tintColor.cgColor
        segmentControl.backgroundColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        
        offenseDefenseLbl = UILabel(frame: CGRect(x: spacing, y: spacing, width: segmentControl.frame.width, height: segmentControl.frame.height))
        offenseDefenseLbl.clipsToBounds = true
        offenseDefenseLbl.layer.cornerRadius = offenseDefenseLbl.frame.height / 2
        offenseDefenseLbl.textAlignment = .center
        offenseDefenseLbl.baselineAdjustment = .alignCenters
        offenseDefenseLbl.textColor = UIColor.white
        offenseDefenseLbl.backgroundColor = typeColor
        offenseDefenseLbl.text = "Offense / Defense"
    }
    
    func cacheNecessaryData() {
        cache.setObject(type as AnyObject, forKey: type as AnyObject)
        cache.setObject(Array(pokemons) as AnyObject, forKey: "cachedPokemons\(type)" as AnyObject)
        cache.setObject(Array(moves) as AnyObject, forKey: "cachedMoves\(type)" as AnyObject)
        cache.setObject(strongAgainstTypeLbls as AnyObject, forKey: "strongAgainstTypeLbls\(type)" as AnyObject)
        cache.setObject(weakToTypeLbls as AnyObject, forKey: "weakToTypeLbls\(type)" as AnyObject)
        cache.setObject(resistToTypeLbls as AnyObject, forKey: "resisToTypeLbls\(type)" as AnyObject)
        cache.setObject(immuneToTypeLbls as AnyObject, forKey: "immuneToTypeLbls\(type)" as AnyObject)
    }
    
    @objc func segmentControlValueChanged(_ sender: RoundUISegmentedControl) {
        tableView.reloadData()
//        tableView.scrollToRow(at: IndexPath.init(row: 0, section: pokemonMoveSection), at: .top, animated: true)
    }
}

// MARK: - Computed Property

extension TypeDetailTVC {
    
    var sectionHeaderViewWidth: CGFloat {
        return tableView.frame.width
    }
    
    var sectionHeaderViewHeight: CGFloat {
        return segmentControl.frame.height + 16
    }
}

// MARK: - Make TypeUILabel

extension TypeDetailTVC {
    
    func getOffensiveTypes() -> [String] {
        var strongAgainstTypes = [String]()
        for type in Variable.allTypes {
            if let typeDict = Constant.defensesJSON[type] as? DictionarySS, let effective = typeDict[self.type], effective == "2" {
                strongAgainstTypes.append(type)
            }
        }
        return strongAgainstTypes
    }
    
    func getDefensiveTypes(effective: String) -> [String] {
        var defensiveTypes = [String]()
        if let defensesDict = Constant.defensesJSON[type] as? DictionarySS {
            for (type, effectiveness) in defensesDict where effectiveness == effective {
                defensiveTypes.append(type)
            }
        }
        return defensiveTypes
    }
    
    func makeTypeLabels(from types: [String]) -> [TypeUILabel] {
        var strongAgainstTypeLbls = [TypeUILabel]()
        
        let spacing: CGFloat = 8
        var x: CGFloat = 8
        var y: CGFloat = 0
        
        if types.count > 0 {
            for type in types {
                let typeLabel = TypeUILabel()
                typeLabel.frame.origin = CGPoint(x: x, y: y)
                typeLabel.text = type
                typeLabel.delegate = self
                typeLabel.isUserInteractionEnabled = true
                
                x = x + typeLabel.frame.width + spacing
                
                if x + typeLabel.frame.width + spacing > view.frame.width + spacing {
                    x = 8
                    y = y + typeLabel.frame.height + spacing
                }
                strongAgainstTypeLbls.append(typeLabel)
            }
            
        } else {
            let noneLbl = TypeUILabel()
            noneLbl.text = "None"
            noneLbl.textColor = DBColor.AppObject.sectionText
            noneLbl.backgroundColor = DBColor.Pokemon.ability
            noneLbl.frame.origin.x = x
            noneLbl.frame.origin.y = y
            strongAgainstTypeLbls.append(noneLbl)
        }
        return strongAgainstTypeLbls
    }
}
