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
        
        parseStats()
        parseTypes()
        parseForm()
    }
    
    
    private func parseStats() {
        
        if let stats = POKEMON_JSON[name], let hp = stats["hp"] as? Int, let attack = stats["attack"] as? Int, let defense = stats["defense"] as? Int, let spAttack = stats["sp-attack"] as? Int, let spDefense = stats["sp-defense"] as? Int, let speed = stats["speed"] as? Int {
            
            _hp = hp
            _attack = attack
            _defense = defense
            _spAttack = spAttack
            _spDefense = spDefense
            _speed = speed
        } else {
            _hp = 0
            _attack = 0
            _defense = 0
            _spAttack = 0
            _spDefense = 0
            _speed = 0
        }
    }
    
    private func parseTypes() {
        
        if let types = POKEMON_JSON[name]?["type"] as? [String] {
            
            switch types.count {
            case 1:
                _primaryType = types[0]
                _secondaryType = ""
            default:
                _primaryType = types[0]
                _secondaryType = types[1]
            }
        } else {
            _primaryType = "Unknown"
            _secondaryType = "Unknown"
        }
    }
    
    private func parseForm() {
        
        if let form = POKEMON_JSON[name]?["form"] as? String {
            _form = form
        }
    }
}
