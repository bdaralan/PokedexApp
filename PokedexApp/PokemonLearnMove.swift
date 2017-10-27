//
//  PokemonLearnMove.swift
//  PokedexApp
//
//  Created by Dara on 10/26/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

enum MoveLearnMethod {
    
    case any
    case levelUp
    case breed
    case breedOrLevelUp
}

struct PokemonLearnMove {
    
    let moveName: String
    let pokemonId: String
    let learnLevels: [String]
    
    public var learnMethod: MoveLearnMethod {
        
        let hasLearnByBreed = learnLevels.contains("0")
        switch learnLevels.count > 1 {
        case true: return hasLearnByBreed ? .breedOrLevelUp : .levelUp
        case false: return hasLearnByBreed ? .breed : .levelUp
        }
    }
}

// MARK: - Convenient array init

extension PokemonLearnMove {
    
    /// Initialize an array of `PokemonLearMove` from `Dictionary`
    /// - parameter moveDictionary: example: `Dictionaory<PokemonId, [LearnLevel]>`
    public static func initArray(moveName: String, moveDictionary: Dictionary<String, [String]>) -> [PokemonLearnMove] {
        
        var learnPokemons = [PokemonLearnMove]()
        for (pokemonId, learnLevels) in moveDictionary {
            let learnPokemon = PokemonLearnMove(moveName: moveName, pokemonId: pokemonId, learnLevels: learnLevels)
            learnPokemons.append(learnPokemon)
        }
        return learnPokemons
    }
}
