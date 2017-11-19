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

private var _allPokemonsJson: DictionarySA!

private var _allMegaEvolutionPokemonsJson: DictionarySA!

private var _allPokemons: [DBPokemon]!

private var _allMegaEvolutionPokemons: [DBPokemon]!


// MARK: - Main class

public struct PokeData {
    
    // MARK: - Getter
    
    /// All Pokemons with their information.
    public static var allPokemon: [DBPokemon] { return _allPokemons }
    
    /// All Mega Evolution Pokemons with their information.
    public static var allMegaEvolutionPokemons: [DBPokemon] { return _allMegaEvolutionPokemons }
    
    // MARK: - Function
    
    /// Initializes and prepares `PokeData`'s properties.
    public static func initializes() {
        _allPokemonsJson = readPokemonJson()
        _allMegaEvolutionPokemonsJson = readMegaEvolutionPokemonJson()
        _allPokemons = decodePokemons(from: _allPokemonsJson)
        _allMegaEvolutionPokemons = decodePokemons(from: _allMegaEvolutionPokemonsJson)
    }
    
    /// Read `pokemonJsonFileName.json` to `_allPokemonsJson`.
    private static func readPokemonJson() -> DictionarySA {
        return readJson(fileName: pokemonJsonFileName)
    }
    
    /// Read `pokemonMegaEvolutionJsonFileName.json` to `_allPokemonMegaEvolutionJson`
    private static func readMegaEvolutionPokemonJson() -> DictionarySA {
        return readJson(fileName: pokemonMegaEvolutionJsonFileName)
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
