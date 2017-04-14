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

    func configureCell(pokemon: Pokemon) {
        
        pokemonImg.contentMode = .scaleAspectFill
        pokemonImg.image = UIImage(named: pokemon.imageName) // TODO: - Use NSCache
        pokemonName.text = pokemon.name
        pokemonID.text = pokemon.id.toPokedexId()
    }
}
