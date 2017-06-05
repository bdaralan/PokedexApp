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
    
    
    var name: String { return _name }
    
    var type: String { return _type }
    
    var category: String { return _category }
    
    var power: String {
        
        if _power == nil { parseCompletedInfo() }
        return _power
    }
    
    var accuracy: String {
        
        if _accuracy == nil { parseCompletedInfo() }
        return _accuracy
    }
    
    var pp: String {
        
        if _pp == nil { parseCompletedInfo() }
        return _pp
    }
    
    var tm: String {
        
        if _tm == nil { parseCompletedInfo() }
        return _tm
    }
    
    var effect: String {
        
        if _effect == nil { parseCompletedInfo() }
        return _effect
    }
    
    var prob: String {
        
        if _prob == nil { parseCompletedInfo() }
        return _prob
    }
    
    
    init(name: String, type: String, category: String) {
        
        _name = name
        _type = type
        _category = category
    }
    
    private func parseCompletedInfo() {
        
        if let move = Constant.movesJSON[self.name] as? DictionarySS,
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
        
        } else {
            _power = "???"
            _accuracy = "???"
            _pp = "???"
            _tm = "???"
            _effect = "???"
            _prob = "???"
        }
    }
}




// Move learn by pokemons
extension Move {
    
    enum LearnMethod: Int {
        case any
        case levelup
        case breedOrMachine
    }
    
    func pokemonsLearn(by learnMethod: LearnMethod) -> [Pokemon] {
        
        var pokemons = [Pokemon]()
        
        if let moveDict = Constant.pokemonLearnMoveJSON[name] as? Dictionary<String,[String]>, moveDict.keys.count > 0 {
            
            for id in moveDict.keys {
                
                if let levels = moveDict[id] {
                    
                    switch learnMethod {
                        
                    case .any:
                        let learnablePokemons = VARIABLE.allPokemonsSortedById.filter(forId: id)
                        for pokemon in learnablePokemons { pokemons.append(pokemon) }
                        
                    case .levelup:
                        if !levels.contains("0") {
                            let learnablePokemons = VARIABLE.allPokemonsSortedById.filter(forId: id)
                            for pokemon in learnablePokemons { pokemons.append(pokemon) }
                        }
                        
                    case .breedOrMachine:
                        if levels.contains("0") {
                            let learnablePokemons = VARIABLE.allPokemonsSortedById.filter(forId: id)
                            for pokemon in learnablePokemons { pokemons.append(pokemon) }
                        }
                    }
                }
            }
        }
        
        return pokemons.sortById()
    }
}




// Shorthand filter
extension Array where Element: Move {
    
    func filter(forName name: String, options: String.CompareOptions) -> [Move] {
        
        return self.filter({$0.name.range(of: name, options: options) != nil})
    }
    
    func filter(forType type: String) -> [Move] {
        
        return self.filter({$0.type == type})
    }
}
