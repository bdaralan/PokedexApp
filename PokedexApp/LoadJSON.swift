//
//  LoadJSON.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class LoadJSON {
    
    func loadPokemonJSON() -> DictionarySA {
        if let path = Bundle.main.path(forResource: "pokemons", ofType: "json"), let data = NSData(contentsOfFile: path) as Data? {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                    
                    return json
                }
            } catch { print(error) }
        }
        
        return DictionarySA()
    }
    
    func loadAbilityJSON() -> DictionarySA {
        if let path = Bundle.main.path(forResource: "abilities", ofType: "json"), let data = NSData(contentsOfFile: path) as Data? {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                    
                    return json
                }
            } catch { print(error) }
        }
        
        return DictionarySA()
    }
}
