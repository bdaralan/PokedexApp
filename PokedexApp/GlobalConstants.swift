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

let loadData = LoadData()

let CONSTANTS = Constant() // Constants use throughout the app


// Strct for all Constants
struct Constant {
    
    let movesJSON: DictionarySA!
    let pokemonsJSON: DictionarySA!
    let abilitiesJSON: DictionarySA!
    let pokemonAbilitiesJSON: DictionarySA!
    let measurementsJSON: DictionarySA!
    let weaknessesJSON: DictionarySA!
    let pokedexEntriesJSON: DictionarySA!
    let evolutionsJSON: DictionarySA!
    let itemsJSON: DictionarySA!
    
    let allPokemonsSortedById: [Pokemon]!
    let allPokemonsSortedByName: [Pokemon]!
    let allAbilities: [Ability]!
    let allTypes: [String]!
    let allMoves: [Move]!
    let allItems: [Item]!
    
    let evolutionSpecialCaseForm: [String]!
    let crySoundSepcialCaseName: DictionarySS!
    
    let keys: Key!
    let constrain: Constrain!
    
    init() {
        movesJSON = loadData.movesJSON()
        pokemonsJSON = loadData.pokemonsJSON()
        abilitiesJSON = loadData.abilitiesJSON()
        pokemonAbilitiesJSON = loadData.pokemonAbilitiesJSON()
        measurementsJSON = loadData.measurementsJSON()
        weaknessesJSON = loadData.weaknessesJSON()
        pokedexEntriesJSON = loadData.pokedexEntriesJSON()
        evolutionsJSON = loadData.evolutionJSON()
        itemsJSON = loadData.itemJSON()
        
        allPokemonsSortedById = loadData.allPokemons(by: .id)
        allPokemonsSortedByName = allPokemonsSortedById.sortByAlphabet()
        allAbilities = loadData.allAbilities()
        allTypes = loadData.allTypes()
        allMoves = loadData.allMoves()
        allItems = loadData.allItems()
        
        evolutionSpecialCaseForm = loadData.evolutionSpecialCaseForm()
        crySoundSepcialCaseName = loadData.crySoundSpecialCaseName()
        
        keys = Key()
        constrain = Constrain()
    }
    
    
    // Sub Struct
    struct Key {
        
        let setting = SettingKey()
        
        struct SettingKey {
            let measurementSCSelectedIndex = "SettingMeasurementUnit"
            let soundEffectSwitchState = "SettingSoundEffectState"
        }
    }
    
    struct Constrain {
        
        let margin: CGFloat = 16
        let spacing: CGFloat = 8
        let spcingView: CGFloat = 29
    }
}
