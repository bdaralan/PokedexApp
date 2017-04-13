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
    @IBOutlet weak var pokeType01Lbl: UILabel!
    @IBOutlet weak var pokeType02Lbl: UILabel!
    
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
    var measurementDidSetToSIUnits: Bool!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        measurementDidSetToSIUnits = false // TODO: - shoulde be getting value from UserDefaults
        configureViewLauncher()
        configureTappedGestures()
        updateUI()
    }
    
    // MARK: - Functions
    func updateUI() {
        
        pokemon.parseStatsTypes()
        pokemon.parseAbilities()
        pokemon.parseMeasurement()
        
        self.title = pokemon.name
        pokeIdLbl.text = pokemon.id.toPokedexId()
        pokeImgView.image = UIImage(named: pokemon.imageName)
        
        pokeType01Lbl.text = pokemon.primaryType
        pokeType01Lbl.backgroundColor = COLORS.make(fromPokemonType: pokemon.primaryType)
        
        if pokemon.hasSecondType {
            pokeType02Lbl.isHidden = false
            pokeType02Lbl.text = pokemon.secondaryType
            pokeType02Lbl.backgroundColor = COLORS.make(fromPokemonType: pokemon.secondaryType)
            pokeType01Lbl.setLength(to: pokeType02Lbl.frame.width)
        } else {
            pokeType02Lbl.isHidden = true
            pokeType01Lbl.extend(length: pokeType02Lbl.frame.width, hasSpacing: 5)
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
        
        pokeHeightLbl.text = pokemon.getHeight(as: .USCustomaryUnits)
        pokeWeighLblt.text = pokemon.getWeight(as: .USCustomaryUnits)
        
        pokeHpLbl.text = "\(pokemon.hp)"
        pokeAttackLbl.text = "\(pokemon.attack)"
        pokeDefenseLbl.text = "\(pokemon.defense)"
        pokeSpAttackLbl.text = "\(pokemon.spAttack)"
        pokeSpDefenseLbl.text = "\(pokemon.spDefense)"
        pokeSpeedLbl.text = "\(pokemon.speed)"
        
        pokeHpPV.setProgress(pokemon.hp.toProgress(), animated: true)
        pokeAttackPV.setProgress(pokemon.attack.toProgress(), animated: true)
        pokeDefensePV.setProgress(pokemon.defense.toProgress(), animated: true)
        pokeSpAttackPV.setProgress(pokemon.spAttack.toProgress(), animated: true)
        pokeSpDefensePV.setProgress(pokemon.spDefense.toProgress(), animated: true)
        pokeSpeedPV.setProgress(pokemon.speed.toProgress(), animated: true)
    }
    
    func configureTappedGestures() {
        
        let measurmentTG = UITapGestureRecognizer(target: self, action: #selector(measurementSectionLblTapped))
        measurementSectionLbl.addGestureRecognizer(measurmentTG)
        measurementSectionLbl.isUserInteractionEnabled = true
        
        let pokedexEnteryTG = UITapGestureRecognizer(target: self, action: #selector(pokedexEnterySectionLblTapped))
        pokedexEnterySectionLbl.addGestureRecognizer(pokedexEnteryTG)
        pokedexEnterySectionLbl.isUserInteractionEnabled = true
        
        let weaknessesTG = UITapGestureRecognizer(target: self, action: #selector(weaknessesSectionLblTapped))
        weaknessesSectionLbl.addGestureRecognizer(weaknessesTG)
        weaknessesSectionLbl.isUserInteractionEnabled = true
    }
    
    func configureViewLauncher() {
        
        viewLauncher = ViewLauncher(parentView: self)
        viewLauncher.configureLauncher()
    }
    
    func toggleMeasurement() {
        
        if measurementDidSetToSIUnits {
            pokeHeightLbl.text = pokemon.getHeight(as: .USCustomaryUnits)
            pokeWeighLblt.text = pokemon.getWeight(as: .USCustomaryUnits)
        } else {
            pokeHeightLbl.text = pokemon.getHeight(as: .SIUnits)
            pokeWeighLblt.text = pokemon.getWeight(as: .SIUnits)
        }
        
        measurementDidSetToSIUnits = !measurementDidSetToSIUnits
    }
    
    func measurementSectionLblTapped() {
        
        measurementSectionLbl.isUserInteractionEnabled = false
        let originalPositionY = pokeHeightLbl.frame.origin.y
        let animateToPositionY = measurementSectionLbl.frame.origin.y
        let animatedDuration: TimeInterval = 0.25
        
        UIView.animate(withDuration: animatedDuration, animations: {
            self.pokeHeightLbl.frame.origin.y = animateToPositionY
            self.pokeHeightLbl.alpha = 0
            self.pokeWeighLblt.frame.origin.y = animateToPositionY
            self.pokeWeighLblt.alpha = 0
        }) { (Bool) in
            self.toggleMeasurement()
            UIView.animate(withDuration: animatedDuration, animations: {
                self.pokeHeightLbl.frame.origin.y = originalPositionY
                self.pokeHeightLbl.alpha = 1
                self.pokeWeighLblt.frame.origin.y = originalPositionY
                self.pokeWeighLblt.alpha = 1
            }) { (Bool) in
                self.measurementSectionLbl.isUserInteractionEnabled = true
            }
        }
    }
    
    func pokedexEnterySectionLblTapped() {
        
        viewLauncher.presentPokedexEntery(of: pokemon)
    }
    
    func weaknessesSectionLblTapped() {
        
        viewLauncher.presentWeaknesses(of: pokemon)
    }
}
