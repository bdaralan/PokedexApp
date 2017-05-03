//
//  Item.swift
//  PokedexApp
//
//  Created by Dara on 5/1/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class Item {
    
    private var _name: String
    private var _category: String
    private var _effect: String
    
    var name: String { return _name }
    var category: String { return _category }
    var effect: String { return _effect }
    
    var hasCompletedInfo: Bool { return _effect != "" }
    
    init(name: String, category: String, effect: String = "") {
        self._name = name
        self._category = category
        self._effect = effect
    }
    
    func parseCompletedInfo() {
        
        if let itemDict = CONSTANTS.itemsJSON[_name] as? DictionarySS, let effect = itemDict["effect"] {
            self._effect = effect
        }
    }
}

extension Array where Element: Item {
    
    var machines: [Item] {
        return self.filter({$0.category == "Machines"})
    }
    
    var berries: [Item] {
        return self.filter({$0.category == "Berries"})
    }
    
    var excludeBerriesMachines: [Item] {
        return self.filter({$0.category != "Machines" && $0.category != "Berries"})
    }
}
