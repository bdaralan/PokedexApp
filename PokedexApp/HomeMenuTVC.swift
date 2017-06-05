//
//  HomeMenuTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/28/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class HomeMenuTVC: UITableViewController {
    
    var homeMenuSections: [String]!
    var homeMenuRowsInSections: [[String]]!
    
    var genericCell: GenericCell!
    var genericTVCTitle: String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        homeMenuSections = LoadData.homeMenuSections
        homeMenuRowsInSections = LoadData.homeMenuRowsInSections
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return homeMenuSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeMenuRowsInSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        audioPlayer.play(audio: .select)
        
        genericCell = GenericCell(rawValue: "\(indexPath.section)\(indexPath.row)")
        genericTVCTitle = homeMenuRowsInSections[indexPath.section][indexPath.row]
        
        performSegue(withIdentifier: "GenericTVC", sender: genericTVCTitle)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let genericTVC = segue.destination as? GenericTVC, let title = sender as? String {
            genericTVC.genericCell = genericCell
            genericTVC.title = title
        }
    }
    
    
    
    
    // MARK: - IBActions
    
    @IBAction func settingBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "SettingTVC", sender: nil)
        audioPlayer.play(audio: .openPC)
    }
}
