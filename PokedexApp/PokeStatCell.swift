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
    let hpSlider = UISlider()
    let attackSlider = UISlider()
    let defenseSlider = UISlider()
    let spAttackSlider = UISlider()
    let spDefenseSlider = UISlider()
    let speedSlider = UISlider()
    
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
        let pokemon = PokeData.pokemonMap["0282Gardevoir"]!
        
        // labels
        hpLabel.roundLabel.text = "\(pokemon.stats.hp)"
        attackLabel.roundLabel.text = "\(pokemon.stats.attack)"
        defenseLabel.roundLabel.text = "\(pokemon.stats.defense)"
        spAttackLabel.roundLabel.text = "\(pokemon.stats.spAttack)"
        spDefenseLabel.roundLabel.text = "\(pokemon.stats.spDefense)"
        speedLabel.roundLabel.text = "\(pokemon.stats.speed)"
        
        // slider
        hpSlider.setValue(Float(pokemon.stats.hp), animated: true)
        attackSlider.setValue(Float(pokemon.stats.attack), animated: true)
        defenseSlider.setValue(Float(pokemon.stats.defense), animated: true)
        spAttackSlider.setValue(Float(pokemon.stats.spAttack), animated: true)
        spDefenseSlider.setValue(Float(pokemon.stats.spDefense), animated: true)
        speedSlider.setValue(Float(pokemon.stats.speed), animated: true)
    }
    
    private func configureCell() {
        configureLabels()
        configureSliders()
        configureStackViews()
        configureConstraints()
        configureCell(pokemon: nil)
    }
    
    private func configureLabels() {
        hpLabel.text = "HP"
        hpLabel.textAlignment = .left
        hpLabel.changeStyle(to: .insetLong)
        hpLabel.roundLabelBorderWidth = 0
        hpLabel.backgroundColor = DBColor.PokemonStat.hp
        
        attackLabel.text = "Attack"
        attackLabel.textAlignment = .left
        attackLabel.changeStyle(to: .insetLong)
        attackLabel.roundLabelBorderWidth = 0
        attackLabel.backgroundColor = DBColor.PokemonStat.attack
        
        defenseLabel.text = "Defense"
        defenseLabel.textAlignment = .left
        defenseLabel.changeStyle(to: .insetLong)
        defenseLabel.roundLabelBorderWidth = 0
        defenseLabel.backgroundColor = DBColor.PokemonStat.defense
        
        spAttackLabel.text = "SpAttack"
        spAttackLabel.textAlignment = .left
        spAttackLabel.changeStyle(to: .insetLong)
        spAttackLabel.roundLabelBorderWidth = 0
        spAttackLabel.backgroundColor = DBColor.PokemonStat.spAttack
        
        spDefenseLabel.text = "SpDefense"
        spDefenseLabel.textAlignment = .left
        spDefenseLabel.changeStyle(to: .insetLong)
        spDefenseLabel.roundLabelBorderWidth = 0
        spDefenseLabel.backgroundColor = DBColor.PokemonStat.spDefense
        
        speedLabel.text = "Speed"
        speedLabel.textAlignment = .left
        speedLabel.changeStyle(to: .insetLong)
        speedLabel.roundLabelBorderWidth = 0
        speedLabel.backgroundColor = DBColor.PokemonStat.speed
    }
    
    private func configureSliders() {
        let maxValue: Float = 250
        hpSlider.maximumTrackTintColor = .clear
        hpSlider.minimumTrackTintColor = hpLabel.backgroundColor
        hpSlider.thumbTintColor = hpLabel.backgroundColor
        hpSlider.maximumValue = maxValue
        hpSlider.isUserInteractionEnabled = false
        
        attackSlider.maximumTrackTintColor = .clear
        attackSlider.minimumTrackTintColor = attackLabel.backgroundColor
        attackSlider.thumbTintColor = attackLabel.backgroundColor
        attackSlider.maximumValue = maxValue
        attackSlider.isUserInteractionEnabled = false
        
        defenseSlider.maximumTrackTintColor = .clear
        defenseSlider.minimumTrackTintColor = defenseLabel.backgroundColor
        defenseSlider.thumbTintColor = defenseLabel.backgroundColor
        defenseSlider.maximumValue = maxValue
        defenseSlider.isUserInteractionEnabled = false
        
        spAttackSlider.maximumTrackTintColor = .clear
        spAttackSlider.minimumTrackTintColor = spAttackLabel.backgroundColor
        spAttackSlider.thumbTintColor = spAttackLabel.backgroundColor
        spAttackSlider.maximumValue = maxValue
        spAttackSlider.isUserInteractionEnabled = false
        
        spDefenseSlider.maximumTrackTintColor = .clear
        spDefenseSlider.minimumTrackTintColor = spDefenseLabel.backgroundColor
        spDefenseSlider.thumbTintColor = spDefenseLabel.backgroundColor
        spDefenseSlider.maximumValue = maxValue
        spDefenseSlider.isUserInteractionEnabled = false
        
        speedSlider.maximumTrackTintColor = .clear
        speedSlider.minimumTrackTintColor = speedLabel.backgroundColor
        speedSlider.thumbTintColor = speedLabel.backgroundColor
        speedSlider.maximumValue = maxValue
        speedSlider.isUserInteractionEnabled = false
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
