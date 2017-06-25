//
//  SettingTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/16/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit
import AVFoundation

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

// TODO: - remove hard code links

class SettingTVC: UITableViewController {
    
    @IBOutlet weak var measurementSC: UISegmentedControl!
    @IBOutlet weak var soundEffectSwitch: UISwitch!

    var disclaimerView: ViewLauncher!
    var creditView: ViewLauncher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettingFromUserDefaults()
        configureDisclaimerCreditView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer.play(audio: AVAudioPlayer.ResourceAudioFile.save)
        disclaimerView.removeFromSuperview()
        creditView.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        disclaimerView.dismiss(animated: false)
        creditView.dismiss(animated: false)
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let selectedRow = SettingRow(rawValue: "\(indexPath.section)\(indexPath.row)") {
            
            switch selectedRow {
                
            case .iDara09GitHub:
                guard let url = URL(string: "https://github.com/iDara09") else { return }
                UIApplication.shared.open(url)
                
            case .sourceCode:
                guard let url = URL(string: "https://github.com/iDara09/PokedexApp") else { return }
                UIApplication.shared.open(url)
                
            case.disclaimer:
                audioPlayer.play(audio: .select)
                disclaimerView.launch()
                
            case .credits:
                audioPlayer.play(audio: .select)
                creditView.launch()
                
            default: ()
            }
        }
    }
    
    
    
    
    // MARK: - IBActions
    
    @IBAction func measurementSCValueChanged(_ sender: UISegmentedControl) {
        
        UserDefaults.standard.set(measurementSC.selectedSegmentIndex, forKey: Constant.Key.Setting.measurementSCSelectedIndex)
    }
    
    @IBAction func soundEffectSwitchToggled(_ sender: UISwitch) {
        
        UserDefaults.standard.set(sender.isOn, forKey: Constant.Key.Setting.soundEffectSwitchState)
        if sender.isOn { audioPlayer.play(audio: .select) }
    }
    
    
    
    // MARK: - Initializer and Handler
    
    func loadSettingFromUserDefaults() {
        
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: Constant.Key.Setting.measurementSCSelectedIndex)
        soundEffectSwitch.isOn = UserDefaults.standard.bool(forKey: Constant.Key.Setting.soundEffectSwitchState)
    }
    
    func configureDisclaimerCreditView() {
        
        // Create frame
        let y = Constant.Constrain.frameUnderNavController.origin.y
        let width = self.view.frame.width
        let height = self.view.frame.height - y
        let frame = CGRect(x: 0, y: y, width: width, height: height)
        
        // Setup disclaimer viewlauncher
        disclaimerView = ViewLauncher(frame: frame)
        UIApplication.shared.keyWindow?.addSubview(disclaimerView)
        disclaimerView.dismiss(animated: false)
        
        let disclaimer = "Disclaimer:\n● This is for practice and learning purposes only.\n● All contents, arts, assets, and data belong to their respective owners."
        disclaimerView.launchView.addTextView(text: disclaimer)
        
        // Setup credit viewlauncher
        creditView = ViewLauncher(frame: frame)
        UIApplication.shared.keyWindow?.addSubview(creditView)
        creditView.dismiss(animated: false)
        
        let credit = "Data Resources:\n● Bulbapedia\n● PokemonDB\n● Official Pokemon Site\n● Phasma\n● Veekun"
        creditView.launchView.addTextView(text: credit)
    }
}
