//
//  DBPokemon.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

// NOTE:
// This model is base on pokemon.json file exactly.
// Must update the model accordingly as the json file change, or consider optional value.


// MARK - Main class

/// Pokemon
public class DBPokemon: Encodable, Decodable, Equatable {
    
    let info: PokeInfo
    let types: PokeType
    let abilities: PokeAbility
    let stats: PokeStat
    let measurements: PokeMeasurement
    
    public static func ==(lhs: DBPokemon, rhs: DBPokemon) -> Bool {
        return lhs.info.id == rhs.info.id && lhs.info.name == rhs.info.name
    }
}

// MARK: - Attribute classes

/// Pokemon info
public struct PokeInfo: Encodable, Decodable {
    
    let id: Int
    let name: String
    let form: String
    let evolutionTree: Int
    let megaEvolution: [String]
}


/// Pokemon abilities
public struct PokeAbility: Encodable, Decodable {
    
    let first: String
    let second: String
    let hidden: String
}


/// Pokemon types
public struct PokeType: Encodable, Decodable {
    
    let primary: String
    let secondary: String
}


/// Pokemon stats
public struct PokeStat: Encodable, Decodable {
    
    let hp: Int
    let attack: Int
    let defense: Int
    let spAttack: Int
    let spDefense: Int
    let speed: Int
}


/// Pokemon measurements
public struct PokeMeasurement: Encodable, Decodable {
    
    let height: String
    let weight: String
}
