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

class LoadData {
    
    func pokemonsJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemons", ofType: "json")
    }
    
    func abilitiesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "abilities", ofType: "json")
    }
    
    func pokemonAbilitiesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemon-abilities", ofType: "json")
    }
    
    func measurementsJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "measurements", ofType: "json")
    }
    
    func weaknessesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "weaknesses", ofType: "json")
    }
    
    func pokedexEntriesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokedex-enteries", ofType: "json")
    }
    
    func movesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "moves", ofType: "json")
    }
    
    func evolutionJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "evolutions", ofType: "json")
    }
    
    func itemJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "items", ofType: "json")
    }
    
    func allPokemons(by option: PokemonSortedOption) -> [Pokemon] {
        
        var pokemons = [Pokemon]()
        let json = pokemonsJSON()
        let names = json.keys
        
        for name in names {
            if let pokemonInfo = json[name] as? DictionarySA, let id = pokemonInfo["id"] as? Int, let form = pokemonInfo["form"] as? String {
                pokemons.append(Pokemon(name: name, id: id, form: form))
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
    
    func allMoves() -> [Move] {
        
        let movesJSON = self.movesJSON()
        var moves = [Move]()
        
        for name in movesJSON.keys.sorted() {
            if let moveDict = movesJSON[name] as? DictionarySS,
                let type = moveDict["type"],
                let category = moveDict["category"] {
                
                moves.append(Move(name: name, type: type, category: category))
            }
        }
        
        return moves
    }
    
    func allAbilities() -> [Ability] {
        
        let abilitiesJSON = self.abilitiesJSON()
        var abilities = [Ability]()
        
        for name in abilitiesJSON.keys.sorted() {
            if let abilityDict = abilitiesJSON[name] as? DictionarySS,
                let pokemon = abilityDict["pokemon"] {
                
                abilities.append(Ability(name: name, pokemon: pokemon))
            }
        }
        
        return abilities
    }
    
    func allItems() -> [Item] {
        
        let itemsJSON = self.itemJSON()
        var items = [Item]()
        
        for item in itemJSON().keys.sorted() {
            if let itemDict = itemsJSON[item] as? DictionarySS {
                if let category = itemDict["category"] {
                    items.append(Item(name: item, category: category))
                }
            }
        }
        
        return items
    }
    
    func allTypes() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let types = plist["PokemonTypes"] as? [String] {
            
            return types
        }
        
        return [String]()
    }
    
    func homeMenuSections() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let sections = homeMenu["Sections"] as? [String] {
            
            return sections
        }
        
        return [String]()
    }
    
    func homeMenuRowsInSections() -> [[String]] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let rowsInSection = homeMenu["RowsInSections"] as? [[String]] {
            
            return rowsInSection
        }
        
        return [[String]]()
    }
    
    func settingSections() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let settingMenu = plist["SettingMenu"] as? DictionarySA, let sections = settingMenu["Sections"] as? [String] {
            
            return sections
        }
        
        return [String]()
    }
    
    func settingRowsInSections() -> [[String]] {
     
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let settingMenu = plist["SettingMenu"] as? DictionarySA, let rowsInSections = settingMenu["RowsInSections"] as? [[String]] {
            
            return rowsInSections
        }
        
        return [[String]]()
    }
    
    func pokemonTypes() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let types = plist["PokemonTypes"] as? [String] {
            
            return types
        }
        
        return [String]()
    }
    
    func evolutionSpecialCaseForm() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let specialCaseForm = plist["EvolutionSpecialCaseForm"] as? [String] {
            
            return specialCaseForm
        }
        
        return [String]()
    }
    
    func crySoundSpecialCaseName() -> DictionarySS {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let specialCaseName = plist["CrySoundSpecialCaseName"] as? DictionarySS {
            
            return specialCaseName
        }
        
        return DictionarySS()
    }
    
    private func loadDataFromFile(name: String, ofType type: String) -> DictionarySA {
        
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
