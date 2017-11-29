//
//  HomeMenuTVC.swift
//  PokedexApp
//
//  Created by Dara on 3/28/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit
import AVFoundation

class HomeMenuTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession(category: AVAudioSessionCategoryAmbient)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PokeAudioPlayer.instance.play(soundEffect: .select)
        let genericCell = GenericCell(rawValue: "\(indexPath.section)\(indexPath.row)")
        let title = tableView.cellForRow(at: indexPath)?.textLabel?.text
        performSegue(withIdentifier: "GenericTVC", sender: (genericCell, title))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let genericTVC = segue.destination as? GenericTVC, let (genericCell, title) = sender as? (GenericCell, String) else { return }
        genericTVC.genericCell = genericCell
        genericTVC.title = title
    }
    
    // MARK: - IBActions
    
    @IBAction func settingBtnPressed(_ sender: Any) {
        PokeAudioPlayer.instance.play(soundEffect: .openPC)
        performSegue(withIdentifier: "SettingTVC", sender: nil)
    }
    
    private func configureAudioSession(category: String) {
        do { try AVAudioSession.sharedInstance().setCategory(category) }
        catch { print(error.localizedDescription) }
    }
}
