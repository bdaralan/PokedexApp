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
    
    init(name: String) {
        _name = name
    }
    
    func parseCompletedInfo() {
        
        if let info = ABILITIES_JSON[_name] as? DictionarySS,
            let pokemon = info["pokemon"],
            let description = info["description"],
            let generation = info["generation"] {
            
            _pokemon = pokemon
            _description = description
            _generation = generation
        }
    }
}
