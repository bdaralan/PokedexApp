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
    @IBOutlet weak var pokeEvolutionArr01Img: UIImageView!
    @IBOutlet weak var pokeEvolutionArr02Img: UIImageView!
    
    var pokemon: Pokemon!
    var evolutions: [Pokemon]!
    var viewLauncher: ViewLauncher!
    var userSelectedUnit: Unit!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSelectedUnit = Unit(rawValue: UserDefaults.standard.integer(forKey: CONSTANTS.keys.setting.measurementSCSelectedIndex))
        
        DispatchQueue.main.async {
            self.updateEvolutionUI()
        }
        
        configureTappedGestures()
        configureViewLauncher()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.updatePokemonStatsProgressViews()
        }
    }
    
    @IBAction func cryBarBtnPressed(_ sender: Any) {
        
        audioPlayer.play(audio: pokemon.crySound)
    }
    
    // MARK: - Functions
    func updateUI() {
        
        if !pokemon.hasCompletedInfo {
            pokemon.parseCompletedInfo()
        }
        
        self.navigationItem.title = pokemon.name
        pokeIdLbl.text = pokemon.id.toPokedexId()
        pokeImgView.image = UIImage(named: pokemon.imageName)
        
        pokeType01Lbl.text = pokemon.primaryType
        pokeType01Lbl.backgroundColor = UIColor.myColor.get(from: pokemon.primaryType)
        
        if pokemon.hasSecondType {
            pokeType02Lbl.isHidden = false
            pokeType02Lbl.text = pokemon.secondaryType
            pokeType02Lbl.backgroundColor = UIColor.myColor.get(from: pokemon.secondaryType)
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
    
    func updateEvolutionUI() {
        
        if let cachedEvolutions = globalCache.object(forKey: "cachedEvolutions\(pokemon.name)" as AnyObject) as? [Pokemon] {
            evolutions = cachedEvolutions
        } else {
            evolutions = pokemon.evolutions
            globalCache.setObject(evolutions as AnyObject, forKey: "cachedEvolutions\(pokemon.name)" as AnyObject)
        }
        
        switch evolutions.count {
            
        case 1:
            pokeEvolution01Img.image = UIImage(named: evolutions[0].imageName)
            pokeEvolution01Img.isHidden = false
            pokeEvolution01Img.isUserInteractionEnabled = true
            
        case 2:
            pokeEvolution01Img.image = UIImage(named: evolutions[0].imageName)
            pokeEvolution01Img.isHidden = false
            pokeEvolution01Img.isUserInteractionEnabled = true
            
            pokeEvolution02Img.image = UIImage(named: evolutions[1].imageName)
            pokeEvolution02Img.isHidden = false
            pokeEvolution02Img.isUserInteractionEnabled = true
            
            pokeEvolutionArr01Img.isHidden = false
            
        case 3:
            pokeEvolution01Img.image = UIImage(named: evolutions[0].imageName)
            pokeEvolution01Img.isHidden = false
            pokeEvolution01Img.isUserInteractionEnabled = true
            
            pokeEvolution02Img.image = UIImage(named: evolutions[1].imageName)
            pokeEvolution02Img.isHidden = false
            pokeEvolution02Img.isUserInteractionEnabled = true
            
            pokeEvolution03Img.image = UIImage(named: evolutions[2].imageName)
            pokeEvolution03Img.isHidden = false
            pokeEvolution03Img.isUserInteractionEnabled = true
            
            pokeEvolutionArr01Img.isHidden = false
            pokeEvolutionArr02Img.isHidden = false
            
        default: () //0
        }
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
        
        configureLongPressGesture(for: measurementSectionLbl, action: #selector(handleSectionLblPress))
        measurementSectionLbl.isUserInteractionEnabled = true
        measurementSectionLbl.layer.borderColor = UIColor.myColor.clear.cgColor
        measurementSectionLbl.layer.borderWidth = 2
        
        configureLongPressGesture(for: pokedexEnterySectionLbl, action: #selector(handleSectionLblPress))
        pokedexEnterySectionLbl.isUserInteractionEnabled = true
        pokedexEnterySectionLbl.layer.borderColor = UIColor.myColor.clear.cgColor
        pokedexEnterySectionLbl.layer.borderWidth = 2
        
        configureLongPressGesture(for: weaknessesSectionLbl, action: #selector(handleSectionLblPress))
        weaknessesSectionLbl.isUserInteractionEnabled = true
        weaknessesSectionLbl.layer.borderColor = UIColor.myColor.clear.cgColor
        weaknessesSectionLbl.layer.borderWidth = 2
        
        configureTapGesture(for: pokeEvolution01Img, action: #selector(handleEvolutionPress(_:)))
        configureTapGesture(for: pokeEvolution02Img, action: #selector(handleEvolutionPress(_:)))
        configureTapGesture(for: pokeEvolution03Img, action: #selector(handleEvolutionPress(_:)))
    }
    
    func configureLongPressGesture(for view: UIView, action: Selector) {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: action)
        longPress.minimumPressDuration = 0
        
        view.addGestureRecognizer(longPress)
    }
    
    func configureTapGesture(for view: UIView, action: Selector) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureViewLauncher() {
        
        viewLauncher = ViewLauncher(swipeToDismissDirection: .up)
        viewLauncher.setSuperview(self.view)
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
    
    func handleSectionLblPress(_ sender: UILongPressGestureRecognizer) {
        
        if let senderView = sender.view {
            
            switch senderView {
                
            case measurementSectionLbl:
                if sender.state == .began {
                    measurementSectionLbl.isUserInteractionEnabled = false
                    measurementSectionLbl.layer.borderColor = UIColor.myColor.sectionText.cgColor
                } else if sender.state == .ended {
                    audioPlayer.play(audio: .select)
                    self.measurementSectionLbl.layer.borderColor = UIColor.myColor.clear.cgColor
                    
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
                
            case weaknessesSectionLbl:
                if sender.state == .began {
                    weaknessesSectionLbl.layer.borderColor = UIColor.myColor.sectionText.cgColor
                } else if sender.state == .ended {
                    audioPlayer.play(audio: .select)
                    weaknessesSectionLbl.layer.borderColor = UIColor.myColor.clear.cgColor
                    if viewLauncher.isIdle {
                        let weaknessesView = viewLauncher.getWeaknessView(of: pokemon)
                        viewLauncher.addSubview(weaknessesView)
                        viewLauncher.launch()
                    }
                }
                
            case pokedexEnterySectionLbl:
                if sender.state == .began {
                    pokedexEnterySectionLbl.layer.borderColor = UIColor.myColor.sectionText.cgColor
                } else if sender.state == .ended  {
                    audioPlayer.play(audio: .select)
                    pokedexEnterySectionLbl.layer.borderColor = UIColor.myColor.clear.cgColor
                    if viewLauncher.isIdle {
                        let pokedexEntryTextView = viewLauncher.makeTextView(withText: pokemon.getPokedexEntry())
                        viewLauncher.addSubview(pokedexEntryTextView)
                        viewLauncher.launch()
                    }
                }
                
            default: ()
            }
        }
    }
    
    func handleEvolutionPress(_ sender: UILongPressGestureRecognizer) {
        
        var shouldUpdateUI = false
        
        if let senderView = sender.view {
            switch senderView {
                
            case pokeEvolution01Img:
                if pokemon.name != evolutions[0].name {
                    pokemon = evolutions[0]
                    shouldUpdateUI = true
                }
                
            case pokeEvolution02Img:
                if pokemon.name != evolutions[1].name {
                    pokemon = evolutions[1]
                    shouldUpdateUI = true
                }
                
            case pokeEvolution03Img:
                if pokemon.name != evolutions[2].name {
                    pokemon = evolutions[2]
                    shouldUpdateUI = true
                }
                
            default: ()
            }
            
            if shouldUpdateUI {
                audioPlayer.play(audio: .select)
                updateUI()
                updatePokemonStatsProgressViews()
            }
        }
    }
}
