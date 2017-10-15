//
//  TypeDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailTVC: UITableViewController, TypeUILabelDelegate {
    
    var type: String! //will be assigned by segue
    var pokemons: [Pokemon]!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = Variable.allPokemonsSortedById.filter(forType: type)
        moves = Variable.allMoves.filter(forType: type)
        
        configureHeaderViews()
        updateUI()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2 // NOTE: - OffenseDefenseCell and Pokemon/Move Section (use segmentControl)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case offenseDefenseSection: return 1
            
        case pokemonMoveSection:
            if segmentControl.selectedSegmentIndex == pokemonSegIndex {
                return pokemons.count
            } else { //segmentControl.selectedSegmentIndex == moveSegIndex
                return moves.count
            }
            
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
        
        guard indexPath.section == offenseDefenseSection else { return UITableViewCell().frame.height }
        return offenseDefenseCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == pokemonMoveSection else { return }
        if segmentControl.selectedSegmentIndex == pokemonSegIndex {
            performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
            
        } else { //segmentControl.selectedSegmentIndex == moveSegIndex
            performSegue(withIdentifier: "MoveDetailTVC", sender: moves[indexPath.row])
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pokemonInfoVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon {
            pokemonInfoVC.pokemon = pokemon
            
        } else if let moveDetailTVC = segue.destination as? MoveDetailTVC, let move = sender as? Move {
            moveDetailTVC.move = move
        }
    }
    
    // MARK: - Protocol
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer) {
        
        guard let typeLbl = tapGesture.view as? TypeUILabel, type != typeLbl.text else { return }
        AudioPlayer.play(audio: .select)
        self.type = typeLbl.text
        self.updateUI()
    }
    
    // MARK: - Updater
    
    func updateUI() {
        
        self.title = type
        
        setDefaultState()
        
        if let _ = cache.object(forKey: type as AnyObject) as? String,
            let cachedPokemons = cache.object(forKey: "cachedPokemons\(type)" as AnyObject) as? [Pokemon],
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
            pokemons = Variable.allPokemonsSortedById.filter(forType: type)
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
        
        segmentControl = {
            let sc = RoundUISegmentedControl(items: ["Pokemon", "Move"])
            sc.frame.origin = CGPoint(x: spacing, y: spacing)
            sc.frame.size.width = tableView.frame.width - spacing * 2
            sc.tintColor = typeColor
            sc.layer.borderColor = sc.tintColor.cgColor
            sc.backgroundColor = UIColor.white
            
            sc.selectedSegmentIndex = pokemonSegIndex
            
            sc.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
            return sc
        }()
        
        offenseDefenseLbl = {
            let label = UILabel(frame: CGRect(x: spacing, y: spacing, width: segmentControl.frame.width, height: segmentControl.frame.height))
            label.clipsToBounds = true
            label.layer.cornerRadius = label.frame.height / 2
            label.textAlignment = .center
            label.baselineAdjustment = .alignCenters
            label.textColor = UIColor.white
            label.backgroundColor = typeColor
            label.text = "Offense / Defense"
            return label
        }()
    }
    
    func cacheNecessaryData() {
        
        self.cache.setObject(type as AnyObject, forKey: type as AnyObject)
        self.cache.setObject(Array(pokemons) as AnyObject, forKey: "cachedPokemons\(type)" as AnyObject)
        self.cache.setObject(Array(moves) as AnyObject, forKey: "cachedMoves\(type)" as AnyObject)
        self.cache.setObject(strongAgainstTypeLbls as AnyObject, forKey: "strongAgainstTypeLbls\(type)" as AnyObject)
        self.cache.setObject(weakToTypeLbls as AnyObject, forKey: "weakToTypeLbls\(type)" as AnyObject)
        self.cache.setObject(resistToTypeLbls as AnyObject, forKey: "resisToTypeLbls\(type)" as AnyObject)
        self.cache.setObject(immuneToTypeLbls as AnyObject, forKey: "immuneToTypeLbls\(type)" as AnyObject)
    }
    
    @objc func segmentControlValueChanged(_ sender: RoundUISegmentedControl) {
        
        tableView.reloadData()
//        tableView.scrollToRow(at: IndexPath.init(row: 0, section: pokemonMoveSection), at: .top, animated: true)
    }
}

// MARK: - Computed Property

extension TypeDetailTVC {
    
    var sectionHeaderViewWidth: CGFloat { return tableView.frame.width }
    
    var sectionHeaderViewHeight: CGFloat { return segmentControl.frame.height + 16 }
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
