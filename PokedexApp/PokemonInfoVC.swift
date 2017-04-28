//
//  PokemonInfoVC.swift
//  PokedexApp
//
//  Created by Dara on 3/31/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokemonInfoVC: UIViewController {
    
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var pokeImgView: UIImageView!
    
    @IBOutlet weak var pokeHeightLbl: UILabel!
    @IBOutlet weak var pokeWeighLblt: UILabel!
    @IBOutlet weak var pokeType01Lbl: TypeUILabel!
    @IBOutlet weak var pokeType02Lbl: TypeUILabel!
    
    @IBOutlet weak var pokeAbility01Lbl: UILabel!
    @IBOutlet weak var pokeAbility02Lbl: UILabel!
    @IBOutlet weak var pokeHiddenAibilityLbl: UILabel!
    
    @IBOutlet weak var measurementSectionLbl: UILabel!
    @IBOutlet weak var pokedexEnterySectionLbl: UILabel!
    @IBOutlet weak var weaknessesSectionLbl: UILabel!
    
    @IBOutlet weak var pokeHpLbl: UILabel!
    @IBOutlet weak var pokeAttackLbl: UILabel!
    @IBOutlet weak var pokeDefenseLbl: UILabel!
    @IBOutlet weak var pokeSpAttackLbl:UILabel!
    @IBOutlet weak var pokeSpDefenseLbl: UILabel!
    @IBOutlet weak var pokeSpeedLbl: UILabel!
    @IBOutlet weak var pokeHpPV: UIProgressView!
    @IBOutlet weak var pokeAttackPV: UIProgressView!
    @IBOutlet weak var pokeDefensePV: UIProgressView!
    @IBOutlet weak var pokeSpAttackPV: UIProgressView!
    @IBOutlet weak var pokeSpDefensePV: UIProgressView!
    @IBOutlet weak var pokeSpeedPV: UIProgressView!
    
    @IBOutlet weak var pokeEvolution01Img: UIImageView!
    @IBOutlet weak var pokeEvolution02Img: UIImageView!
    @IBOutlet weak var pokeEvolution03Img: UIImageView!
    @IBOutlet weak var pokeEvolution04Img: UIImageView!
    @IBOutlet weak var pokeEvolution05Img: UIImageView!
    @IBOutlet weak var pokeEvolutionArr01Img: UIImageView!
    @IBOutlet weak var pokeEvolutionArr02Img: UIImageView!
    @IBOutlet weak var pokeEvolutionArr03Img: UIImageView!
    
    var pokemon: Pokemon!
    var viewLauncher: ViewLauncher!
    var userSelectedUnit: Unit!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSelectedUnit = Unit(rawValue: UserDefaults.standard.integer(forKey: KEYS.Setting.measurementSCSelectedIndex))
        
        configureTappedGestures()
        configureViewLauncher()
        updateUI()
        
        pokemon.parseCompletedInfo()
        let evolution = pokemon.getEvolutions()
        print(evolution)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.updatePokemonStatsProgressViews()
        }
    }
    
    // MARK: - Functions
    func updateUI() {
        
        pokemon.parseCompletedInfo()
        
        self.navigationItem.title = pokemon.name
        pokeIdLbl.text = pokemon.id.toPokedexId()
        pokeImgView.image = UIImage(named: pokemon.imageName)
        
        pokeType01Lbl.text = pokemon.primaryType
        pokeType01Lbl.backgroundColor = COLORS.get(from: pokemon.primaryType)
        
        if pokemon.hasSecondType {
            pokeType02Lbl.isHidden = false
            pokeType02Lbl.text = pokemon.secondaryType
            pokeType02Lbl.backgroundColor = COLORS.get(from: pokemon.secondaryType)
            pokeType01Lbl.setLength(to: pokeType02Lbl.frame.width)
        } else {
            pokeType02Lbl.isHidden = true
            pokeType01Lbl.setLength(to: pokeType02Lbl.frame.width * 2 + 5)
        }
        
        pokeAbility01Lbl.text = pokemon.firstAbility
        
        if pokemon.hasSecondAbility {
            pokeAbility02Lbl.text = pokemon.secondAbility
            pokeAbility02Lbl.isHidden = false
        } else {
            pokeAbility02Lbl.isHidden = true
        }
        
        if pokemon.hasHiddenAbility {
            pokeHiddenAibilityLbl.isHidden = false
            pokeHiddenAibilityLbl.text = "\(pokemon.hiddenAbility) (H)"
        } else {
            pokeHiddenAibilityLbl.isHidden = true
        }
        
        pokeHeightLbl.text = pokemon.getHeight(as: userSelectedUnit)
        pokeWeighLblt.text = pokemon.getWeight(as: userSelectedUnit)
        
        pokeHpLbl.text = "\(pokemon.hp)"
        pokeAttackLbl.text = "\(pokemon.attack)"
        pokeDefenseLbl.text = "\(pokemon.defense)"
        pokeSpAttackLbl.text = "\(pokemon.spAttack)"
        pokeSpDefenseLbl.text = "\(pokemon.spDefense)"
        pokeSpeedLbl.text = "\(pokemon.speed)"
    }
    
    func updatePokemonStatsProgressViews() {
        
        pokeHpPV.setProgress(pokemon.hp.toProgress(), animated: true)
        pokeAttackPV.setProgress(pokemon.attack.toProgress(), animated: true)
        pokeDefensePV.setProgress(pokemon.defense.toProgress(), animated: true)
        pokeSpAttackPV.setProgress(pokemon.spAttack.toProgress(), animated: true)
        pokeSpDefensePV.setProgress(pokemon.spDefense.toProgress(), animated: true)
        pokeSpeedPV.setProgress(pokemon.speed.toProgress(), animated: true)
    }
    
    func configureTappedGestures() {
        
        let measurementLongPress = UILongPressGestureRecognizer(target: self, action: #selector(measurementSectionLblPressed))
        measurementLongPress.minimumPressDuration = 0
        measurementSectionLbl.addGestureRecognizer(measurementLongPress)
        measurementSectionLbl.isUserInteractionEnabled = true
        measurementSectionLbl.layer.borderColor = COLORS.clear.cgColor
        measurementSectionLbl.layer.borderWidth = 2
        
        let pokedexEntryLongPress = UILongPressGestureRecognizer(target: self, action: #selector(pokedexEnterySectionLblPressed))
        pokedexEntryLongPress.minimumPressDuration = 0
        pokedexEnterySectionLbl.addGestureRecognizer(pokedexEntryLongPress)
        pokedexEnterySectionLbl.isUserInteractionEnabled = true
        pokedexEnterySectionLbl.layer.borderColor = COLORS.clear.cgColor
        pokedexEnterySectionLbl.layer.borderWidth = 2
        
        let weaknessesLongPress = UILongPressGestureRecognizer(target: self, action: #selector(weaknessesSectionLblPressed))
        weaknessesLongPress.minimumPressDuration = 0
        weaknessesSectionLbl.addGestureRecognizer(weaknessesLongPress)
        weaknessesSectionLbl.isUserInteractionEnabled = true
        weaknessesSectionLbl.layer.borderColor = COLORS.clear.cgColor
        weaknessesSectionLbl.layer.borderWidth = 2
    }
    
    func configureViewLauncher() {
        
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            let statusBarFrame = UIApplication.shared.statusBarFrame
            let x = navigationBarFrame.origin.x
            let y = statusBarFrame.height + navigationBarFrame.height
            let width = self.view.frame.width
            let height = self.view.frame.height
            let launchViewFrame = CGRect(x: x, y: y, width: width, height: height - y)
            let dimViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
            
            viewLauncher = ViewLauncher(launchViewFrame: launchViewFrame, dimViewFrame: dimViewFrame)
            
            self.view.addSubview(viewLauncher.dimView)
            self.view.addSubview(viewLauncher.launchView)
        }
    }
    
    func toggleMeasurement() {
        
        if userSelectedUnit == Unit.SI {
            pokeHeightLbl.text = pokemon.getHeight(as: .USCustomary)
            pokeWeighLblt.text = pokemon.getWeight(as: .USCustomary)
            userSelectedUnit = Unit.USCustomary
        } else {
            pokeHeightLbl.text = pokemon.getHeight(as: .SI)
            pokeWeighLblt.text = pokemon.getWeight(as: .SI)
            userSelectedUnit = Unit.SI
        }
    }
    
    func measurementSectionLblPressed(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            measurementSectionLbl.isUserInteractionEnabled = false
            measurementSectionLbl.layer.borderColor = COLORS.sectionText.cgColor
        } else if sender.state == .ended {
            self.measurementSectionLbl.layer.borderColor = COLORS.clear.cgColor
            
            let originalOriginY = pokeHeightLbl.frame.origin.y
            let animateToOriginY = measurementSectionLbl.frame.origin.y
            let animatedDuration: TimeInterval = 0.25
            
            UIView.animate(withDuration: animatedDuration, animations: {
                self.pokeHeightLbl.frame.origin.y = animateToOriginY
                self.pokeHeightLbl.alpha = 0
                self.pokeWeighLblt.frame.origin.y = animateToOriginY
                self.pokeWeighLblt.alpha = 0
            }) { (Bool) in
                self.toggleMeasurement()
                UIView.animate(withDuration: animatedDuration, animations: {
                    self.pokeHeightLbl.frame.origin.y = originalOriginY
                    self.pokeHeightLbl.alpha = 1
                    self.pokeWeighLblt.frame.origin.y = originalOriginY
                    self.pokeWeighLblt.alpha = 1
                }) { (Bool) in
                    self.measurementSectionLbl.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    func weaknessesSectionLblPressed(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            weaknessesSectionLbl.layer.borderColor = COLORS.sectionText.cgColor
        } else if sender.state == .ended {
            weaknessesSectionLbl.layer.borderColor = COLORS.clear.cgColor
            if viewLauncher.isIdle {
                let weaknessesView = viewLauncher.getWeaknessView(of: pokemon)
                viewLauncher.launchView.addSubview(weaknessesView)
                viewLauncher.launch(withHeight: weaknessesView.frame.height)
            }
        }
    }
    
    func pokedexEnterySectionLblPressed(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            pokedexEnterySectionLbl.layer.borderColor = COLORS.sectionText.cgColor
        } else if sender.state == .ended  {
            pokedexEnterySectionLbl.layer.borderColor = COLORS.clear.cgColor
            if viewLauncher.isIdle {
                let pokedexEntryView = viewLauncher.getPokedexEntryView(of: pokemon)
                viewLauncher.launchView.addSubview(pokedexEntryView)
                viewLauncher.launch(withHeight: pokedexEntryView.frame.height)
            }
        }
    }
}
