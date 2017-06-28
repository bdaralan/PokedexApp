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
        
        pokemonID.font = Constant.Font.gillSans
        pokemonImg.contentMode = .scaleAspectFill
    }
    
    func configureCell(for pokemon: Pokemon) {
        
        pokemonName.text = pokemon.name
        pokemonID.text = pokemon.id.toPokedexId()
        
        if let cachedImage = globalCache.object(forKey: pokemon.imageName as AnyObject) as? UIImage {
            self.pokemonImg.image = cachedImage
            
        } else {
            DispatchQueue.main.async {
                guard let image = UIImage(named: pokemon.imageName) else { return }
                self.pokemonImg.image = image
                globalCache.setObject(image, forKey: pokemon.imageName as AnyObject)
            }
        }
    }
}
