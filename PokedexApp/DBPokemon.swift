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

// MARK: - Pokemon Extension

public extension DBPokemon {
    
    public var key: String {
        return String.init(format: "%04d%@", info.id, info.name)
    }
    
    public var imageAssetName: String {
        return "\(info.id)-\(info.form.lowercased())"
    }
    
    /// Grab Pokedex entry from `PokeData.pokedexEntryJson`.
    /// - note: `return` An empty `PokeEntry` if entry not found.
    public var pokedexEntry: PokeEntry {
        if let dict = PokeData.pokedexEntryJson["\(info.id)"] as? DictionarySA {
            do {
                let data = try JSONSerialization.data(withJSONObject: dict, options: [])
                let entry = try JSONDecoder().decode(PokeEntry.self, from: data)
                return entry
            } catch {
                print(error.localizedDescription)
            }
        }
        return PokeEntry(omega: "", alpha: "")
    }
}

// MARK: - Pokemon attribute class

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
    
    var hasFirst: Bool { return !first.isEmpty }
    var hasSecond: Bool { return !second.isEmpty }
    var hasHidden: Bool { return !hidden.isEmpty }
}


/// Pokemon types
public struct PokeType: Encodable, Decodable {
    
    let primary: String
    let secondary: String
    
    var hasSecondary: Bool { return !secondary.isEmpty }
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


/// PokedexEntry
public struct PokeEntry: Encodable, Decodable {
    
    let omega: String
    let alpha: String
    
    var isEmpty: Bool { return omega.isEmpty && alpha.isEmpty }
    var isSameEntry: Bool { return omega == alpha }
    
    static func prettyString(_ pokemon: DBPokemon) -> String {
        let entry = pokemon.pokedexEntry
        guard !entry.omega.isEmpty, !entry.omega.isEmpty else { return "\(pokemon.info.name)..." }
        switch entry.omega == entry.alpha {
        case true: return "ORAS:\n\(entry.omega)"
        case false: return "Omega Ruby:\n\(entry.omega)\n\nAlpha Sapphire:\n\(entry.alpha)"
        }
    }
}
