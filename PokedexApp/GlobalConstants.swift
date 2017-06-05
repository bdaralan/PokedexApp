//
//  GlobalConstants.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

typealias DictionarySA = Dictionary<String, AnyObject>
typealias DictionarySS = Dictionary<String, String>




let globalCache = NSCache<AnyObject, AnyObject>()

let audioPlayer = AudioPlayer()

let VARIABLE = Variable()





class Variable {
    
    var allPokemonsSortedById: [Pokemon]!
    
    var allPokemonsSortedByName: [Pokemon]!
    
    var allAbilities: [Ability]!
    
    var allTypes: [String]!
    
    var allMoves: [Move]!
    
    var allItems: [Item]!
    
    init() {
        allPokemonsSortedById = LoadData.allPokemons(by: .id)
        allPokemonsSortedByName = LoadData.allPokemons(by: .name)
        allAbilities = LoadData.allAbilities
        allTypes = LoadData.allTypes
        allMoves = LoadData.allMoves
        allItems = LoadData.allItems
    }
}




struct Constant {
    
    static let movesJSON: DictionarySA = LoadData.movesJSON
    
    static let pokemonLearnMoveJSON: DictionarySA = LoadData.pokemonLearnMovesJSON
    
    static let pokemonsJSON: DictionarySA = LoadData.pokemonsJSON
    
    static let abilitiesJSON: DictionarySA = LoadData.abilitiesJSON
    
    static let pokemonAbilitiesJSON: DictionarySA = LoadData.pokemonAbilitiesJSON
    
    static let measurementsJSON: DictionarySA = LoadData.measurementsJSON
    
    static let weaknessesJSON: DictionarySA = LoadData.weaknessesJSON
    
    static let pokedexEntriesJSON: DictionarySA = LoadData.pokedexEntriesJSON
    
    static let evolutionsJSON: DictionarySA = LoadData.evolutionJSON
    
    static let itemsJSON: DictionarySA = LoadData.itemJSON
    
    static let evolutionSpecialCaseForm: [String] = LoadData.evolutionSpecialCaseForm
    
    static let crySoundSepcialCaseName: DictionarySS = LoadData.crySoundSpecialCaseName
    
    
    // Sub Struct
    struct Font {
        
        static let gillSans = UIFont(name: "GillSans", size: 17)
        
        static let gillSansSemiBold = UIFont(name: "GillSans-SemiBold", size: 17)
        
        static let appleSDGothicNeoRegular = UIFont(name: "AppleSDGothicNeo-Regular", size: 16) //pokedex entry text
    }
    
    struct Key {
        
        struct Setting {
            
            static let measurementSCSelectedIndex = "SettingMeasurementUnit"
            
            static let soundEffectSwitchState = "SettingSoundEffectState"
        }
    }
    
    struct Constrain {
        
        static let margin: CGFloat = 16
        
        static let spacing: CGFloat = 8
        
        static let spcingView: CGFloat = 29
        
        static let sectionHeaderViewHeight: CGFloat = 45
    }
}
