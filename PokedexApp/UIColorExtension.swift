//
//  Colors.swift
//  PokemonApp
//
//  Created by Dara on 3/3/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct Pokemon {
        
        static let ability = UIColor.AppObject.sectionBackground.withAlphaComponent(0.35)
        
        
        
        struct `Type` {
            
            static let normal = UIColor(red:0.66, green:0.66, blue:0.47, alpha:1.0) //A8A878
            
            static let fighting = UIColor(red:0.75, green:0.19, blue:0.16, alpha:1.0) //C03028
            
            static let flying = UIColor(red:0.66, green:0.56, blue:0.94, alpha:1.0) //A890F0
            
            static let poison = UIColor(red:0.63, green:0.25, blue:0.63, alpha:1.0) //A040A0
            
            static let ground = UIColor(red:0.88, green:0.75, blue:0.41, alpha:1.0) //E0C068
            
            static let rock = UIColor(red:0.72, green:0.63, blue:0.22, alpha:1.0) //B8A038
            
            static let bug = UIColor(red:0.66, green:0.72, blue:0.13, alpha:1.0) //A8B820
            
            static let ghost = UIColor(red:0.44, green:0.35, blue:0.60, alpha:1.0) //705898
            
            static let steel = UIColor(red:0.72, green:0.72, blue:0.82, alpha:1.0) //B8B8D0
            
            static let fire = UIColor(red:0.94, green:0.50, blue:0.19, alpha:1.0) //F08030
            
            static let water = UIColor(red:0.36, green:0.78, blue:0.90, alpha:1.0) //6890F0
            
            static let grass = UIColor(red:0.47, green:0.78, blue:0.31, alpha:1.0) //78C850
            
            static let electric = UIColor(red:0.97, green:0.82, blue:0.19, alpha:1.0) //F8D030
            
            static let psychic = UIColor(red:0.97, green:0.35, blue:0.53, alpha:1.0) //F85888
            
            static let ice = UIColor(red:0.60, green:0.85, blue:0.85, alpha:1.0) //98D8D8
            
            static let dragon = UIColor(red:0.44, green:0.22, blue:0.97, alpha:1.0) //7038F8
            
            static let dark = UIColor(red:0.44, green:0.35, blue:0.28, alpha:1.0) //705848
            
            static let fairy = UIColor(red:0.93, green:0.60, blue:0.67, alpha:1.0) //EE99AC
            
            static let unknown = UIColor(red:0.41, green:0.63, blue:0.56, alpha:1.0) //68A090
        }
        
        
        
        struct Move {
            
            static let physical = UIColor(red:1.00, green:0.27, blue:0.00, alpha:1.0)
            
            static let special = UIColor(red:0.13, green:0.40, blue:0.80, alpha:1.0)
            
            static let status = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
            
            static let zMove = UIColor(red:0.98, green:0.79, blue:0.05, alpha:1.0)
        }
    }
}



extension UIColor {
    
    static func pokemonType(from string: String) -> UIColor {
        
        switch string {
            
        case "Normal": return UIColor.Pokemon.Type.normal
            
        case "Fighting": return UIColor.Pokemon.Type.fighting
            
        case "Flying": return UIColor.Pokemon.Type.flying
            
        case "Poison": return UIColor.Pokemon.Type.poison
            
        case "Ground": return UIColor.Pokemon.Type.ground
            
        case "Rock": return UIColor.Pokemon.Type.rock
            
        case "Bug": return UIColor.Pokemon.Type.bug
            
        case "Ghost": return UIColor.Pokemon.Type.ghost
            
        case "Steel": return UIColor.Pokemon.Type.steel
            
        case "Fire": return UIColor.Pokemon.Type.fire
            
        case "Water": return UIColor.Pokemon.Type.water
            
        case "Grass": return UIColor.Pokemon.Type.grass
            
        case "Electric": return UIColor.Pokemon.Type.electric
            
        case "Psychic": return UIColor.Pokemon.Type.psychic
            
        case "Ice": return UIColor.Pokemon.Type.ice
            
        case "Dragon": return UIColor.Pokemon.Type.dragon
            
        case "Dark": return UIColor.Pokemon.Type.dark
            
        case "Fairy": return UIColor.Pokemon.Type.fairy
            
            
        case "Physical": return UIColor.Pokemon.Move.physical
            
        case "Special": return UIColor.Pokemon.Move.special
            
        case "Status": return UIColor.Pokemon.Move.status
            
            
        default: return UIColor.clear
        }
    }
}



extension UIColor {
    
    struct AppObject {
        
        // For custom objects in app
        
        static let sectionBackground = UIColor(red:0.78, green:0.87, blue:0.85, alpha:0.7) //C7DED9
        
        static let sectionText = UIColor(red:0.23, green:0.30, blue:0.31, alpha:1.0) //3B4D4F
        
        
        
        // For default objects in app
        
        static let navigationBar = UIColor.clear
        
        static let barItem = UIColor.clear
        
        static let viewController = UIColor.clear
        
        static let tableViewController = UIColor.clear
        
        static let tableViewSeparator = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1) //defaul color
    }
}
