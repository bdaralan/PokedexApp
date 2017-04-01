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
    @IBOutlet weak var pokeAibilityHiddenLbl: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
