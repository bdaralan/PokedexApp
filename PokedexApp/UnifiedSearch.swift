//
//  UnifiedSearch.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class UnifiedSearch {
    
    func result(with searchController: UISearchController, searchDomain: SearchDomain) -> Any {
        
        var result: Any!
        
        if let searchText = searchController.searchBar.text, searchText != "" {
            
            switch searchDomain {
                
            case .Pokemon:
                result = CONSTANTS.allPokemons.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
                
            case .Ability:
                result = CONSTANTS.allAbilities.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
            }
        } else {
            
            switch searchDomain {
                
            case .Pokemon:
                result = CONSTANTS.allPokemons
                
            case .Ability:
                result = CONSTANTS.allAbilities
            }
        }
        
        return result
    }
}

enum SearchDomain {
    
    case Pokemon
    case Ability
}
