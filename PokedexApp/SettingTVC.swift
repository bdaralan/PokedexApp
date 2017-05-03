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

enum SettingRow: String {
    case measurementUnit = "00"
    case section10 = "10"
    case section11 = "11"
    case iDara09GitHub = "20"
    case sourceCode = "21"
    case disclaimer = "22"
    case credits = "23"
}

// TODO: - remove hard code links and revampe viewLauncher

class SettingTVC: UITableViewController {
    
    @IBOutlet weak var measurementSC: UISegmentedControl!
    
    var viewLauncher: ViewLauncher!
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettingFromUserDefaults()
        configureViewLauncher()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewLauncher.dismiss()
        saveSettingToUserDefaults()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewLauncher.removeFromSuperview()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let selectedRow = SettingRow(rawValue: "\(indexPath.section)\(indexPath.row)") {
            
            switch selectedRow {
            case .measurementUnit: ()
            case .section10: ()
            case .section11: ()
            case .iDara09GitHub:
                if let url = URL(string: "https://github.com/iDara09") {
                    UIApplication.shared.open(url)
                }
                
            case .sourceCode:
                if let url = URL(string: "https://github.com/iDara09/PokedexApp") {
                    UIApplication.shared.open(url)
                }
                
            case.disclaimer:
                textView.text = "Disclaimer:\n- This is for practice and learning purposes only.\n- All contents, arts, assets, and data belong to their respective owners."
                viewLauncher.addSubview(textView)
                viewLauncher.launch(withHeight: textView.frame.height)
//                if let url = URL(string: "https://github.com/iDara09/PokedexApp#disclaimer") {
//                    UIApplication.shared.open(url)
//                }
                
            case .credits:
                textView.text = "Data Resources:\n- Bulbapedia\n- PokemonDB\n- Official Pokemon Site"
                viewLauncher.addSubview(textView)
                viewLauncher.launch(withHeight: textView.frame.height)
//                if let url = URL(string: "https://github.com/iDara09/PokedexApp#data-resources") {
//                    UIApplication.shared.open(url)
//                }
            }
        }
    }
    
    func loadSettingFromUserDefaults() {
        
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: KEYS.Setting.measurementSCSelectedIndex)
    }
    
    func saveSettingToUserDefaults() {
        
        UserDefaults.standard.set(measurementSC.selectedSegmentIndex, forKey: KEYS.Setting.measurementSCSelectedIndex)
    }
    
    func configureViewLauncher() {
        
        if let navController = self.navigationController {
            let x = navController.view.frame.origin.x
            let y = navController.navigationBar.frame.origin.y + navController.navigationBar.frame.height + 0.5
            let width = navController.view.frame.width
            let height = navController.view.frame.height
            
            let launchViewFrame = CGRect(x: x, y: y, width: width, height: height)
            let dimViewFrame = CGRect(x: x, y: y, width: width, height: height)
            
            viewLauncher = ViewLauncher(launchViewFrame: launchViewFrame, dimViewFrame: dimViewFrame, swipeToDismissDirection: .right)
            viewLauncher.isRemoveSubviewsAfterDimissed = false
            viewLauncher.dismissOrigin = CGPoint(x: launchViewFrame.width, y: launchViewFrame.origin.y)
            
            if let keyWindow = UIApplication.shared.keyWindow {
                viewLauncher.setSuperview(keyWindow)
            }
        
        }
        
        let margin = CONSTANTS.constrain.margin
        
        textView = UITextView(frame: CGRect(x: margin, y: 0, width: viewLauncher.launchView.frame.width - (margin * 2), height: 21))
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
    }
}
