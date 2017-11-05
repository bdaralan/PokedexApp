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

    var disclaimerViewLauncher: ViewLauncher!
    var creditViewLauncher: ViewLauncher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettingFromUserDefaults()
        configureDisclaimerCreditView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AudioPlayer.play(audio: .save)
        disclaimerViewLauncher.removeFromSuperview()
        creditViewLauncher.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disclaimerViewLauncher.dismiss(animated: false)
        creditViewLauncher.dismiss(animated: false)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedRow = SettingRow(rawValue: "\(indexPath.section)\(indexPath.row)") else { return }
        switch selectedRow {
        case .iDara09GitHub:
            guard let url = URL(string: "https://github.com/iDara09") else { return }
            UIApplication.shared.open(url)
        case .sourceCode:
            guard let url = URL(string: "https://github.com/iDara09/PokedexApp") else { return }
            UIApplication.shared.open(url)
        case.disclaimer:
            AudioPlayer.play(audio: .select)
            disclaimerViewLauncher.launch()
        case .credits:
            AudioPlayer.play(audio: .select)
            creditViewLauncher.launch()
        default: ()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func measurementSCValueChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(measurementSC.selectedSegmentIndex, forKey: Constant.Key.Setting.measurementSCSelectedIndex)
    }
    
    @IBAction func soundEffectSwitchToggled(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: Constant.Key.Setting.soundEffectSwitchState)
        if sender.isOn { AudioPlayer.play(audio: .select) }
    }
    
    // MARK: - Initializer and Handler
    
    func loadSettingFromUserDefaults() {
        measurementSC.selectedSegmentIndex = UserDefaults.standard.integer(forKey: Constant.Key.Setting.measurementSCSelectedIndex)
        soundEffectSwitch.isOn = UserDefaults.standard.bool(forKey: Constant.Key.Setting.soundEffectSwitchState)
    }
    
    func configureDisclaimerCreditView() {
        // Setup disclaimer viewlauncher
        let viewLauncherFrame = Constant.Constrain.viewlauncherFrameUnderNavBar
        disclaimerViewLauncher = ViewLauncher(frame: viewLauncherFrame)
        UIApplication.shared.keyWindow?.addSubview(disclaimerViewLauncher)
        disclaimerViewLauncher.dismiss(animated: false)
        
        let disclaimer = "Disclaimer:\n● This is for practice and learning purposes only.\n● All contents, arts, assets, and data belong to their respective owners."
        disclaimerViewLauncher.launchView.addTextView(text: disclaimer)
        
        // Setup credit viewlauncher
        creditViewLauncher = ViewLauncher(frame: viewLauncherFrame)
        UIApplication.shared.keyWindow?.addSubview(creditViewLauncher)
        creditViewLauncher.dismiss(animated: false)
        
        let credit = "Data Resources:\n● Bulbapedia\n● PokemonDB\n● Official Pokemon Site\n● Phasma\n● Veekun"
        creditViewLauncher.launchView.addTextView(text: credit)
    }
}
