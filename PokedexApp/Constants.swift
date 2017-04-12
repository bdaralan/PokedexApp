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

let COLORS = Colors()

let loadJSON = LoadJSON()
let POKEMON_JSON = loadJSON.pokemons()
let ABILITY_JSON = loadJSON.abilities()
let MEASUREMENT_JSON = loadJSON.measurements()
let WEAKNESSESS_JSON = loadJSON.weaknesses()
let POKEDEX_ENTERIES_JSON = loadJSON.pokedexEnteries()

let pokemonData = PokemonData()
let POKEMONS = pokemonData.allPokemonById

let ABILITIES = [Ability]()
