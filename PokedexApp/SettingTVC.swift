//
//  SettingTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/16/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

enum Unit: Int {
    case USCustomary
    case SI
}


class SettingTVC: UITableViewController {
    
    @IBOutlet weak var measurementSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettingFromUserDefaults()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        saveSettingToUserDefaults()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadSettingFromUserDefaults() {
        
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: KEYS.Setting.measurementSCSelectedIndex)
    }
    
    func saveSettingToUserDefaults() {
        
        UserDefaults.standard.set(measurementSC.selectedSegmentIndex, forKey: KEYS.Setting.measurementSCSelectedIndex)
    }
}
