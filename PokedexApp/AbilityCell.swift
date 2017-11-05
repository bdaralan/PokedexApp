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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
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
    
    private func configureCell() {
        pokemonLbl.backgroundColor = UIColor.black
        pokemonLbl.textColor = UIColor.white
        pokemonLbl.font = Constant.Font.gillSans
        pokemonLbl.font = UIFont(name: pokemonLbl.font.fontName, size: 15)
        pokemonLbl.layer.cornerRadius = pokemonLbl.frame.height / 2
        pokemonLbl.clipsToBounds = true
    }

    func configureCell(ability: Ability) {
        abilityLbl.text = ability.name
        pokemonLbl.text = ability.pokemon
    }
}
