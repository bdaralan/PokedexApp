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
        
        performSegue(withIdentifier: "PokedexTVC", sender: nil)
    }
}
