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
private let labelHeight: CGFloat = 28

/// Use with `PokemonTVC` to display Pokemon's stats.
class PokeStatCell: UITableViewCell {
    
    let totalLabel = RIOUILabel()
    let minMaxLabel = RIOUILabel()
    
    let statStackView = UIStackView()
    let hpLabel = RIOUILabel()
    let attackLabel = RIOUILabel()
    let defenseLabel = RIOUILabel()
    let spAttackLabel = RIOUILabel()
    let spDefenseLabel = RIOUILabel()
    let speedLabel = RIOUILabel()
    
    let minMaxStackView = UIStackView()
    let hpMinMaxLabel = RIOUILabel()
    let attackMinMaxLabel = RIOUILabel()
    let defenseMinMaxLabel = RIOUILabel()
    let spAttackMinMaxLabel = RIOUILabel()
    let spDefenseMinMaxLabel = RIOUILabel()
    let speedMinMaxLabel = RIOUILabel()
    
    let sliderStackView = UIStackView()
    let hpSlider = UISlider()
    let attackSlider = UISlider()
    let defenseSlider = UISlider()
    let spAttackSlider = UISlider()
    let spDefenseSlider = UISlider()
    let speedSlider = UISlider()
    
    var pokemon: DBPokemon!
    
    public static var defaultCellHeight: CGFloat { return (space * 2) + (labelHeight * 7) + (space * 6) }

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
        configureStatLabels()
        configureSliders()
        configureMinMaxLabels()
        configureStackViews()
        configureConstraints()
    }
    
    public func configureCell(pokemon: DBPokemon) {
        self.pokemon = pokemon
        updateStatLabels()
    }
    
    /// Update stat sliders with animation and duration, default is `0.3`.
    public func updateStatSlides(animated: Bool, duration: TimeInterval = 0.3) {
        guard let pokemon = pokemon else { return }
        let maxValue: Float = 200
        hpSlider.maximumValue = maxValue
        attackSlider.maximumValue = maxValue
        defenseSlider.maximumValue = maxValue
        spAttackSlider.maximumValue = maxValue
        spDefenseSlider.maximumValue = maxValue
        speedSlider.maximumValue = maxValue
        
        let duration = animated ? duration : 0
        UIView.animate(withDuration: duration) {
            self.hpSlider.setValue(Float(pokemon.stats.hp), animated: animated)
            self.attackSlider.setValue(Float(pokemon.stats.attack), animated: animated)
            self.defenseSlider.setValue(Float(pokemon.stats.defense), animated: animated)
            self.spAttackSlider.setValue(Float(pokemon.stats.spAttack), animated: animated)
            self.spDefenseSlider.setValue(Float(pokemon.stats.spDefense), animated: animated)
            self.speedSlider.setValue(Float(pokemon.stats.speed), animated: animated)
        }
    }
    
    private func updateStatLabels() {
        guard let pokemon = pokemon else { return }
        hpLabel.roundLabel.text = "\(pokemon.stats.hp)"
        attackLabel.roundLabel.text = "\(pokemon.stats.attack)"
        defenseLabel.roundLabel.text = "\(pokemon.stats.defense)"
        spAttackLabel.roundLabel.text = "\(pokemon.stats.spAttack)"
        spDefenseLabel.roundLabel.text = "\(pokemon.stats.spDefense)"
        speedLabel.roundLabel.text = "\(pokemon.stats.speed)"
        
        let stats = pokemon.stats
        let total = stats.hp + stats.attack + stats.defense + stats.spAttack + stats.spDefense + stats.speed
        totalLabel.roundLabel.text = "\(total)"
    }
    
    private func configureStatLabels() {
        hpLabel.text = "HP"
        setupStatLabel(label: hpLabel, backgroundColor: DBColor.PokemonStat.hp)
        
        attackLabel.text = "Attack"
        setupStatLabel(label: attackLabel, backgroundColor: DBColor.PokemonStat.attack)
        
        defenseLabel.text = "Defense"
        setupStatLabel(label: defenseLabel, backgroundColor: DBColor.PokemonStat.defense)
        
        spAttackLabel.text = "SpAtt"
        setupStatLabel(label: spAttackLabel, backgroundColor: DBColor.PokemonStat.spAttack)
        
        spDefenseLabel.text = "SpDef"
        setupStatLabel(label: spDefenseLabel, backgroundColor: DBColor.PokemonStat.spDefense)
        
        speedLabel.text = "Speed"
        setupStatLabel(label: speedLabel, backgroundColor: DBColor.PokemonStat.speed)
    }
    
    private func configureMinMaxLabels() {
        // totalLabel
        totalLabel.text = "Total"
        totalLabel.textAlignment = .left
        totalLabel.changeStyle(to: .longInsetRight)
        totalLabel.roundLabel.layer.borderWidth = 0
        totalLabel.backgroundColor = .black
        
        // minMaxLabel
        minMaxLabel.text = "Min"
        minMaxLabel.roundLabel.text = "Max"
        setupMinMaxLabel(label: minMaxLabel, backgroundColor: .black)
        
        // stats min max label
        setupMinMaxLabel(label: hpMinMaxLabel, backgroundColor: DBColor.PokemonStat.hp)
        setupMinMaxLabel(label: attackMinMaxLabel, backgroundColor: DBColor.PokemonStat.attack)
        setupMinMaxLabel(label: defenseMinMaxLabel, backgroundColor: DBColor.PokemonStat.defense)
        setupMinMaxLabel(label: spAttackMinMaxLabel, backgroundColor: DBColor.PokemonStat.spAttack)
        setupMinMaxLabel(label: spDefenseMinMaxLabel, backgroundColor: DBColor.PokemonStat.spDefense)
        setupMinMaxLabel(label: speedMinMaxLabel, backgroundColor: DBColor.PokemonStat.speed)
    }
    
    private func configureSliders() {
        setupSlider(hpSlider, minTint: hpLabel.backgroundColor, maxTint: hpLabel.backgroundColor)
        setupSlider(attackSlider, minTint: attackLabel.backgroundColor, maxTint: attackLabel.backgroundColor)
        setupSlider(defenseSlider, minTint: defenseLabel.backgroundColor, maxTint: defenseLabel.backgroundColor)
        setupSlider(spAttackSlider, minTint: spAttackLabel.backgroundColor, maxTint: spAttackLabel.backgroundColor)
        setupSlider(spDefenseSlider, minTint: spDefenseLabel.backgroundColor, maxTint: spDefenseLabel.backgroundColor)
        setupSlider(speedSlider, minTint: speedLabel.backgroundColor, maxTint: speedLabel.backgroundColor)
    }
    
    private func configureStackViews() {
        statStackView.axis = .vertical
        statStackView.distribution = .fillEqually
        statStackView.spacing = space
        statStackView.addArrangedSubview(hpLabel)
        statStackView.addArrangedSubview(attackLabel)
        statStackView.addArrangedSubview(defenseLabel)
        statStackView.addArrangedSubview(spAttackLabel)
        statStackView.addArrangedSubview(spDefenseLabel)
        statStackView.addArrangedSubview(speedLabel)
    
        sliderStackView.axis = .vertical
        sliderStackView.distribution = .fillEqually
        sliderStackView.spacing = space
        sliderStackView.addArrangedSubview(hpSlider)
        sliderStackView.addArrangedSubview(attackSlider)
        sliderStackView.addArrangedSubview(defenseSlider)
        sliderStackView.addArrangedSubview(spAttackSlider)
        sliderStackView.addArrangedSubview(spDefenseSlider)
        sliderStackView.addArrangedSubview(speedSlider)
    
        minMaxStackView.axis = .vertical
        minMaxStackView.distribution = .fillEqually
        minMaxStackView.spacing = space
        minMaxStackView.addArrangedSubview(hpMinMaxLabel)
        minMaxStackView.addArrangedSubview(attackMinMaxLabel)
        minMaxStackView.addArrangedSubview(defenseMinMaxLabel)
        minMaxStackView.addArrangedSubview(spAttackMinMaxLabel)
        minMaxStackView.addArrangedSubview(spDefenseMinMaxLabel)
        minMaxStackView.addArrangedSubview(speedMinMaxLabel)
    }
    
    private func configureConstraints() {
        statStackView.translatesAutoresizingMaskIntoConstraints = false
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        minMaxStackView.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statStackView)
        contentView.addSubview(sliderStackView)
        contentView.addSubview(minMaxStackView)
        contentView.addSubview(totalLabel)
        contentView.addSubview(minMaxLabel)
        
        // use as reference
        statStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: space).isActive = true
        statStackView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -space).isActive = true
        statStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
        statStackView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        sliderStackView.topAnchor.constraint(equalTo: statStackView.topAnchor).isActive = true
        sliderStackView.bottomAnchor.constraint(equalTo: statStackView.bottomAnchor).isActive = true
        sliderStackView.leadingAnchor.constraint(equalTo: statStackView.trailingAnchor, constant: space).isActive = true
        sliderStackView.trailingAnchor.constraint(equalTo: minMaxStackView.leadingAnchor, constant: -space).isActive = true
        
        minMaxStackView.topAnchor.constraint(equalTo: statStackView.topAnchor).isActive = true
        minMaxStackView.bottomAnchor.constraint(equalTo: statStackView.bottomAnchor).isActive = true
        minMaxStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
        minMaxStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        totalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -space).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: statStackView.leadingAnchor).isActive = true
        totalLabel.trailingAnchor.constraint(equalTo: statStackView.trailingAnchor).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        minMaxLabel.topAnchor.constraint(equalTo: minMaxStackView.bottomAnchor, constant: space).isActive = true
        minMaxLabel.leadingAnchor.constraint(equalTo: minMaxStackView.leadingAnchor).isActive = true
        minMaxLabel.trailingAnchor.constraint(equalTo: minMaxStackView.trailingAnchor).isActive = true
        minMaxLabel.heightAnchor.constraint(equalTo: totalLabel.heightAnchor).isActive = true
    }
    
    // MARKL: - Helper function
    
    /// - note: Excludes `totalLabel`
    private func setupMinMaxLabel(label: RIOUILabel, backgroundColor: UIColor) {
        label.textAlignment = .center
        label.changeStyle(to: .halfWidthInsetRight)
        label.roundLabel.layer.borderWidth = 0
        label.backgroundColor = backgroundColor
    }
    
    private func setupSlider(_ slider: UISlider, minTint: UIColor?, maxTint: UIColor?) {
        slider.minimumTrackTintColor = minTint
        slider.maximumTrackTintColor = maxTint?.withAlphaComponent(0.3)
        slider.thumbTintColor = minTint
        slider.isUserInteractionEnabled = false
    }
    
    private func setupStatLabel(label: RIOUILabel, backgroundColor: UIColor) {
        label.textAlignment = .left
        label.changeStyle(to: .longInsetRight)
        label.roundLabelBorderWidth = 0
        label.backgroundColor = backgroundColor
    }
}
