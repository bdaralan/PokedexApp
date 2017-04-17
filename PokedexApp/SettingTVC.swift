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
        
        loadSettingsFromUserDefault()
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
    
    func loadSettingsFromUserDefault() {
        
        print(UserDefaults.standard.integer(forKey: KEYS.Setting.measurementUnit))
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: KEYS.Setting.measurementUnit)
    }
    
    // MARK: - IBActions
    @IBAction func measurementSCValueChanged(_ sender: Any) {
        
        if let userSelectedUnit = Unit(rawValue: measurementSC.selectedSegmentIndex) {
            UserDefaults.standard.set(userSelectedUnit.rawValue, forKey: KEYS.Setting.measurementUnit)
        }
    }
}
