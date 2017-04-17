//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String
    private var _id: Int
    private var _form: String
    
    private var _hp: Int!
    private var _attack: Int!
    private var _defense: Int!
    private var _spAttack: Int!
    private var _spDefense: Int!
    private var _speed: Int!
    
    private var _primaryType: String!
    private var _secondaryType: String!
    
    private var _firstAbility: String!
    private var _secondAbility: String!
    private var _hiddenAbility: String!
    
    private var _height: [String]!
    private var _weight: [String]!
    
    
    var name: String { return _name }
    var id: Int { return _id }
    var form: String { return _form }
    
    var hp: Int { return _hp }
    var attack: Int { return _attack }
    var defense: Int { return _defense }
    var spAttack: Int { return _spAttack }
    var spDefense: Int { return _spDefense }
    var speed: Int { return _speed }
    
    var primaryType: String { return _primaryType }
    var secondaryType: String { return _secondaryType }
    
    var firstAbility: String { return _firstAbility }
    var secondAbility: String { return _secondAbility }
    var hiddenAbility: String { return _hiddenAbility }
    
    func getHeight(as unit: Unit) -> String { return _height[unit.rawValue] }
    func getWeight(as unit: Unit) -> String { return _weight[unit.rawValue] }
    
    
    init(name: String, id: Int, form: String) {
        _name = name
        _id = id
        _form = form
    }
    
    
    func parseStatsTypes() {
        
        if let pokeInfo = CONSTANTS.pokemonsJSON[name],
            let hp = pokeInfo["hp"] as? Int,
            let attack = pokeInfo["attack"] as? Int,
            let defense = pokeInfo["defense"] as? Int,
            let spAttack = pokeInfo["sp-attack"] as? Int,
            let spDefense = pokeInfo["sp-defense"] as? Int,
            let speed = pokeInfo["speed"] as? Int,
            let types = pokeInfo["type"] as? [String] {
            
            _hp = hp
            _attack = attack
            _defense = defense
            _spAttack = spAttack
            _spDefense = spDefense
            _speed = speed
            
            switch types.count {
            case 1:
                _primaryType = types[0]
                _secondaryType = ""
            default:
                _primaryType = types[0]
                _secondaryType = types[1]
            }
        } else {
            _hp = 0
            _attack = 0
            _defense = 0
            _spAttack = 0
            _spDefense = 0
            _speed = 0
            
            _primaryType = ""
            _secondaryType = ""
        }
    }
    
    func parsePokemonAbilities() {
        
        if let abilities = CONSTANTS.pokemonAbilitiesJSON[name],
            let ability01 = abilities["ability01"] as? String,
            let ability02 = abilities["ability02"] as? String,
            let hiddenAbility = abilities["hidden"] as? String {
            
            _firstAbility = ability01
            _secondAbility = ability02
            _hiddenAbility = hiddenAbility
        } else {
            _firstAbility = ""
            _secondAbility = ""
            _hiddenAbility = ""
        }
    }
    
    func parseMeasurement() {
        
        if let measurements = CONSTANTS.measurementsJSON[name],
            let height = measurements["height"] as? String,
            let weight = measurements["weight"] as? String {
            
            _height = height.components(separatedBy: ", ")
            _weight = weight.components(separatedBy: ", ")
        }
    }
    
    func getWeaknesses() -> DictionarySS {
        
        var weaknessesDict = DictionarySS()
        
        if primaryType != "" {
            if let weaknesses = CONSTANTS.weaknessesJSON["\(primaryType)\(secondaryType)"] as? DictionarySS {
                for (type, effective) in weaknesses where effective != "" {
                    weaknessesDict.updateValue(effective, forKey: type)
                }
            }
        }
        
        return weaknessesDict
    }
    
    func getPokedexEntry() -> String {
        
        if let pokedexEntry = CONSTANTS.pokedexEntriesJSON["\(self.id)"] as? DictionarySS {
            if let omegaEntry = pokedexEntry["omega"], let alphaEntry = pokedexEntry["alpha"] {
                if omegaEntry != alphaEntry {
                    return "OR:\n\(omegaEntry)\n\nAS:\n\(alphaEntry)"
                } else {
                    return "ORAS:\n\(omegaEntry)"
                }
            }
        }
        
        return "\(self.name)..."
    }
}


extension Pokemon {
    
    var hasSecondType: Bool {
        return self.secondaryType != ""
    }
    
    var hasSecondAbility: Bool {
        return self.secondAbility != ""
    }
    
    var hasHiddenAbility: Bool {
        return self.hiddenAbility != ""
    }
    
    var hasForm: Bool {
        return self.form != ""
    }
    
    var imageName: String {
        return self.hasForm ? "\(self.id)-\(self.form)" : "\(self.id)"
    }
}
