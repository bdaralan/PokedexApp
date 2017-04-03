//
//  PokemonData.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

class PokemonData {
    
    var allPokemonById: [Pokemon] {
        return parseAllPokemon().sorted(by: {"\($0.id.toPokedexId())\($0.form)" < "\($1.id.toPokedexId())\($1.form)"})
    }
    
    var allPokemonByName: [Pokemon] {
        return parseAllPokemon().sorted(by: {$0.name < $1.name})
    }
    
    
    private func parseAllPokemon() -> [Pokemon] {
        
        var pokemons = [Pokemon]()
        
        if let path = Bundle.main.path(forResource: "pokemons", ofType: "json"), let data = NSData(contentsOfFile: path) as Data? {
            
            do {
                
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? DictionarySA {
                    
                    let names = json.keys
                    
                    for name in names {
                        
                        if let pokemonInfo = json[name] as? DictionarySA, let id = pokemonInfo["id"] as? Int, let form = pokemonInfo["form"] as? String {
                            
                            pokemons.append(Pokemon(name: name, id: id, form: form))
                        }
                    }
                }
            } catch { print(error) }
        }
        
        return pokemons
    }
}
