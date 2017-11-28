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
        configureCell()
    }
    
    private func configureCell() {
        pokemonID.font = Constant.Font.gillSans
        pokemonImg.contentMode = .scaleAspectFill
    }
    
    func configureCell(for pokemon: Pokemon) {
        
        pokemonName.text = pokemon.info.name
        pokemonID.text = pokemon.info.id.toPokedexId()
        
        if let cachedImage = globalCache.object(forKey: pokemon.imageAssetName as AnyObject) as? UIImage {
            self.pokemonImg.image = cachedImage
            
        } else {
            DispatchQueue.main.async {
                guard let image = UIImage(named: pokemon.imageAssetName) else { return }
                self.pokemonImg.image = image
                globalCache.setObject(image, forKey: pokemon.imageAssetName as AnyObject)
            }
        }
    }
}
