//
//  PokedexCell.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokedexCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(pokemon: Pokemon) {
        
        pokemonImg.contentMode = .scaleAspectFit
        pokemonImg.image = UIImage(named: pokemon.hasForm ? "\(pokemon.id)-\(pokemon.form)" : "\(pokemon.id)")
        pokemonName.text = pokemon.name
        pokemonID.text = pokemon.id.toPokedexID()
    }
}
