//
//  GlobalConstants.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

typealias DictionarySA = Dictionary<String, AnyObject>
typealias DictionarySS = Dictionary<String, String>
typealias DidFinishAnimation = Bool

var globalCache = NSCache<AnyObject, AnyObject>()

let KEYS = Key()
let COLORS = Colors()
let loadData = LoadData()
let CONSTANTS = Constant()

struct Constant {
    
    let movesJSON = loadData.movesJSON()
    let pokemonsJSON = loadData.pokemonsJSON()
    let abilitiesJSON = loadData.abilitiesJSON()
    let pokemonAbilitiesJSON = loadData.pokemonAbilitiesJSON()
    let measurementsJSON = loadData.measurementsJSON()
    let weaknessesJSON = loadData.weaknessesJSON()
    let pokedexEntriesJSON = loadData.pokedexEntriesJSON()
    let evolutionsJSON = loadData.evolutionJSON()
    let itemsJSON = loadData.itemJSON()
    
    let allPokemonsSortedById = loadData.allPokemons(by: .id)
    let allAbilities = loadData.allAbilities()
    let allTypes = loadData.allTypes()
    let allMoves = loadData.allMoves()
    let allItems = loadData.allItems()
    
    let constrain = Constrain()
}

struct Key {
    
    struct SettingKey {
        let measurementSCSelectedIndex = "SettingMeasurementUnit"
    }
    
    let Setting = SettingKey()
}

struct Constrain {
    
    let margin: CGFloat = 16
    let spacing: CGFloat = 8
}
