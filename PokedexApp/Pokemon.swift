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
    
    
    init(name: String, id: Int, form: String) {
        _name = name
        _id = id
        _form = form
    }
    
    func parseAllInfo() {
        
        if let pokeInfo = POKEMON_JSON[name],
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
}


extension Pokemon {
    
    var hasSecondType: Bool {
        return self.secondaryType != ""
    }
    
    var hasForm: Bool {
        return self.form != ""
    }
    
    var imageName: String {
        return self.hasForm ? "\(self.id)-\(self.form)" : "\(self.id)"
    }
}
