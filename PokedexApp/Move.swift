//
//  Move.swift
//  PokedexApp
//
//  Created by Dara on 4/14/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class Move {
    
    private var _name: String!
    private var _type: String!
    private var _category: String!
    private var _power: String!
    private var _accuracy: String!
    private var _pp: String!
    private var _tm: String!
    private var _effect: String!
    private var _prob: String!
    
    var name: String { return _name != nil ? _name : "" }
    var type: String { return _type != nil ? _type : "" }
    var category: String { return _category != nil ? _category : "" }
    var power: String { return _power != nil ? _power : ""  }
    var accuracy: String { return _accuracy != nil ? _accuracy : ""  }
    var pp: String { return _pp != nil ? _pp : ""  }
    var tm: String { return _tm != nil ? _tm : ""  }
    var effect: String { return _effect != nil ? _effect : ""  }
    var prob: String { return _prob != nil ? _prob : ""  }
    
    init(name: String, type: String, category: String) {
        _name = name
        _type = type
        _category = category
    }
    
    func parseCompletedInfo() {
        
        if let move = CONSTANTS.movesJSON[self.name] as? DictionarySS,
            let power = move["power"],
            let accuracy = move["accuracy"],
            let pp = move["pp"],
            let tm = move["tm"],
            let effect = move["effect"],
            let prob = move["prob"] {
            
            _power = power
            _accuracy = accuracy
            _pp = pp
            _tm = tm
            _effect = effect
            _prob = prob
        }
    }
}


extension Array where Element: Move {
    
    func filter(for searchText: String, options: String.CompareOptions) -> [Move] {
        
        return self.filter({$0.name.range(of: searchText, options: options) != nil})
    }
}
