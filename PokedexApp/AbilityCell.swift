//
//  AbilityCell.swift
//  PokedexApp
//
//  Created by Dara on 4/15/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityCell: UITableViewCell {

    @IBOutlet weak var ability: UILabel!
    @IBOutlet weak var pokemon: UILabel!
    
    private var pokemonBackgroundColor: UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonBackgroundColor = UIColor.black
        pokemon.backgroundColor = pokemonBackgroundColor
        pokemon.textColor = UIColor.white
        pokemon.font = UIFont(name: "GillSans", size: 15)
        pokemon.layer.cornerRadius = pokemon.frame.height / 2
        pokemon.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        pokemon.backgroundColor = pokemonBackgroundColor
    }

    func configureCell(ability: Ability) {
        
        self.ability.text = ability.name
        self.pokemon.text = ability.pokemon
    }
}
