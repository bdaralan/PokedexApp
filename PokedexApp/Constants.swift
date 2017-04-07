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
let POKEMON_JSON = loadJSON.loadPokemonJSON()

let pokemonData = PokemonData()
let POKEMONS = pokemonData.allPokemonById

let ABILITIES = [Ability]()
