//
//  TypeDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailTVC: UITableViewController {
    
    var type: String! //will be assigned by segue
    var pokemons: [Pokemon]!
    var moves: [Move]!
    
    var strongAgainstTypes = [String]()
    var weakToTypes = [String]()
    var resistToTypes = [String]()
    var immuneToTypes = [String]()
    
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
        
        pokemons = CONSTANTS.allPokemonsSortedById.filter(forType: type)
        moves = CONSTANTS.allMoves.filter(forType: type)
        
        prepareHeaderViews()
        updateUI()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2 // NOTE: - OffenseDefenseCell and Pokemon/Move Section (use segmentControl)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case offenseDefenseSection:
            return 1
            
        case pokemonMoveSection:
            if segmentControl.selectedSegmentIndex == pokemonSegIndex {
                return pokemons.count
                
            } else { //segmentControl.selectedSegmentIndex == moveSegIndex
                return moves.count
            }
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case offenseDefenseSection:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OffenseDefenseCell") as? OffenseDefenseCell {
                cell.configureCell(forType: type, strongAgainstTypes: strongAgainstTypes, weakToTypes: weakToTypes, resistToTypes: resistToTypes, immuneToTypes: immuneToTypes)
                self.offenseDefenseCellHeight = cell.height
                return cell
            }
            
        case pokemonMoveSection:
            if segmentControl.selectedSegmentIndex == pokemonSegIndex, let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell") as? PokedexCell {
                cell.configureCell(for: pokemons[indexPath.row])
                return cell
                
            } else if segmentControl.selectedSegmentIndex == moveSegIndex, let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell") as? MoveCell {
                cell.configureCell(for: moves[indexPath.row])
                return cell
            }
            
        default: ()
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.headerViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: headerViewWidth, height: headerViewHeight))
            view.backgroundColor = UIColor.myColor.sectionBackground
            return view
        }()
        
        switch section {
            
        case offenseDefenseSection:
            sectionHeaderView.addSubview(offenseDefenseLbl)
            
        case pokemonMoveSection:
            sectionHeaderView.addSubview(segmentControl)
            
        default: ()
            
        }
        
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == offenseDefenseSection {
            return offenseDefenseCellHeight
        }
        
        return UITableViewCell().frame.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  indexPath.section == pokemonMoveSection {
            if segmentControl.selectedSegmentIndex == pokemonSegIndex {
                performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
                
            } else { //segmentControl.selectedSegmentIndex == moveSegIndex
                performSegue(withIdentifier: "MoveDetailVC", sender: moves[indexPath.row])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pokemonInfoVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon {
            pokemonInfoVC.pokemon = pokemon
            
        } else if let moveDetailVC = segue.destination as? MoveDetailVC, let move = sender as? Move {
            moveDetailVC.move = move
        }
    }
    
    func handleTypeLblTapped(_ sender: UITapGestureRecognizer) {
        
        if let typeLbl = sender.view as? TypeUILabel, self.title != typeLbl.text {
            audioPlayer.play(audio: .select)
            self.type = typeLbl.text
            self.updateUI()
        }
    }
    
    func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        // ReloadData and scroll to top
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: pokemonMoveSection), at: .top, animated: true)
    }
    
    func updateUI() {
        
        self.title = type
        
        setDefaultState()
        
        if let _ = cache.object(forKey: type as AnyObject) as? String,
            let cachedPokemons = cache.object(forKey: "cachedPokemons\(type)" as AnyObject) as? [Pokemon],
            let cachedMoves = cache.object(forKey: "cachedMoves\(type)" as AnyObject) as? [Move],
            let cachedStrongAgainstTypes = cache.object(forKey: "strongAgainstTypes\(type)" as AnyObject) as? [String],
            let cachedWeakToTypes = cache.object(forKey: "weakToTypes\(type)" as AnyObject) as? [String],
            let cachedResistToTypes = cache.object(forKey: "resisToTypes\(type)" as AnyObject) as? [String],
            let cachedImmuneToTypes = cache.object(forKey: "immuneToTypes\(type)" as AnyObject) as? [String] {
            
            pokemons = cachedPokemons
            moves = cachedMoves
            strongAgainstTypes = cachedStrongAgainstTypes
            weakToTypes = cachedWeakToTypes
            resistToTypes = cachedResistToTypes
            immuneToTypes = cachedImmuneToTypes
            
        } else {
            pokemons = CONSTANTS.allPokemonsSortedById.filter(forType: type)
            moves = CONSTANTS.allMoves.filter(forType: type)
            getStrongness()
            getWeaknesses()
        }
        
        segmentControl.tintColor = UIColor.myColor.get(from: type)
        segmentControl.layer.borderColor = segmentControl.tintColor.cgColor
        
        tableView.reloadData()
        
        DispatchQueue.main.async {
            self.cacheNecessaryData()
        }
    }
    
    func setDefaultState() {
    }
    
    func cacheNecessaryData() {
        
        self.cache.setObject(type as AnyObject, forKey: type as AnyObject)
        self.cache.setObject(Array(pokemons) as AnyObject, forKey: "cachedPokemons\(type)" as AnyObject)
        self.cache.setObject(Array(moves) as AnyObject, forKey: "cachedMoves\(type)" as AnyObject)
        self.cache.setObject(strongAgainstTypes as AnyObject, forKey: "strongAgainstTypes\(type)" as AnyObject)
        self.cache.setObject(weakToTypes as AnyObject, forKey: "weakToTypes\(type)" as AnyObject)
        self.cache.setObject(resistToTypes as AnyObject, forKey: "resisToTypes\(type)" as AnyObject)
        self.cache.setObject(immuneToTypes as AnyObject, forKey: "immuneToTypes\(type)" as AnyObject)
    }
    
    func prepareHeaderViews() {
        
        let typeColor = UIColor.myColor.get(from: self.type)
        
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
            
            label.text = String("Offense / Defense")
            return label
        }()
    }
}


// MARK: - computed property
extension TypeDetailTVC {
    
    var headerViewWidth: CGFloat {
        return tableView.frame.width
    }
    
    var headerViewHeight: CGFloat {
        return segmentControl.frame.height + 16
    }
}


// MARK: - computing for strongness and weaknesses
extension TypeDetailTVC {
    
    func getStrongness() {
        
        for type in CONSTANTS.allTypes {
            if let typeDict = CONSTANTS.weaknessesJSON[type] as? DictionarySS, let effective = typeDict[self.type], effective == "2" {
                strongAgainstTypes.append(type)
            }
        }
    }
    
    func getWeaknesses() {
        
        if let weaknessesDict = CONSTANTS.weaknessesJSON[type] as? DictionarySS {
            for (type, effective) in weaknessesDict {
                switch effective {
                    
                case "2": //weak against
                    weakToTypes.append(type)
                    
                case "1/2": //strong against
                    resistToTypes.append(type)
                    
                case "0": //immune against
                    immuneToTypes.append(type)
                    
                default: () // value = ""
                }
            }
        }
    }
}
