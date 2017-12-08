//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class Pokemon {
    
    private var _name: String!
    private var _id: Int!
    private var _form: String!
    
    private var _primaryType: String!
    private var _secondaryType: String!
    
    private var _hp: Int!
    private var _attack: Int!
    private var _defense: Int!
    private var _spAttack: Int!
    private var _spDefense: Int!
    private var _speed: Int!
    
    private var _firstAbility: String!
    private var _secondAbility: String!
    private var _hiddenAbility: String!
    
    private var _height: [String]!
    private var _weight: [String]!
    
    private var _evolveFrom: String!
    private var _evolveTo: String!
    
    
    var name: String { return _name }
    
    var id: Int { return _id }
    
    var form: String { return _form }
    
    var primaryType: String { return _primaryType }
    
    var secondaryType: String { return _secondaryType }
    
    var hp: Int {
        
        if _hp == nil { self.parseStats() }
        return _hp
    }
    
    var attack: Int {
        
        if _attack == nil { self.parseStats() }
        return _attack
    }
    
    var defense: Int {
        
        if _defense == nil { self.parseStats() }
        return _defense
    }
    
    var spAttack: Int {
        
        if _spAttack == nil { self.parseStats() }
        return _spAttack
    }
    
    var spDefense: Int {
        
        if _spDefense == nil { self.parseStats() }
        return _spDefense
    }
    
    var speed: Int {
        
        if _speed == nil { self.parseStats() }
        return _speed
    }
    
    var firstAbility: String {
        
        if _firstAbility == nil { self.parseAbilities() }
        return _firstAbility
    }
    
    var secondAbility: String {
        
        if _secondAbility == nil { self.parseAbilities() }
        return _secondAbility
    }
    
    var hiddenAbility: String {
        
        if _hiddenAbility == nil { self.parseAbilities() }
        return _hiddenAbility
    }
    
    var evolveFrom: String {
        
        if _evolveFrom == nil { self.parseEvolution() }
        return _evolveFrom
    }
    
    var evolveTo: String {
        
        if _evolveTo == nil { self.parseEvolution() }
        return _evolveTo
    }
    
    func getHeight(as unit: Unit) -> String {
        
        if _height == nil { self.parseMeasurement() }
        return _height[unit.rawValue]
    }
    
    func getWeight(as unit: Unit) -> String {
        
        if _weight == nil { self.parseMeasurement() }
        return _weight[unit.rawValue]
    }
    
    init(name: String, id: Int, form: String, types: [String]) {
        
        _name = name
        _id = id
        _form = form
        
        switch types.count {
        case 1:
            _primaryType = types[0]
            _secondaryType = ""
        default:
            _primaryType = types[0]
            _secondaryType = types[1]
        }
    }
    
    private func parseStats() {
        
        if let pokeInfo = Constant.pokemonsJSON[name],
            let hp = pokeInfo["hp"] as? Int,
            let attack = pokeInfo["attack"] as? Int,
            let defense = pokeInfo["defense"] as? Int,
            let spAttack = pokeInfo["sp-attack"] as? Int,
            let spDefense = pokeInfo["sp-defense"] as? Int,
            let speed = pokeInfo["speed"] as? Int {
            
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
    
    private func parseAbilities() {
        
        if let abilities = Constant.pokemonAbilitiesJSON[name],
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
    
    private func parseMeasurement() {
        
        if let measurements = Constant.measurementsJSON[name],
            let height = measurements["height"] as? String,
            let weight = measurements["weight"] as? String {
            
            _height = height.components(separatedBy: ", ")
            _weight = weight.components(separatedBy: ", ")
            
        } else {
            _height = ["0", "0"]
            _weight = ["0", "0"]
        }
    }
    
    private func parseEvolution() {
        
        var name = self.name
        
        if self.hasForm {
            if self.form.contains("mega") || self.form.contains("primal"), let selfNoForm = Variable.allPokemonsSortedByName.filter({$0.id == self.id}).first {
                name = selfNoForm.name
            }
        }
        
        if let evolutions = Constant.evolutionsJSON[name] as? [DictionarySS] {
            if let evolution = evolutions.first,
                let evolveFrom = evolution["evolve-from"],
                let evolveTo = evolution["evolve-to"] {
                
                _evolveFrom = evolveFrom
                _evolveTo = evolveTo
            }
            
        } else {
            _evolveFrom = ""
            _evolveTo = ""
        }
        
        // TODO: - case where pokemon is a mega evolution, other forms, or not in json
    }
}

// MARK: - Computed Property

extension Pokemon {
    
    var hasSecondType: Bool { return self.secondaryType != "" }
    
    var hasSecondAbility: Bool { return self.secondAbility != "" }
    
    var hasHiddenAbility: Bool { return self.hiddenAbility != "" }
    
    var hasForm: Bool { return self.form != "" }
    
    var hasNoEvolution: Bool { return self.evolveFrom == "" && self.evolveTo == "" }
    
    var isBaseEvolution: Bool { return self.evolveFrom == "" && self.evolveTo != "" }
    
    var isMidEvolution: Bool { return self.evolveFrom != "" && self.evolveTo != "" }
    
    var isLastEvolution: Bool { return self.evolveFrom != "" && self.evolveTo == "" }
    
    var imageName: String { return self.hasForm ? "\(self.id)-\(self.form)" : "\(self.id)" }
    
    var crySound: String {
        
        let id = String(format: "%03d-", self.id)
        var crySound = self.name
        
        if Constant.crySoundSepcialCaseName.keys.contains(crySound),
            let name = Constant.crySoundSepcialCaseName[crySound] {
            
            crySound = name
        }
        
        return "\(id)\(crySound)"
    }
    
    var defenses: DictionarySS {
        
        var defensesDict = DictionarySS()
        
        if primaryType != "" {
            if let defenses = Constant.defensesJSON["\(primaryType)\(secondaryType)"] as? DictionarySS {
                for (type, effective) in defenses where effective != "" {
                    defensesDict.updateValue(effective, forKey: type)
                }
            }
        }
        
        return defensesDict
    }
    
    var pokedexEntry: String {
        
        if let pokedexEntry = Constant.pokedexEntriesJSON["\(self.id)"] as? DictionarySS {
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

// MARK: - Get Evolution

extension Pokemon {
    
    ///: Will return [self] if no evolution
    var evolutions: [Pokemon] {
        
        var evolutions = [Pokemon]()
        var selfNoForm = self
        
        if self.hasForm, Constant.evolutionSpecialCaseForm.contains(self.form) {
            selfNoForm = Variable.allPokemonsSortedById.search(forId: self.id, withName: self.name)
        }
        
        evolutions = [selfNoForm]
        
        if selfNoForm.isBaseEvolution { // MARK: - isBaseEvolution
            let evolveToPokemon = Variable.allPokemonsSortedByName.search(forName: selfNoForm.evolveTo)
            
            if evolveToPokemon.isLastEvolution {
                evolutions = [selfNoForm, evolveToPokemon]
            } else { //isMidEvolution
                let lastEvolution = Variable.allPokemonsSortedByName.search(forName: evolveToPokemon.evolveTo)
                evolutions = [selfNoForm, evolveToPokemon, lastEvolution]
            }
            
        } else if selfNoForm.isMidEvolution { // MARK: - isMidEvolution
            let baseEvolution = Variable.allPokemonsSortedByName.search(forName: selfNoForm.evolveFrom)
            let lastEvolution = Variable.allPokemonsSortedByName.search(forName: selfNoForm.evolveTo)
            evolutions = [baseEvolution, selfNoForm, lastEvolution]
            
        } else if selfNoForm.isLastEvolution { // MARK: - isLastEvolution
            let evolveFromPokemon = Variable.allPokemonsSortedByName.search(forName: selfNoForm.evolveFrom)
            
            if evolveFromPokemon.isBaseEvolution {
                evolutions = [evolveFromPokemon, selfNoForm]
            } else { //isMidEvollution
                let baseEvolution = Variable.allPokemonsSortedByName.search(forName: evolveFromPokemon.evolveFrom)
                evolutions = [baseEvolution, evolveFromPokemon, selfNoForm]
            }
        }
        
        return evolutions //return an array with one element which is itself
    }
}

// MARK: - Error pokemon

extension Pokemon {
    
    convenience init(errorPokemonName name: String) {
        
        self.init(name: name, id: 0, form: "Error", types: ["Error", "Error"])
    }
}

// MARK: - Shorthand Sort and Filter

extension Array where Element: Pokemon {
    
    func sortById() -> [Pokemon] {
        
        return self.sorted(by: {"\($0.id.toPokedexId())\($0.form)" < "\($1.id.toPokedexId())\($1.form)"})
    }
    
    func sortByAlphabet() -> [Pokemon] {
        
        return self.sorted(by: {$0.name < $1.name})
    }
    
    func filter(forName name: String, options: String.CompareOptions) -> [Pokemon] {
        
        return self.filter({$0.name.range(of: name, options: options) != nil})
    }
    
    func filter(forType type: String) -> [Pokemon] {
        
        return self.filter({$0.primaryType == type || $0.secondaryType == type})
    }
    
    func filter(forAbility ability: String, hiddenOnly: Bool = false) -> [Pokemon] {
        
        if hiddenOnly {
            return self.filter({$0.hiddenAbility == ability})
            
        } else {
            return self.filter({
                $0.firstAbility == ability
                    || $0.secondAbility == ability
                    || $0.hiddenAbility == ability
            })
        }
    }
    
    func filter(for searchText: String, options: String.CompareOptions) -> [Pokemon] {
        
        var searchText = searchText
        if searchText.contains(" ") { searchText = searchText.capitalized }
        
        return self.filter({
            $0.name.range(of: searchText, options: options) != nil
                || $0.id.toPokedexId().range(of: searchText) != nil
                || $0.primaryType == searchText
                || $0.secondaryType == searchText
                || String($0.primaryType+$0.secondaryType) == searchText
                || String($0.secondaryType+$0.primaryType) == searchText
                || $0.firstAbility == searchText
                || $0.secondAbility == searchText
                || $0.hiddenAbility == searchText
        })
    }
}

// MARK: - Binary Search

extension Array where Element: Pokemon {
    
    func search(forName searchName: String) -> Pokemon {
        
        var begin = 0
        var end = self.count - 1
        
        while begin <= end {
            let mid = (begin + end) / 2
            
            if self[mid].name == searchName {
                return self[mid]
            } else {
                if self[mid].name < searchName {
                    begin = mid + 1
                } else {
                    end = mid - 1
                }
            }
        }
        
        return Pokemon(name: "Error", id: 0, form: "Error", types: ["Error", "Error"])
    }
    
    ///: Use with search for evolution
    func search(forId searchId: Int, withName targetName: String) -> Pokemon {
        
        var begin = 0
        var end = self.count - 1
        
        while begin <= end {
            let mid = (begin + end) / 2
            
            if self[mid].id == searchId, self[mid].name != targetName {
                return self[mid]
                
            } else {
                if self[mid].id < searchId {
                    begin = mid + 1
                } else {
                    end = mid - 1
                }
            }
        }
        
        return Pokemon(name: "Error", id: 0, form: "Error", types: ["Error", "Error"])
    }
    
    ///: Use with search for learn move
    func filter(forId searchId: String) -> [Pokemon] {
        
        let exceptionForm = ["mega", "primal"]
        
        let pokemons: [Pokemon] = self.filter({$0.id.toPokedexId() == searchId && !exceptionForm.contains($0.form)})
        
        return pokemons.isEmpty ? [Pokemon]() : pokemons
    }
}
