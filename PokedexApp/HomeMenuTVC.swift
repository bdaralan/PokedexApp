//
//  HomeMenuTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/28/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class HomeMenuTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    deinit { print("deinit", self) }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        audioPlayer.play(audio: .select)
        
        let genericCell = GenericCell(rawValue: "\(indexPath.section)\(indexPath.row)")
        
        let title = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        performSegue(withIdentifier: "GenericTVC", sender: (genericCell, title))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let genericTVC = segue.destination as? GenericTVC, let (genericCell, title) = sender as? (GenericCell, String) {
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
