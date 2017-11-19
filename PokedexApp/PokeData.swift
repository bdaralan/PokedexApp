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


// MARK: - Singleton

private var _pokemonJson: DictionarySA!

private var _megaEvolutionPokemonJson: DictionarySA!

private var _allPokemons: [DBPokemon]!

private var _allMegaEvolutionPokemons: [DBPokemon]!

private var _pokemonMap: Dictionary<String, DBPokemon>!


// MARK: - PokeData

public struct PokeData {
    
    // MARK: - Getter
    
    /// Dictionary from `json` file `pokemonJsonFileName`.
    public static var pokemonJson: Dictionary<String, AnyObject> { return _pokemonJson }
    
    /// Dictionary from `json` file `pokemonMegaEvolutionJsonFileName`.
    public static var megaEvolutionPokemonJson: Dictionary<String, AnyObject> { return _megaEvolutionPokemonJson }
    
    /// All Pokemons with their information.
    public static var allPokemons: [DBPokemon] { return _allPokemons }
    
    /// All Mega Evolution Pokemons with their information.
    public static var allMegaEvolutionPokemons: [DBPokemon] { return _allMegaEvolutionPokemons }
    
    /// Pokemon dictionary.
    /// - note: Each dictionary's key is `Pokemon.key`.
    public static var pokemonMap: Dictionary<String, DBPokemon> { return _pokemonMap }
    
    // MARK: - Function
    
    /// Initializes and prepares `PokeData`'s properties.
    public static func initializes() {
        _pokemonJson = readPokemonJson()
        _megaEvolutionPokemonJson = readMegaEvolutionPokemonJson()
        
        _allMegaEvolutionPokemons = decodePokemons(from: _megaEvolutionPokemonJson)
        _allPokemons = decodePokemons(from: _pokemonJson) + _allMegaEvolutionPokemons
        _pokemonMap = createAllPokemonMap(pokemons: _allPokemons)
    }
    
    /// Read `pokemonJsonFileName.json` to `_allPokemonsJson`.
    private static func readPokemonJson() -> DictionarySA {
        return readJson(fileName: pokemonJsonFileName)
    }
    
    /// Read `pokemonMegaEvolutionJsonFileName.json` to `_allPokemonMegaEvolutionJson`
    private static func readMegaEvolutionPokemonJson() -> DictionarySA {
        return readJson(fileName: pokemonMegaEvolutionJsonFileName)
    }
    
    private static func createAllPokemonMap(pokemons: [DBPokemon]) -> Dictionary<String, DBPokemon> {
        var allPokemonsMap = Dictionary<String, DBPokemon>()
        for pokemon in pokemons {
            allPokemonsMap.updateValue(pokemon, forKey: pokemon.key)
        }
        return allPokemonsMap
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
}
