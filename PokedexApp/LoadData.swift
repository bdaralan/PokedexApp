//
//  LoadData.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

enum PokemonSortedOption {
    case id
    case name
}

enum TypesSortedOption {
    case name
    case category
}

public struct LoadData {
    
    static func pokemonsJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemons", ofType: "json")
    }
    
    static func abilitiesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "abilities", ofType: "json")
    }
    
    static func pokemonAbilitiesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemon-abilities", ofType: "json")
    }
    
    static func measurementsJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "measurements", ofType: "json")
    }
    
    static func weaknessesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "weaknesses", ofType: "json")
    }
    
    static func pokedexEntriesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokedex-enteries", ofType: "json")
    }
    
    static func movesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "moves", ofType: "json")
    }
    
    static func pokemonLearnMovesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemon-learn-moves", ofType: "json")
    }
    
    static func evolutionJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "evolutions", ofType: "json")
    }
    
    static func itemJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "items", ofType: "json")
    }
    
    static func allPokemons(by option: PokemonSortedOption) -> [Pokemon] {
        
        let json = pokemonsJSON()
        var pokemons = [Pokemon]()
        
        for name in json.keys {
            if let pokemonInfo = json[name] as? DictionarySA,
                let id = pokemonInfo["id"] as? Int,
                let form = pokemonInfo["form"] as? String,
                let types = pokemonInfo["type"] as? [String] {
                let pokemon = Pokemon(name: name, id: id, form: form, types: types)
                pokemons.append(pokemon)
            }
        }
        
        switch option {
        case .id:
            pokemons = pokemons.sorted(by: {"\($0.id.toPokedexId())\($0.form)" < "\($1.id.toPokedexId())\($1.form)"})
        case .name:
            pokemons = pokemons.sorted(by: {$0.name < $1.name})
        }
        
        return pokemons
    }
    
    static func allMoves() -> [Move] {
        
        let json = movesJSON()
        var moves = [Move]()
        
        for name in json.keys {
            if let moveDict = json[name] as? DictionarySA,
                let type = moveDict["type"] as? String,
                let category = moveDict["category"] as? String {
                let move = Move(name: name, type: type, category: category)
                moves.append(move)
            }
        }
        
        if moves.count > 1 { moves = moves.sorted(by: {$0.name < $1.name}) }
        
        return moves
    }
    
    static func allAbilities() -> [Ability] {
        
        let json = abilitiesJSON()
        var abilities = [Ability]()
        
        for name in json.keys {
            if let abilityDict = json[name] as? DictionarySS,
                let pokemon = abilityDict["pokemon"] {
                let ability = Ability(name: name, pokemon: pokemon)
                abilities.append(ability)
            }
        }
        
        if abilities.count > 1 { abilities = abilities.sorted(by: {$0.name < $1.name}) }
        
        return abilities
    }
    
    static func allItems() -> [Item] {
        
        let json = itemJSON()
        var items = [Item]()
        
        for item in json.keys {
            if let itemDict = json[item] as? DictionarySS {
                if let category = itemDict["category"] {
                    let item = Item(name: item, category: category)
                    items.append(item)
                }
            }
        }
        
        if items.count > 1 { items = items.sorted(by: {$0.name < $1.name}) }
        
        return items
    }
    
    static func allTypes() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let types = plist["PokemonTypes"] as? [String] {
            
            return types.sorted()
        }
        
        // Safegaurd return
        return ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]
    }
    
    static func homeMenuSections() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let sections = homeMenu["Sections"] as? [String] {
            
            return sections
        }
        
        return [String]()
    }
    
    static func homeMenuRowsInSections() -> [[String]] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let rowsInSection = homeMenu["RowsInSections"] as? [[String]] {
            
            return rowsInSection
        }
        
        return [[String]]()
    }
    
    static func settingSections() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let settingMenu = plist["SettingMenu"] as? DictionarySA, let sections = settingMenu["Sections"] as? [String] {
            
            return sections
        }
        
        return [String]()
    }
    
    static func settingRowsInSections() -> [[String]] {
     
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let settingMenu = plist["SettingMenu"] as? DictionarySA, let rowsInSections = settingMenu["RowsInSections"] as? [[String]] {
            
            return rowsInSections
        }
        
        return [[String]]()
    }
    
    static func pokemonTypes() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let types = plist["PokemonTypes"] as? [String] {
            
            return types
        }
        
        return [String]()
    }
    
    static func evolutionSpecialCaseForm() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let specialCaseForm = plist["EvolutionSpecialCaseForm"] as? [String] {
            
            return specialCaseForm
        }
        
        return [String]()
    }
    
    static func crySoundSpecialCaseName() -> DictionarySS {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let specialCaseName = plist["CrySoundSpecialCaseName"] as? DictionarySS {
            
            return specialCaseName
        }
        
        return DictionarySS()
    }
    
    private static func loadDataFromFile(name: String, ofType type: String) -> DictionarySA {
        
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
