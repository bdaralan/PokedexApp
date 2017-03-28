//
//  Constants.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

typealias DictionarySA = Dictionary<String, AnyObject>

let loadJSON = LoadJSON()

let POKEMON_JSON = loadJSON.loadPokemonJSON()

let pokemonData = PokemonData()
let POKEMONS = pokemonData.allPokemon.sorted(by: {$0.id < $1.id})
