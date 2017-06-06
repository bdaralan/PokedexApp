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
    
    var allPokemonsSortedById: [Pokemon]!
    
    var allPokemonsSortedByName: [Pokemon]!
    
    var allTypes: [String]!
    
    var allMoves: [Move]!
    
    var allAbilities: [Ability]!
    
    var allItems: [Item]!
    
    init() {
        allPokemonsSortedById = loadData.allPokemons(by: .id)
        allPokemonsSortedByName = loadData.allPokemons(by: .name)
        allTypes = loadData.allTypes()
        allMoves = loadData.allMoves()
        allAbilities = loadData.allAbilities()
        allItems = loadData.allItems()
        //allTypes = [String]()
        //allMoves = [Move]()
        //allAbilities = [Ability]()
        //allItems = [Item]()
    }
}
