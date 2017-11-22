//
//  PokeStatCell.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

private let space: CGFloat = 8
private let margin: CGFloat = 16
private let labelHeight: CGFloat = 25

/// Use with `PokemonTVC` to display Pokemon's stats.
class PokeStatCell: UITableViewCell {
    
    let labelStackView = UIStackView()
    let hpLabel = RIOUILabel()
    let attackLabel = RIOUILabel()
    let defenseLabel = RIOUILabel()
    let spAttackLabel = RIOUILabel()
    let spDefenseLabel = RIOUILabel()
    let speedLabel = RIOUILabel()
    
    let sliderStackView = UIStackView()
    let hpSlider = DBUISlider()
    let attackSlider = DBUISlider()
    let defenseSlider = DBUISlider()
    let spAttackSlider = DBUISlider()
    let spDefenseSlider = DBUISlider()
    let speedSlider = DBUISlider()
    
    var pokemon: DBPokemon!
    
    public static var defaultCellHeight: CGFloat { return (margin * 2) + (labelHeight * 6) + (space * 7) }

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
    
    public func configureCell(pokemon: DBPokemon?) {
//        self.pokemon = pokemon
        let pokemon = PokeData.pokemonMap["0280Ralts"]!
        hpLabel.roundLabel.text = "\(pokemon.stats.hp)"
        attackLabel.roundLabel.text = "\(pokemon.stats.attack)"
        defenseLabel.roundLabel.text = "\(pokemon.stats.defense)"
        spAttackLabel.roundLabel.text = "\(pokemon.stats.spAttack)"
        spDefenseLabel.roundLabel.text = "\(pokemon.stats.spDefense)"
        speedLabel.roundLabel.text = "\(pokemon.stats.speed)"
    }
    
    private func configureCell() {
        configureLabels()
        configureStackViews()
        configureConstraints()
        configureCell(pokemon: nil)
    }
    
    private func configureLabels() {
        hpLabel.changeStyle(to: .insetLong)
        hpLabel.textAlignment = .left
        hpLabel.text = "HP"
        
        attackLabel.changeStyle(to: .insetLong)
        attackLabel.textAlignment = .left
        attackLabel.text = "Attack"
        
        defenseLabel.changeStyle(to: .insetLong)
        defenseLabel.textAlignment = .left
        defenseLabel.text = "Defense"
        
        spAttackLabel.changeStyle(to: .insetLong)
        spAttackLabel.textAlignment = .left
        spAttackLabel.text = "SpAttack"
        
        spDefenseLabel.changeStyle(to: .insetLong)
        spDefenseLabel.textAlignment = .left
        spDefenseLabel.text = "SpDefense"
        
        speedLabel.changeStyle(to: .insetLong)
        speedLabel.textAlignment = .left
        speedLabel.text = "Speed"
    }
    
    private func configureStackViews() {
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.spacing = space
        labelStackView.addArrangedSubview(hpLabel)
        labelStackView.addArrangedSubview(attackLabel)
        labelStackView.addArrangedSubview(defenseLabel)
        labelStackView.addArrangedSubview(spAttackLabel)
        labelStackView.addArrangedSubview(spDefenseLabel)
        labelStackView.addArrangedSubview(speedLabel)
    
        sliderStackView.axis = .vertical
        sliderStackView.distribution = .fillEqually
        sliderStackView.spacing = space
        sliderStackView.addArrangedSubview(hpSlider)
        sliderStackView.addArrangedSubview(attackSlider)
        sliderStackView.addArrangedSubview(defenseSlider)
        sliderStackView.addArrangedSubview(spAttackSlider)
        sliderStackView.addArrangedSubview(spDefenseSlider)
        sliderStackView.addArrangedSubview(speedSlider)
    }
    
    private func configureConstraints() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelStackView)
        contentView.addSubview(sliderStackView)
        
        labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
        labelStackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        sliderStackView.topAnchor.constraint(equalTo: labelStackView.topAnchor).isActive = true
        sliderStackView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor).isActive = true
        sliderStackView.leadingAnchor.constraint(equalTo: labelStackView.trailingAnchor, constant: space).isActive = true
        sliderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
    }   
}
