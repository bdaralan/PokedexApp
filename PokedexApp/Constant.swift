//
//  GlobalConstants.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

struct Constant {
    
    static private let loadData = LoadData()
    
    static let movesJSON: DictionarySA = loadData.movesJSON
    
    static let pokemonLearnMoveJSON: DictionarySA = loadData.pokemonLearnMovesJSON
    
    static let pokemonsJSON: DictionarySA = loadData.pokemonsJSON
    
    static let abilitiesJSON: DictionarySA = loadData.abilitiesJSON
    
    static let pokemonAbilitiesJSON: DictionarySA = loadData.pokemonAbilitiesJSON
    
    static let measurementsJSON: DictionarySA = loadData.measurementsJSON
    
    static let weaknessesJSON: DictionarySA = loadData.weaknessesJSON
    
    static let pokedexEntriesJSON: DictionarySA = loadData.pokedexEntriesJSON
    
    static let evolutionsJSON: DictionarySA = loadData.evolutionJSON
    
    static let itemsJSON: DictionarySA = loadData.itemJSON
    
    static let evolutionSpecialCaseForm: [String] = loadData.evolutionSpecialCaseForm
    
    static let crySoundSepcialCaseName: DictionarySS = loadData.crySoundSpecialCaseName
    
    
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
        
        static let frameUnderNavController: CGRect = {
            
            var rect = CGRect(x: 0, y: 0, width: 64, height: 64)
            
            guard let windowFrame = UIApplication.shared.keyWindow?.frame else { return rect }
            let statusBarFrame = UIApplication.shared.statusBarFrame
            rect.size.width = windowFrame.width
            rect.size.height = 64
            rect.origin.x = 0
            rect.origin.y = statusBarFrame.origin.y + statusBarFrame.height + UINavigationController().navigationBar.frame.height
            
            return rect
        }()
    }
}
