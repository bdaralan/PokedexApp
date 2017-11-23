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
    let measurementLabel = RIOUILabel()
    
    var pokemon: DBPokemon!
    var pokedexEntry: String! // store pokedex entry to prevent fetching when cell is dequeued
    
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
        configureMeasurementLabel()
        configureConstraints()
    }
    
    public func configureCell(pokemon: DBPokemon) {
        self.pokemon = pokemon
        updateMeasurementLabelToHeight()
        entryLabel.text = "Pokedex Entry"
        entryLabel.roundLabel.text = pokemon.info.id.toPokedexId()
        if pokedexEntry == nil {
            pokedexEntry = PokeEntry.prettyString(pokemon)
        }
        entryTextView.text = pokedexEntry
    }
    
    private func configureEntryLabel() {
        entryLabel.changeStyle(to: .longInsetLeft)
        entryLabel.roundLabel.layer.borderWidth = 0
        entryLabel.textAlignment = .center
    }
    
    private func configureEntryTextView() {
        entryTextView.isEditable = false
        entryTextView.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func configureMeasurementLabel() {
        measurementLabel.roundLabel.textColor = .white
        measurementLabel.roundLabel.font = UIFont(name: measurementLabel.roundLabel.font.familyName, size: 32)

        // gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleMeasurementLabel))
        measurementLabel.roundLabel.addGestureRecognizer(tapGesture)
        measurementLabel.roundLabel.isUserInteractionEnabled = true
    }
    
    private func configureConstraints() {
        // create a stackView to hold entryLabel and measurementLabel
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.addArrangedSubview(entryLabel)
        stackView.addArrangedSubview(measurementLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        entryTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        contentView.addSubview(entryTextView)
        
        // stackView constraints
        let margin: CGFloat = 16
        let stackViewHeight: CGFloat = 28
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin + stackViewHeight / 2).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: stackViewHeight).isActive = true
        
        // entryTextView
        entryTextView.topAnchor.constraint(equalTo: measurementLabel.roundLabel.bottomAnchor, constant: margin / 2).isActive = true
        entryTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
        entryTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
        entryTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
    }
    
    // MARK: - Selector
    
    @objc private func toggleMeasurementLabel() {
        let roundLabelText = measurementLabel.roundLabel.text ?? "nil"
        switch roundLabelText {
        case Constant.UnicodeCharacter.angle: updateMeasurementLabelToWeight()
        case Constant.UnicodeCharacter.weight: updateMeasurementLabelToHeight()
        default: updateMeasurementLabelToHeight()
        }
    }
    
    private func updateMeasurementLabelToWeight() {
        measurementLabel.text = "\(pokemon.measurements.weight)"
        measurementLabel.roundLabel.text = Constant.UnicodeCharacter.weight
        measurementLabel.roundLabel.backgroundColor = DBColor.PokemonMeasurement.weight
    }
    
    private func updateMeasurementLabelToHeight() {
        measurementLabel.text = "\(pokemon.measurements.height)"
        measurementLabel.roundLabel.text = Constant.UnicodeCharacter.angle
        measurementLabel.roundLabel.backgroundColor = DBColor.PokemonMeasurement.height
    }
}
