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

var globalCache = NSCache<AnyObject, AnyObject>()

let audioPlayer = AudioPlayer()

let KEYS = Key()
let COLORS = Colors()
let loadData = LoadData()
let CONSTANTS = Constant()

class Constant {
    
    lazy var movesJSON = loadData.movesJSON()
    lazy var pokemonsJSON = loadData.pokemonsJSON()
    lazy var abilitiesJSON = loadData.abilitiesJSON()
    lazy var pokemonAbilitiesJSON = loadData.pokemonAbilitiesJSON()
    lazy var measurementsJSON = loadData.measurementsJSON()
    lazy var weaknessesJSON = loadData.weaknessesJSON()
    lazy var pokedexEntriesJSON = loadData.pokedexEntriesJSON()
    lazy var evolutionsJSON = loadData.evolutionJSON()
    lazy var itemsJSON = loadData.itemJSON()
    
    lazy var allPokemonsSortedById = loadData.allPokemons(by: .id)
    lazy var allAbilities = loadData.allAbilities()
    lazy var allTypes = loadData.allTypes()
    lazy var allMoves = loadData.allMoves()
    lazy var allItems = loadData.allItems()
    
    lazy var evolutionSpecialCaseForm = loadData.evolutionSpecialCaseForm()
    lazy var crySoundSepcialCaseName = loadData.crySoundSpecialCaseName()
    
    lazy var constrain = Constrain()
}

struct Key {
    
    struct SettingKey {
        let measurementSCSelectedIndex = "SettingMeasurementUnit"
        let soundEffectSwitchState = "SettingSoundEffectState"
    }
    
    let Setting = SettingKey()
}

struct Constrain {
    
    let margin: CGFloat = 16
    let spacing: CGFloat = 8
}
