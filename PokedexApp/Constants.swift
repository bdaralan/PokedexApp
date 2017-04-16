//
//  Constants.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

typealias DictionarySA = Dictionary<String, AnyObject>
typealias DictionarySS = Dictionary<String, String>
typealias DidFinishAnimation = Bool

var globalCache = NSCache<AnyObject, AnyObject>() //considered as constatns

let COLORS = Colors()
let CONSTANTS = Constants()
let loadData = LoadData()


struct Constants {
    
    let movesJSON = loadData.movesJSON()
    let pokemonsJSON = loadData.pokemonsJSON()
    let abilitiesJSON = loadData.abilitiesJSON()
    let pokemonAbilitiesJSON = loadData.pokemonAbilitiesJSON()
    let measurementsJSON = loadData.measurementsJSON()
    let weaknessesJSON = loadData.weaknessesJSON()
    let pokedexEntriesJSON = loadData.pokedexEntriesJSON()
    
    let allPokemons = loadData.allPokemons(by: .id)
    let allAbilities = loadData.allAbilities()
    let allTypes = loadData.allTypes()
    let allMoves = loadData.allMoves()
}
