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

    var disclaimerView: AnimatableView?
    var creditView: AnimatableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettingFromUserDefaults()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer.play(audio: AVAudioPlayer.ResourceAudioFile.save)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        disclaimerView?.removeFromSuperview()
        creditView?.removeFromSuperview()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let selectedRow = SettingRow(rawValue: "\(indexPath.section)\(indexPath.row)") {
            
            switch selectedRow {
                
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
                
                let disclaimer = "Disclaimer:\n● This is for practice and learning purposes only.\n● All contents, arts, assets, and data belong to their respective owners."
                
                guard let navBar = self.navigationController?.navigationBar else { return }
                
                disclaimerView = AnimatableView(text: disclaimer)

                if let disclaimerView = disclaimerView {
                    disclaimerView.center.x *= 3 //set it off the scren, to the right
                    
                    self.navigationController?.view.insertSubview(disclaimerView, belowSubview: navBar)
                    
                    let fromValue = NSValue(cgPoint: disclaimerView.center)
                    let toValue = NSValue(cgPoint: CGPoint(x: self.view.center.x, y: disclaimerView.center.y))
                    
                    disclaimerView.animatePosition(fromValue: fromValue, toValue: toValue)
                }
                
            case .credits:
                audioPlayer.play(audio: .select)
                
                let credit = "Data Resources:\n● Bulbapedia\n● PokemonDB\n● Official Pokemon Site\n● Phasma\n● Veekun"
                
                guard let navBar = self.navigationController?.navigationBar else { return }
                
                creditView = AnimatableView(text: credit)
                
                if let creditView = creditView {
                    creditView.center.x *= 3 //set it off the scren, to the right
                    
                    self.navigationController?.view.insertSubview(creditView, belowSubview: navBar)
                    
                    let fromValue = NSValue(cgPoint: CGPoint(x: creditView.center.x, y: creditView.center.y))
                    let toValue = NSValue(cgPoint: CGPoint(x: self.view.center.x, y: creditView.center.y))
                    
                    creditView.animatePosition(fromValue: fromValue, toValue: toValue)
                }
                
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
}
