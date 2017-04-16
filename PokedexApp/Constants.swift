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

let COLORS = Colors()

let loadData = LoadData()
let MOVES_JSON = loadData.movesJSON()
let POKEMON_JSON = loadData.pokemonsJSON()
let ABILITY_JSON = loadData.abilitiesJSON()
let POKEMON_ABILITY_JSON = loadData.pokemonAbilitiesJSON()
let MEASUREMENT_JSON = loadData.measurementsJSON()
let WEAKNESSESS_JSON = loadData.weaknessesJSON()
let POKEDEX_ENTERIES_JSON = loadData.pokedexEnteriesJSON()

let POKEMONS = loadData.allPokemons(by: .id)
let ABILITIES = loadData.allAbilities(by: .name)

var globalCache = NSCache<AnyObject, AnyObject>() //considered as constatns
