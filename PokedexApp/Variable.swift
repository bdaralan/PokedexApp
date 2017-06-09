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

let VARIABLE = Variable()



class Variable {
    
    static private let loadData = LoadData()
    
    lazy var allPokemonsSortedById: [Pokemon] = loadData.allPokemons(by: .id)
    
    lazy var allPokemonsSortedByName: [Pokemon] = loadData.allPokemons(by: .name)
    
    lazy var allTypes: [String] = loadData.allTypes()
    
    lazy var allMoves: [Move] = loadData.allMoves()
    
    lazy var allAbilities: [Ability] = loadData.allAbilities()
    
    lazy var allItems: [Item] = loadData.allItems()
}
