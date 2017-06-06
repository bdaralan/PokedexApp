//
//  Variable.swift
//  PokedexApp
//
//  Created by Dara on 6/5/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

typealias DictionarySA = Dictionary<String, AnyObject>
typealias DictionarySS = Dictionary<String, String>



let globalCache = NSCache<AnyObject, AnyObject>()

let audioPlayer = AudioPlayer()

let loadData = LoadData()

let VARIABLE = Variable()



class Variable {
    
    lazy var allPokemonsSortedById: Array<Pokemon> = loadData.allPokemons(by: .id)
    
    lazy var allPokemonsSortedByName: Array<Pokemon> = loadData.allPokemons(by: .name)
    
    lazy var allTypes: Array<String> = loadData.allTypes()
    
    lazy var allMoves: Array<Move> = loadData.allMoves()
    
    lazy var allAbilities: Array<Ability> = loadData.allAbilities()
    
    lazy var allItems: Array<Item> = loadData.allItems()
}
