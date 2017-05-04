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
    @IBOutlet weak var soundEffectSwitch: UISwitch!
    
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
        
        audioPlayer.play(audio: .save)
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
                audioPlayer.play(audio: .select)
                let text = "Disclaimer:\n● This is for practice and learning purposes only.\n● All contents, arts, assets, and data belong to their respective owners."
                let textView = viewLauncher.makeTextView(withText: text)
                viewLauncher.addSubview(textView)
                viewLauncher.launch()
//                if let url = URL(string: "https://github.com/iDara09/PokedexApp#disclaimer") {
//                    UIApplication.shared.open(url)
//                }
                
            case .credits:
                audioPlayer.play(audio: .select)
                let text = "Data Resources:\n● Bulbapedia\n● PokemonDB\n● Official Pokemon Site\n● Phasma\n● Veekun"
                let textView = viewLauncher.makeTextView(withText: text)
                viewLauncher.addSubview(textView)
                viewLauncher.launch()
//                if let url = URL(string: "https://github.com/iDara09/PokedexApp#data-resources") {
//                    UIApplication.shared.open(url)
//                }
            }
        }
    }
    
    func loadSettingFromUserDefaults() {
        
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: KEYS.Setting.measurementSCSelectedIndex)
        soundEffectSwitch.isOn = UserDefaults.standard.bool(forKey: KEYS.Setting.soundEffectSwitchState)
    }
    
    func saveSettingToUserDefaults() {
        
        UserDefaults.standard.set(measurementSC.selectedSegmentIndex, forKey: KEYS.Setting.measurementSCSelectedIndex)
        UserDefaults.standard.set(soundEffectSwitch.isOn, forKey: KEYS.Setting.soundEffectSwitchState)
    }
    
    func configureViewLauncher() {
        
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let navBarFrame = UINavigationController().navigationBar.frame
        
        let y = statusBarFrame.height + navBarFrame.height + 0.25
        let width = self.view.frame.width
        let height = navBarFrame.height
        
        let launchViewFrame = CGRect(x: 0, y: y, width: width, height: height)
        let dimViewFrame = CGRect(x: 0, y: y, width: width, height: self.view.frame.height - y)
        
        viewLauncher = ViewLauncher(launchViewFrame: launchViewFrame, dimViewFrame: dimViewFrame, swipeToDismissDirection: .right)
        
        if let window = UIApplication.shared.keyWindow {
            viewLauncher?.setSuperview(window)
        }
    }
}
