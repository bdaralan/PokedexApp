//
//  HomeMenuTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/28/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class HomeMenuTVC: UITableViewController {
    
    private enum HomeMenuSection: Int {
        case POKEMON
        case BAG
    }
    
    private enum HomeMenuCell: String {
        case Pokedex = "00"
        case Types = "01"
        case Moves = "02"
        case Abilities = "03"
        case TMs = "10"
        case Items = "11"
        case Berries = "12"
    }
    
    private var homeMenuSections = loadData.homeMenuSections()
    private var homeMenuRowsInSections = loadData.homeMenuRowsInSections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return homeMenuSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let homeMenuSection = HomeMenuSection(rawValue: section) {
            switch homeMenuSection {
            case .POKEMON:
                return homeMenuRowsInSections[section].count
            case .BAG:
                return homeMenuRowsInSections[section].count
            }
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if let homeMenuSection = HomeMenuSection(rawValue: indexPath.section) {
            switch homeMenuSection {
            case .POKEMON:
                cell.textLabel?.text = homeMenuRowsInSections[indexPath.section][indexPath.row]
            case .BAG:
                cell.textLabel?.text = homeMenuRowsInSections[indexPath.section][indexPath.row]
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        var segueIdentifier = ""
        var genericCell: GenericCell!
        
        if let selectedCell = HomeMenuCell(rawValue: "\(indexPath.section)\(indexPath.row)") {
            switch selectedCell {
            case .Pokedex:
                segueIdentifier = "PokedexTVC"
            case .Types:
                segueIdentifier = "GenericTVC"
                genericCell = GenericCell.TypeCell
            case .Moves:
                segueIdentifier = "GenericTVC"
                genericCell = GenericCell.MoveCell
            case .Abilities:
                segueIdentifier = "GenericTVC"
                genericCell = GenericCell.AbilityCell
            case .TMs:
                segueIdentifier = "GenericTVC"
            case .Items:
                segueIdentifier = "GenericTVC"
            case .Berries:
                segueIdentifier = "GenericTVC"
            }
        }
        
        performSegue(withIdentifier: segueIdentifier, sender: genericCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GenericTVC", let genericCell = sender as? GenericCell, let genericTVC = segue.destination as? GenericTVC {
            genericTVC.genericCell = genericCell
        }
    }
}
