//
//  HomeMenuTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/28/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class HomeMenuTVC: UITableViewController {
    
    @IBOutlet weak var settingBtn: UIButton!
    
    var homeMenuSections: [String]!
    var homeMenuRowsInSections: [[String]]!
    
    var genericCell: GenericCell!
    var genericTVCTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeMenuSections = loadData.homeMenuSections()
        homeMenuRowsInSections = loadData.homeMenuRowsInSections()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return homeMenuSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeMenuRowsInSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = UITableViewCell(style: .default, reuseIdentifier: "HomeMenuCell") as UITableViewCell? {
            cell.textLabel?.text = homeMenuRowsInSections[indexPath.section][indexPath.row]
            
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        genericCell = GenericCell(rawValue: "\(indexPath.section)\(indexPath.row)")
        genericTVCTitle = homeMenuRowsInSections[indexPath.section][indexPath.row]
        
        performSegue(withIdentifier: "GenericTVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GenericTVC", let genericTVC = segue.destination as? GenericTVC {
            genericTVC.genericCell = genericCell
            genericTVC.title = genericTVCTitle
        }
    }
    
    // MARK: - IBActions
    @IBAction func settingBtnPressed() {
        
        performSegue(withIdentifier: "Setting", sender: nil)
    }
}
