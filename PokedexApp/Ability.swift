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
    
    var description: String {

        if _description == nil { self.parseCompletedInfo() }
        return _description
    }
    
    var generation: String {
        
        if _generation == nil { self.parseCompletedInfo() }
        return _generation
    }
    
    init(name: String, pokemon: String) {
        
        _name = name
        _pokemon = pokemon
    }
    
    private func parseCompletedInfo() {
        
        if let info = Constant.abilitiesJSON[_name] as? DictionarySS,
            let description = info["description"],
            let generation = info["generation"] {
            
            _description = description
            _generation = generation
        
        } else {
            _description = "???"
            _generation = "???"
        }
    }
}




extension Array where Element: Ability {
    
    func filter(for searchText: String, options: String.CompareOptions) -> [Ability] {
        
        return self.filter({$0.name.range(of: searchText, options: options) != nil})
    }
}




extension Array where Element: Ability {
    
    // Binary Search
    func search(forName searchName: String) -> Ability {
        
        var begin = 0
        var end = self.count - 1
        
        while begin <= end {
            let mid = (begin + end) / 2
            
            if self[mid].name == searchName {
                return self[mid]
            } else {
                if self[mid].name < searchName {
                    begin = mid + 1
                } else {
                    end = mid - 1
                }
            }
        }
        
        return Ability(name: "Error", pokemon: "Error")
    }
}
