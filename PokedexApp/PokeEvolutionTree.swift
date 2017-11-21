//
//  PokeEvolutionTree.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

// MARK: - Main class

/// PokemonEvolutionTree
public class PokeEvolutionTree: Encodable, Decodable {
    
    let basePokemon: String
    let pokemonNodes: [PokemonNode]
    
    init(base: String = "", pokemons: [PokemonNode] = []) {
        self.basePokemon = base
        self.pokemonNodes = pokemons
    }
    
    ///
    convenience init(baseId: Int) {
        let key = String(format: "%04d", baseId)
        let dictionary = PokeData.pokemonEvolutionTreeJson[key] as? DictionarySA
        self.init(dictionary: dictionary)
    }
    
    /// Decode a pokemon evolution tree dictionary
    convenience init(dictionary: DictionarySA?) {
        guard let dictionary = dictionary else {
            self.init()
            return
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let tree = try JSONDecoder().decode(PokeEvolutionTree.self, from: data)
            self.init(base: tree.basePokemon, pokemons: tree.pokemonNodes)
        } catch {
            self.init()
            print("\(PokeEvolutionTree.self).init(dictionary: DictionarySA?) fail!!")
            print(error.localizedDescription)
        }
    }
    
    public func pokemonNodes(evolutionStage: PokeEvolutionStage) -> [PokemonNode] {
        return pokemonNodes.filter({ $0.stage == evolutionStage.rawValue })
    }
}

// MARK: - PokemonEvolutionTree attribute class

/// PokemonNode
public struct PokemonNode: Encodable, Decodable {
    
    let condition: [String]
    let next: [String]
    let pokemon: String
    let prev: String
    let stage: Int
}

/// PokeEvolutionStage
public enum PokeEvolutionStage: Int {
    case first = 1
    case second
    case third
}
