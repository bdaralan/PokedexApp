//
//  GlobalConstants.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

let globalCache = NSCache<AnyObject, AnyObject>()

struct Constant {
    
    static private let loadData = LoadData()
    
    static let pokemonsJSON: DictionarySA = loadData.pokemonsJSON
    
    static let pokemonLearnMoveJSON: DictionarySA = loadData.pokemonLearnMovesJSON
    
    static let movesJSON: DictionarySA = loadData.movesJSON
    
    static let abilitiesJSON: DictionarySA = loadData.abilitiesJSON
    
    static let pokemonAbilitiesJSON: DictionarySA = loadData.pokemonAbilitiesJSON
    
    static let itemsJSON: DictionarySA = loadData.itemJSON
    
    static let measurementsJSON: DictionarySA = loadData.measurementsJSON
    
    static let defensesJSON: DictionarySA = loadData.defensesJSON
    
    static let pokedexEntriesJSON: DictionarySA = loadData.pokedexEntriesJSON
    
    static let evolutionsJSON: DictionarySA = loadData.evolutionJSON
    
    static let evolutionSpecialCaseForm: [String] = loadData.evolutionSpecialCaseForm
    
    static let crySoundSepcialCaseName: DictionarySS = loadData.crySoundSpecialCaseName
    
    
    struct Font {
        
        static let gillSans = UIFont(name: "GillSans", size: 17)
        
        static let gillSansBold = UIFont(name: "GillSans-Bold", size: 17)
        
        static let gillSansSemiBold = UIFont(name: "GillSans-SemiBold", size: 17)
        
        static let appleSDGothicNeoRegular = UIFont(name: "AppleSDGothicNeo-Regular", size: 16) //pokedex entry text
    }
    
    struct Key {
        
        struct Setting {
            
            static let measurementSCSelectedIndex = "SettingMeasurementUnit"
            
            static let soundEffectSwitchState = "SettingSoundEffectState"
        }
    }
    
    struct UnicodeCharacter {
        
        static let weight = "𐄷"
        
        static let angle = "∡"
    }
    
    struct Constrain {
        
        static let margin: CGFloat = 16
        
        static let spacing: CGFloat = 8
        
        static let spacingView: CGFloat = 29
        
        static let sectionHeaderViewHeight: CGFloat = 45
        
        static let keyWindowFrame: CGRect = {
            
            guard let keyWindowFrame = UIApplication.shared.keyWindow?.frame else {
                fatalError("Cannot get keyWindow from UIApplication shared instance")
            }
            return keyWindowFrame
        }()
        
        static let frameUnderNavController: CGRect = {
            
            var rect = CGRect(x: 0, y: 0, width: 64, height: 64)
            let windowFrame = keyWindowFrame
            let statusBarFrame = UIApplication.shared.statusBarFrame
            rect.size.width = windowFrame.width
            rect.size.height = 64
            rect.origin.x = 0
            rect.origin.y = statusBarFrame.origin.y + statusBarFrame.height + UINavigationController().navigationBar.frame.height
            return rect
        }()
        
        static let viewlauncherFrameUnderNavBar: CGRect = {
            
            guard let keyWindowFrame = UIApplication.shared.keyWindow?.frame else {
                fatalError("Cannot get keyWindow from UIApplication shared instance")
            }
            let statusBarFrame = UIApplication.shared.statusBarFrame
            let x: CGFloat = 0
            let y = statusBarFrame.origin.y + statusBarFrame.height + UINavigationController().navigationBar.frame.height
            let width = keyWindowFrame.width
            let height = keyWindowFrame.height
            return CGRect(x: x, y: y, width: width, height: height)
        }()
    }
}
