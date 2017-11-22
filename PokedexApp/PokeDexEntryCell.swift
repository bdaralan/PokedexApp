//
//  PokeDexEntryCell.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/22/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokeDexEntryCell: UITableViewCell {
    
    let entryLabel = RIOUILabel()
    let entryTextView = UITextView()
    
    var pokemon: DBPokemon!
    
    public static var defaultCellHeight: CGFloat { return 90 }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
    
    private func configureCell() {
        configureEntryLabel()
        configureEntryTextView()
        configureConstraints()
        configureCell(pokemon: nil)
    }
    
    public func configureCell(pokemon: DBPokemon?) {
//        self.pokemon = pokemon
        let pokemon = PokeData.pokemonMap["0282Gardevoir"]!
        entryLabel.roundLabel.text = pokemon.info.id.toPokedexId()
        entryLabel.text = "Pokedex Entry"
        entryTextView.text =
        """
        Placeholder Text Placeholder Text Placeholder Text Placeholder Text Placeholder Text Placeholder Text
        Placeholder Text Placeholder Text Placeholder Text Placeholder Text Placeholder Text Placeholder Text
        Placeholder Text Placeholder Text Placeholder Text Placeholder Text Placeholder Text Placeholder Text
        """
    }
    
    private func configureEntryLabel() {
        entryLabel.changeStyle(to: .longInsetLeft)
        entryLabel.roundLabel.layer.borderWidth = 0
        entryLabel.textAlignment = .center
    }
    
    private func configureEntryTextView() {
        entryTextView.isEditable = false
    }
    
    private func configureConstraints() {
        entryLabel.translatesAutoresizingMaskIntoConstraints = false
        entryTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(entryLabel)
        contentView.addSubview(entryTextView)
        
        let margin: CGFloat = 16
        let spacing: CGFloat = 8
        // entryLabel
        entryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin).isActive = true
        entryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
        entryLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        entryLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        // entryTextView
        entryTextView.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: spacing).isActive = true
        entryTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
        entryTextView.leadingAnchor.constraint(equalTo: entryLabel.leadingAnchor).isActive = true
        entryTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
    }
}
