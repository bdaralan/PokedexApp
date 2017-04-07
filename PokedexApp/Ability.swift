//
//  Ability.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class Ability {
    
    private var _name: String
    
    
    init(name: String) {
        _name = name
    }
    
    
    var name: String { return _name }
}
