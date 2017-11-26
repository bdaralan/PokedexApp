//
//  PokeData.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

// MARK: - File name

private var pokemonJsonFileName: String { return "pokemon" }

private var pokemonMegaEvolutionJsonFileName: String { return "pokemon-mega-evolution" }

private var pokemonEvolutionTreeJsonFileName: String { return "pokemon-evolution-tree" }

private var pokedexEntryJsonFileName: String { return "pokedex-enteries" }

// MARK: - PokeData

public struct PokeData {
    
    /// PokeData singleton
    private static var pokeDataInstance: PokeData!
    
    /// Dictionary from `json` file `pokemonJsonFileName`.
    public let pokemonJson: Dictionary<String, AnyObject>
    
    /// Dictionary from `json` file `pokemonMegaEvolutionJsonFileName`.
    public let pokemonMegaEvolutionJson: Dictionary<String, AnyObject>
    
    /// Dictionary from `json` file `pokemonEvolutionTreeJsonFileName`.
    public let pokemonEvolutionTreeJson: Dictionary<String, AnyObject>
    
    /// Dictionary from `json` file `pokedexEntryJsonFileName`.
    public let pokedexEntryJson: Dictionary<String, AnyObject>
    
    /// Pokemon dictionary.
    /// - note: Each dictionary's key is `Pokemon.key`.
    public let pokemonMap: Dictionary<String, DBPokemon>
    
    /// All Pokemon including other forms
    public let pokemons: [DBPokemon]
    
    // MARK: - Getter
    
    /// PokeData instance (singleton).
    public static var instance: PokeData {
        if pokeDataInstance == nil { initializes() }
        return pokeDataInstance
    }
}

// MARK: - Initialization

extension PokeData {
    
    /// Initializes and prepares `PokeData` instance.
    /// - note: This method will only initialize once, when `PokeData` instance is `nil`.
    /// - parameter force: pass in `true` to force a reinitialization.
    public static func initializes(force: Bool = false) {
        guard pokeDataInstance == nil || force else { return }
        
        // read all necessary json
        let pokemonJson = readPokemonJson()
        let pokemonMegaEvolutionJson = readPokemonMegaEvolutionJson()
        let pokemonEvolutionTreeJson = readPokemonEvolutionTreeJson()
        let pokedexEntryJson = readPokedexEntryJson()
        
        // create pokemon map
        let pokemons = decodePokemons(from: pokemonJson) + decodePokemons(from: pokemonMegaEvolutionJson)
        let pokemonMap = createAllPokemonMap(pokemons: pokemons)
        
        // initialize pokeDataInstance singleton
        pokeDataInstance = PokeData(pokemonJson: pokemonJson,
                                    pokemonMegaEvolutionJson: pokemonMegaEvolutionJson,
                                    pokemonEvolutionTreeJson: pokemonEvolutionTreeJson,
                                    pokedexEntryJson: pokedexEntryJson,
                                    pokemonMap: pokemonMap,
                                    pokemons: pokemons
        )
    }
    
    /// Read `pokemonJsonFileName.json` to `_allPokemonsJson`.
    private static func readPokemonJson() -> DictionarySA {
        return readJson(fileName: pokemonJsonFileName)
    }
    
    /// Read `pokemonMegaEvolutionJsonFileName.json` to `_allPokemonMegaEvolutionJson`
    private static func readPokemonMegaEvolutionJson() -> DictionarySA {
        return readJson(fileName: pokemonMegaEvolutionJsonFileName)
    }
    
    /// Read `pokemonEvolutionTreeJsonFileName.json` to `_pokemonEvolutionTreeJson`.
    private static func readPokemonEvolutionTreeJson() -> DictionarySA {
        return readJson(fileName: pokemonEvolutionTreeJsonFileName)
    }
    
    /// Read `pokedexEntryJsonFileName.json` to `_pokedexEntryJson`
    private static func readPokedexEntryJson() -> DictionarySA {
        return readJson(fileName: pokedexEntryJsonFileName)
    }
    
    private static func createAllPokemonMap(pokemons: [DBPokemon]) -> Dictionary<String, DBPokemon> {
        var allPokemonsMap = Dictionary<String, DBPokemon>()
        for pokemon in pokemons {
            allPokemonsMap.updateValue(pokemon, forKey: pokemon.key)
        }
        return allPokemonsMap
    }
    
    /// Decode every Pokemon from `_allPokemonsJson` as `Pokemon`.
    /// Append every `Pokemon` to `_allPokemons`.
    /// - parameter dictionary: `Dictionary` contains Pokemon data that can be decode.
    private static func decodePokemons(from dictionary: DictionarySA) -> [DBPokemon] {
        do {
            var allPokemons = [DBPokemon]()
            let decoder = JSONDecoder()
            for (_, pokemonDict) in dictionary {
                let pokemonData = try JSONSerialization.data(withJSONObject: pokemonDict, options: [])
                let pokemon = try decoder.decode(DBPokemon.self, from: pokemonData)
                allPokemons.append(pokemon)
            }
            return allPokemons
        } catch {
            print("decodeAllPokemons() fail!!")
            print(error.localizedDescription)
            return []
        }
    }
    
    /// Read json file from main bundle.
    /// - parameter fileName: json file name located in main bundle.
    /// - returns: an empty `DictionarySA` if file not found.
    private static func readJson(fileName: String) -> DictionarySA {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("File: \(fileName).json is missing or cannot be read!!")
            return [:]
        }
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                return json
            }
        } catch {
            print("readJson() fail to fetch \(fileName).json!!")
            print(error.localizedDescription)
        }
        return [:]
    }
}
