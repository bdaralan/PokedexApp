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
typealias DidFinishAnimation = Bool


let globalCache = NSCache<AnyObject, AnyObject>()

let audioPlayer = AudioPlayer()


// Strct for all Constants
struct Constant {
    
    static let movesJSON: DictionarySA = LoadData.movesJSON()
    static let pokemonsJSON: DictionarySA = LoadData.pokemonsJSON()
    static let abilitiesJSON: DictionarySA = LoadData.abilitiesJSON()
    static let pokemonAbilitiesJSON: DictionarySA = LoadData.pokemonAbilitiesJSON()
    static let measurementsJSON: DictionarySA = LoadData.measurementsJSON()
    static let weaknessesJSON: DictionarySA = LoadData.weaknessesJSON()
    static let pokedexEntriesJSON: DictionarySA = LoadData.pokedexEntriesJSON()
    static let evolutionsJSON: DictionarySA = LoadData.evolutionJSON()
    static let itemsJSON: DictionarySA = LoadData.itemJSON()
    
    static var pokemonLearnMoveJSON: DictionarySA = LoadData.pokemonLearnMovesJSON()
    
    static let allPokemonsSortedById: [Pokemon] = LoadData.allPokemons(by: .id)
    static let allPokemonsSortedByName: [Pokemon] = allPokemonsSortedById
    static let allAbilities: [Ability] = LoadData.allAbilities()
    static let allTypes: [String] = LoadData.allTypes()
    static let allMoves: [Move] = LoadData.allMoves()
    static let allItems: [Item] = LoadData.allItems()
    
    static let evolutionSpecialCaseForm: [String] = LoadData.evolutionSpecialCaseForm()
    static let crySoundSepcialCaseName: DictionarySS = LoadData.crySoundSpecialCaseName()
    
    
    // Sub Struct
    struct Font {
        static let gillSans = UIFont(name: "GillSans", size: 17)
        static let gillSansSemiBold = UIFont(name: "GillSans-SemiBold", size: 17)
        static let appleSDGothicNeoRegular = UIFont(name: "AppleSDGothicNeo-Regular", size: 16) //pokedex entry text
    }
    
    struct Key {
        
        static let setting = SettingKey()
        
        struct SettingKey {
            let measurementSCSelectedIndex = "SettingMeasurementUnit"
            let soundEffectSwitchState = "SettingSoundEffectState"
        }
    }
    
    struct Constrain {
        
        static let margin: CGFloat = 16
        static let spacing: CGFloat = 8
        static let spcingView: CGFloat = 29
        static let sectionHeaderViewHeight: CGFloat = 45
    }
}
