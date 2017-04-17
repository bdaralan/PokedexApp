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
    
    private var settingSections: [String]!
    private var settingRowsInSections: [[String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSections = loadData.settingSections()
        settingRowsInSections = loadData.settingRowsInSections()
        
        // MARK: - Load settings from UserDefauls
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: KEYS.Setting.measurementUnit)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // MARK: - Save settings to UserDefauls
        UserDefaults.standard.set(measurementSC.selectedSegmentIndex, forKey: KEYS.Setting.measurementUnit)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {

        return settingSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return settingRowsInSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
