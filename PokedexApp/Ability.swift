//
//  Ability.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class Ability {
    
    private var _name: String!
    private var _pokemon: String!
    private var _description: String!
    private var _generation: String!
    
    var name: String { return _name }
    var pokemon: String { return _pokemon }
    var description: String { return _description }
    var generation: String { return _generation }
    
    init(name: String, pokemon: String) {
        _name = name
        _pokemon = pokemon
    }
    
    func parseCompletedInfo() {
        
        if let info = CONSTANTS.abilitiesJSON[_name] as? DictionarySS,
            let description = info["description"],
            let generation = info["generation"] {
            
            _description = description
            _generation = generation
        }
    }
}


extension Array where Element: Ability {
    
    func filter(for searchText: String, options: String.CompareOptions) -> [Ability] {
        
        return self.filter({$0.name.range(of: searchText, options: options) != nil})
    }
}
