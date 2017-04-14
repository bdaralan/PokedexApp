//
//  LoadData.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class LoadData {
    
    func pokemonsJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokemons", ofType: "json")
    }
    
    func abilitiesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "abilities", ofType: "json")
    }
    
    func measurementsJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "measurements", ofType: "json")
    }
    
    func weaknessesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "weaknesses", ofType: "json")
    }
    
    func pokedexEnteriesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "pokedex-enteries", ofType: "json")
    }
    
    func movesJSON() -> DictionarySA {
        
        return loadDataFromFile(name: "moves", ofType: "json")
    }
    
    func homeMenuSections() -> [String] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let sections = homeMenu["Sections"] as? [String] {
            
            return sections
        }
        
        return [""]
    }
    
    func homeMenuRowsInSections() -> [[String]] {
        
        let plist = loadDataFromFile(name: "constants", ofType: "plist")
        if let homeMenu = plist["HomeMenu"] as? DictionarySA, let rowsInSection = homeMenu["RowsInSections"] as? [[String]] {
            
            return rowsInSection
        }
        
        return [[""]]
    }
    
    private func loadDataFromFile(name: String, ofType type: String) -> DictionarySA {
        
        if let path = Bundle.main.path(forResource: name, ofType: type), let data = NSData(contentsOfFile: path) as Data? {
            do {
                if type == "json" {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                        
                        return json
                    }
                } else {
                    if let plist = NSDictionary(contentsOfFile: path) as? DictionarySA {
                        
                        return plist
                    }
                }
            } catch { print(error) }
        }
        
        return DictionarySA()
    }
}
