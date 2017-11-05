//
//  LoadData.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class LoadData {
    
    enum PokemonSortedOption {
        case id
        case name
    }
    
    enum TypesSortedOption {
        case name
        case category
    }
    
    func allPokemons(by option: PokemonSortedOption) -> [Pokemon] {
        let json = pokemonsJSON
        var pokemons = [Pokemon]()
        
        for name in json.keys {
            if let pokemonInfo = json[name] as? DictionarySA,
                let id = pokemonInfo["id"] as? Int,
                let form = pokemonInfo["form"] as? String,
                let types = pokemonInfo["type"] as? [String] {
                let pokemon = Pokemon(name: name, id: id, form: form, types: types)
                pokemons.append(pokemon)
                
            } else { print("Cannot parse pokemon:", name) }
        }
        
        switch option {
        case .id: pokemons = pokemons.sorted(by: {"\($0.id.toPokedexId())\($0.form)" < "\($1.id.toPokedexId())\($1.form)"})
        case .name: pokemons = pokemons.sorted(by: {$0.name < $1.name})
        }
        return pokemons
    }
    
    func allMoves() -> [Move] {
        let json = movesJSON
        var moves = [Move]()
        
        for name in json.keys.sorted() {
            if let moveDict = json[name] as? DictionarySA,
                let type = moveDict["type"] as? String,
                let category = moveDict["category"] as? String {
                let move = Move(name: name, type: type, category: category)
                moves.append(move)
                
            } else { print("Cannot parse move:", name) }
        }
        return moves
    }
    
    func allAbilities() -> [Ability] {
        let json = abilitiesJSON
        var abilities = [Ability]()
        
        for name in json.keys.sorted() {
            if let abilityDict = json[name] as? DictionarySS,
                let pokemon = abilityDict["pokemon"] {
                let ability = Ability(name: name, pokemon: pokemon)
                abilities.append(ability)
            } else {
                print("Cannot parse ability:", name)
            }
        }
        return abilities
    }
    
    func allItems() -> [Item] {
        let json = itemJSON
        var items = [Item]()
        
        for name in json.keys.sorted() {
            if let itemDict = json[name] as? DictionarySS {
                if let category = itemDict["category"] {
                    let item = Item(name: name, category: category)
                    items.append(item)
                }
            } else {
                print("Cannot parse item:", name)
            }
        }
        return items
    }
    
    func allTypes() -> [String] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let types = plist["PokemonTypes"] as? [String] {
            return types.sorted()
        }
        
        // safegaurd return
        return ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]
    }
    
    var homeMenuSections: [String] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let sections = homeMenu["Sections"] as? [String] {
            return sections
        }
        return [String]()
    }
    
    var homeMenuRowsInSections: [[String]] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let rowsInSection = homeMenu["RowsInSections"] as? [[String]] {
            return rowsInSection
        }
        return [[String]]()
    }
    
    var settingSections: [String] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let settingMenu = plist["SettingMenu"] as? DictionarySA, let sections = settingMenu["Sections"] as? [String] {
            return sections
        }
        return [String]()
    }
    
    var settingRowsInSections: [[String]] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let settingMenu = plist["SettingMenu"] as? DictionarySA, let rowsInSections = settingMenu["RowsInSections"] as? [[String]] {
            return rowsInSections
        }
        return [[String]]()
    }
    
    var pokemonTypes: [String] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let types = plist["PokemonTypes"] as? [String] {
            return types
        }
        return [String]()
    }
    
    var evolutionSpecialCaseForm: [String] {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let specialCaseForm = plist["EvolutionSpecialCaseForm"] as? [String] {
            return specialCaseForm
        }
        return [String]()
    }
    
    var crySoundSpecialCaseName: DictionarySS {
        let plist = load(fromFile: "constants", ofType: "plist")
        if let specialCaseName = plist["CrySoundSpecialCaseName"] as? DictionarySS {
            return specialCaseName
        }
        return DictionarySS()
    }
}

// MARK: Extension LoadData

extension LoadData {
    
    var pokemonsJSON: DictionarySA {
        return load(fromFile: "pokemons", ofType: "json")
    }
    
    var abilitiesJSON: DictionarySA {
        return load(fromFile: "abilities", ofType: "json")
    }
    
    var pokemonAbilitiesJSON: DictionarySA {
        return load(fromFile: "pokemon-abilities", ofType: "json")
    }
    
    var measurementsJSON: DictionarySA {
        return load(fromFile: "measurements", ofType: "json")
    }
    
    var defensesJSON: DictionarySA {
        return load(fromFile: "defenses", ofType: "json")
    }
    
    var pokedexEntriesJSON: DictionarySA {
        return load(fromFile: "pokedex-enteries", ofType: "json")
    }
    
    var movesJSON: DictionarySA {
        return load(fromFile: "moves", ofType: "json")
    }
    
    var pokemonLearnMovesJSON: DictionarySA {
        return load(fromFile: "pokemon-learn-moves", ofType: "json")
    }
    
    var evolutionJSON: DictionarySA {
        return load(fromFile: "evolutions", ofType: "json")
    }
    
    var itemJSON: DictionarySA {
        return load(fromFile: "items", ofType: "json")
    }
}

extension LoadData {
    
    func load(fromFile name: String, ofType type: String) -> DictionarySA {
        if let path = Bundle.main.path(forResource: name, ofType: type), let data = NSData(contentsOfFile: path) as Data? {
            do {
                if type == "json" {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                        return json
                    }
                } else {
                    if let plist = NSDictionary(contentsOfFile: path) as? DictionarySA {
                        return plist
                    }
                }
            } catch { print(error) }
        }
        return DictionarySA()
    }
}
