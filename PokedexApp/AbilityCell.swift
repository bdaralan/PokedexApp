//
//  AbilityCell.swift
//  PokedexApp
//
//  Created by Dara on 4/15/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityCell: UITableViewCell {

    @IBOutlet weak var abilityLbl: UILabel!
    @IBOutlet weak var pokemonLbl: UILabel!
    
    weak var ability: Ability!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonLbl.backgroundColor = UIColor.black
        pokemonLbl.textColor = UIColor.white
        pokemonLbl.font = UIFont(name: "GillSans", size: 15)
        pokemonLbl.layer.cornerRadius = pokemonLbl.frame.height / 2
        pokemonLbl.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let pokemonBackgroundColor = pokemonLbl.backgroundColor
        
        super.setSelected(selected, animated: animated)

        pokemonLbl.backgroundColor = pokemonBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        let pokemonBackgroundColor = pokemonLbl.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        pokemonLbl.backgroundColor = pokemonBackgroundColor
    }

    func configureCell(ability: Ability) {
        
        self.ability = ability
        
        self.abilityLbl.text = self.ability.name
        self.pokemonLbl.text = self.ability.pokemon
    }
}
