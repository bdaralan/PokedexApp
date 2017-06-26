//
//  Variable.swift
//  PokedexApp
//
//  Created by Dara on 6/5/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class Variable {
    
    static private let loadData = LoadData()
    
    static let allPokemonsSortedById: [Pokemon] = loadData.allPokemons(by: .id)
    
    static let allPokemonsSortedByName: [Pokemon] = loadData.allPokemons(by: .name)
    
    static let allTypes: [String] = loadData.allTypes()
    
    static let allMoves: [Move] = loadData.allMoves()
    
    static let allAbilities: [Ability] = loadData.allAbilities()
    
    static let allItems: [Item] = loadData.allItems()
}
