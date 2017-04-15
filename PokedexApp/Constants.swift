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
let POKEMON_JSON = loadData.pokemonsJSON()
let ABILITY_JSON = loadData.abilitiesJSON()
let MEASUREMENT_JSON = loadData.measurementsJSON()
let WEAKNESSESS_JSON = loadData.weaknessesJSON()
let POKEDEX_ENTERIES_JSON = loadData.pokedexEnteriesJSON()

let pokemonData = PokemonData()
let POKEMONS = pokemonData.allPokemonById

let ABILITIES = [Ability]()

var globalCache = NSCache<AnyObject, AnyObject>() //considered as constatns
