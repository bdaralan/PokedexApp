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
        
        pokemonID.font = UIFont(name: "GillSans", size: 17)
        pokemonImg.contentMode = .scaleAspectFill
    }

    func configureCell(pokemon: Pokemon) {
    
        pokemonName.text = pokemon.name
        pokemonID.text = pokemon.id.toPokedexId()
        
        if let image = globalCache.object(forKey: pokemon.imageName as AnyObject) as? UIImage {
            pokemonImg.image = image
        } else {
            if let image = UIImage(named: pokemon.imageName) {
                self.pokemonImg.image = image
                globalCache.setObject(image, forKey: pokemon.imageName as AnyObject)
            }
        }
    }
}
