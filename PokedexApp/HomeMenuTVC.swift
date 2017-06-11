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
        
        do { try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient) }
        catch { print(error) }
        
        
        
        //TEST CODE HERE...
        
//        let pokemon = VARIABLE.allPokemonsSortedById[0]
//        
//        let weaknessView = AnimatableView(pokemonWeaknesses: pokemon)
//        
//        self.navigationController?.view.insertSubview(weaknessView, belowSubview: self.navigationController!.navigationBar)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animate))
//        weaknessView.addGestureRecognizer(tapGesture)
        
        
        
    }
    
//    func animate(_ sender: UITapGestureRecognizer) {
//        
//        guard let view = sender.view as? AnimatableView else { return }
//        let fromValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: -view.frame.height))
//        let toValue = NSValue(cgPoint: view.center)
//        
//        view.animatePosition(fromValue: fromValue, toValue: toValue)
//    }
    
    
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
