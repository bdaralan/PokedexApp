//
//  LoadJSON.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class LoadJSON {
    
    func pokemons() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemons")
    }
    
    func abilities() -> DictionarySA {
        
        return loadDataFromFile(name: "abilities")
    }
    
    func measurements() -> DictionarySA {
        
        return loadDataFromFile(name: "measurements")
    }
    
    func weaknesses() -> DictionarySA {
        
        return loadDataFromFile(name: "weaknesses")
    }
    
    func pokedexEnteries() -> DictionarySA {
        
        return loadDataFromFile(name: "pokedex-enteries")
    }
    
    private func loadDataFromFile(name: String) -> DictionarySA {
        
        if let path = Bundle.main.path(forResource: name, ofType: "json"), let data = NSData(contentsOfFile: path) as Data? {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                    
                    return json
                }
            } catch { print(error) }
        }
        
        return DictionarySA()
    }
}
