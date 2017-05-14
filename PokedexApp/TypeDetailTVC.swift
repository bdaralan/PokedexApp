//
//  TypeDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailTVC: UITableViewController {
    
    @IBOutlet weak var strongAgainstSectionLbl: SectionUILabel!
    @IBOutlet weak var weakToSectionLbl: SectionUILabel!
    @IBOutlet weak var resistToSectionLbl: SectionUILabel!
    @IBOutlet weak var immuneToSectionLbl: SectionUILabel!
    
    @IBOutlet weak var strongAgainstView: UIView!
    @IBOutlet weak var weakToView: UIView!
    @IBOutlet weak var resistToView: UIView!
    @IBOutlet weak var immuneToView: UIView!
    
    var offenseDefenseLbl: UILabel!
    var segmentControl: RoundUISegmentedControl!
    
    var type: String! //will be assigned by segue
    var pokemons: [Pokemon]!
    var moves: [Move]!
    
    var strongAgainstTypes = [String]()
    var weakToTypes = [String]()
    var resistToTypes = [String]()
    var immuneToTypes = [String]()
    
    let margin: CGFloat = 16
    let spacing: CGFloat = 8
    
    let offensiveDefensiveSection = 0
    let pokemonMoveSection = 1
    let pokemonSegIndex = 0
    let moveSegIndex = 1
    
    let cache = NSCache<AnyObject, AnyObject>()
    var allTypeLabels = [[TypeUILabel](), [TypeUILabel](), [TypeUILabel](), [TypeUILabel]()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = CONSTANTS.allPokemonsSortedById.filter(forType: type)
        moves = CONSTANTS.allMoves.filter(forType: type)
        
        prepareHeaderViews()
        //        updateUI()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2 // NOTE: - OffensiveDefensiveCell and Pokemon/Move Section (use segmentControl)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case offensiveDefensiveSection:
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
            
        case offensiveDefensiveSection: ()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OffensiveDefensiveCell") as? OffensiveDefensiveCell {
            cell.configureCell(forType: type)
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
            
        case offensiveDefensiveSection:
            sectionHeaderView.addSubview(offenseDefenseLbl)
            
        case pokemonMoveSection:
            sectionHeaderView.addSubview(segmentControl)
            
        default: ()
            
        }
        
        return sectionHeaderView
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        if segmentControl.selectedSegmentIndex == pokemonSegIndex {
    //            performSegue(withIdentifier: "PokemonInfoVC", sender: pokemons[indexPath.row])
    //
    //        } else { //must be moveSegIndex, because only have these two options
    //            performSegue(withIdentifier: "MoveDetailVC", sender: moves[indexPath.row])
    //        }
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pokemonInfoVC = segue.destination as? PokemonInfoVC, let pokemon = sender as? Pokemon {
            pokemonInfoVC.pokemon = pokemon
            
        } else if let moveDetailVC = segue.destination as? MoveDetailVC, let move = sender as? Move {
            moveDetailVC.move = move
        }
    }
    
    //    func handleTypeLblTapped(_ sender: UITapGestureRecognizer) {
    //
    //        if let typeLbl = sender.view as? TypeUILabel, self.title != typeLbl.text {
    //            audioPlayer.play(audio: .select)
    //            self.type = typeLbl.text
    //            self.updateUI()
    //        }
    //    }
    //
    func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        // ReloadData and scroll to top
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
    }
    //
    //    func updateUI() {
    //
    //        self.title = type
    //
    //        setDefaultState()
    //
    //        if let _ = cache.object(forKey: type as AnyObject) as? String,
    //            let cachedPokemons = cache.object(forKey: "cachedPokemons\(type)" as AnyObject) as? [Pokemon],
    //            let cachedMoves = cache.object(forKey: "cachedMoves\(type)" as AnyObject) as? [Move],
    //            let cachedStrongAgainstTypes = cache.object(forKey: "strongAgainstTypes\(type)" as AnyObject) as? [String],
    //            let cachedWeakToTypes = cache.object(forKey: "weakToTypes\(type)" as AnyObject) as? [String],
    //            let cachedResistToTypes = cache.object(forKey: "resisToTypes\(type)" as AnyObject) as? [String],
    //            let cachedImmuneToTypes = cache.object(forKey: "immuneToTypes\(type)" as AnyObject) as? [String] {
    //
    //            pokemons = cachedPokemons
    //            moves = cachedMoves
    //            strongAgainstTypes = cachedStrongAgainstTypes
    //            weakToTypes = cachedWeakToTypes
    //            resistToTypes = cachedResistToTypes
    //            immuneToTypes = cachedImmuneToTypes
    //
    //        } else {
    //            pokemons = CONSTANTS.allPokemonsSortedById.filter(forType: type)
    //            moves = CONSTANTS.allMoves.filter(forType: type)
    //            getStrongness(from: CONSTANTS.allTypes)
    //            getWeaknesses()
    //        }
    //
    //        add(typeLbls: strongAgainstTypes.sorted(), to: strongAgainstView)
    //        strongAgainstView.setOriginBelow(strongAgainstSectionLbl)
    //        strongAgainstView.sizeToContent()
    //
    //        weakToSectionLbl.setOriginBelow(strongAgainstView, spacing: spacing * 3)
    //
    //        add(typeLbls: weakToTypes.sorted(), to: weakToView)
    //        weakToView.setOriginBelow(weakToSectionLbl)
    //        weakToView.sizeToContent()
    //
    //        resistToSectionLbl.setOriginBelow(weakToView, spacing: spacing * 3)
    //
    //        add(typeLbls: resistToTypes.sorted(), to: resistToView)
    //        resistToView.setOriginBelow(resistToSectionLbl)
    //        resistToView.sizeToContent()
    //
    //        immuneToSectionLbl.setOriginBelow(resistToView, spacing: spacing * 3)
    //
    //        add(typeLbls: immuneToTypes.sorted(), to: immuneToView)
    //        immuneToView.setOriginBelow(immuneToSectionLbl)
    //        immuneToView.sizeToContent()
    //
    //        segmentControl.tintColor = UIColor.myColor.get(from: type)
    //        segmentControl.layer.borderColor = segmentControl.tintColor.cgColor
    //
    //        tableView.tableHeaderView?.frame.size.height = immuneToView.frame.origin.y + immuneToView.frame.height + spacing * 3
    //        tableView.reloadData()
    //
    //        DispatchQueue.main.async {
    //            self.cacheNecessaryData()
    //        }
    //    }
    //
    //    func setDefaultState() {
    //    }
    //
    //    func cacheNecessaryData() {
    //
    //        self.cache.setObject(type as AnyObject, forKey: type as AnyObject)
    //        self.cache.setObject(Array(pokemons) as AnyObject, forKey: "cachedPokemons\(type)" as AnyObject)
    //        self.cache.setObject(Array(moves) as AnyObject, forKey: "cachedMoves\(type)" as AnyObject)
    //        self.cache.setObject(strongAgainstTypes as AnyObject, forKey: "strongAgainstTypes\(type)" as AnyObject)
    //        self.cache.setObject(weakToTypes as AnyObject, forKey: "weakToTypes\(type)" as AnyObject)
    //        self.cache.setObject(resistToTypes as AnyObject, forKey: "resisToTypes\(type)" as AnyObject)
    //        self.cache.setObject(immuneToTypes as AnyObject, forKey: "immuneToTypes\(type)" as AnyObject)
    //        self.cache.setObject(allTypeLabels as AnyObject, forKey: "allTypeLabels\(type)" as AnyObject)
    //    }
    //
    func prepareHeaderViews() {
        
        let typeColor = UIColor.myColor.get(from: self.type)
        let alpha: CGFloat = 0.7
        
        segmentControl = {
            let sc = RoundUISegmentedControl(items: ["Pokemon", "Move"])
            sc.frame.origin = CGPoint(x: spacing, y: spacing)
            sc.frame.size.width = tableView.frame.width - spacing * 2
            sc.tintColor = typeColor
            sc.layer.borderColor = typeColor.cgColor
            sc.backgroundColor = UIColor(white: 1, alpha: alpha)
            
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
    
    func getStrongness(from types: [String]) {
        
        for type in types {
            if let typeDict = CONSTANTS.weaknessesJSON[type] as? DictionarySS {
                if let effective = typeDict[self.type], effective == "2" {
                    strongAgainstTypes.append(type)
                }
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


// MARK: - generate type labels and add to views
extension TypeDetailTVC {
    
    //    func add(typeLbls: [String], to view: UIView) {
    //
    //        if let cachedAllTypeLabels = cache.object(forKey: "allTypeLabels\(type)" as AnyObject) as? [[TypeUILabel]] {
    //            allTypeLabels = cachedAllTypeLabels
    //            for label in allTypeLabels[view.tag] {
    //                view.addSubview(label)
    //            }
    //
    //        } else {
    //            var x: CGFloat = margin
    //            var y: CGFloat = 0
    //
    //            if typeLbls.count > 0 {
    //
    //                for type in typeLbls {
    //                    let typeLbl: TypeUILabel = {
    //                        let label = TypeUILabel()
    //                        label.text = type
    //                        label.backgroundColor = UIColor.myColor.get(from: type)
    //                        label.frame.origin.x = x
    //                        label.frame.origin.y = y
    //
    //                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTypeLblTapped(_:)))
    //                        label.addGestureRecognizer(tapGesture)
    //                        label.isUserInteractionEnabled = true
    //
    //                        return label
    //                    }()
    //
    //                    view.addSubview(typeLbl)
    //
    //                    allTypeLabels[view.tag].append(typeLbl)
    //
    //                    x = x + typeLbl.frame.width + spacing
    //
    //                    if x + typeLbl.frame.width + spacing > view.frame.width - spacing {
    //                        x = margin
    //                        y = y + typeLbl.frame.height + spacing
    //                    }
    //                }
    //
    //            } else {
    //                let noneLbl: TypeUILabel = {
    //                    let label = TypeUILabel()
    //                    label.text = "None"
    //                    label.textColor = UIColor.myColor.sectionText
    //                    label.backgroundColor = UIColor.myColor.ability
    //                    label.frame.origin.x = x
    //                    label.frame.origin.y = y
    //                    
    //                    return label
    //                }()
    //                
    //                view.addSubview(noneLbl)
    //                
    //                allTypeLabels[view.tag].append(noneLbl)
    //            }
    //        }
    //    }
}
