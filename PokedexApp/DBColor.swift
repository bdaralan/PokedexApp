//
//  DBColor.swift
//  PokemonApp
//
//  Created by Dara on 3/3/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

struct DBColor {
    
    /// Pokemon mix color
    struct Pokemon {
        
        static let ability = AppObject.sectionBackground.withAlphaComponent(0.35)
    }
    
    /// Pokemon type color
    struct PokemonType {
        
        static let normal = UIColor(red: 168.range, green: 168.range, blue: 120.range, alpha: 1) //A8A878
        
        static let fighting = UIColor(red: 192.range, green: 48.range, blue: 40.range, alpha: 1) //C03028
        
        static let flying = UIColor(red: 168.range, green: 144.range, blue: 240.range, alpha: 1) //A890F0
        
        static let poison = UIColor(red: 160.range, green: 64.range, blue: 160.range, alpha: 1) //A040A0
        
        static let ground = UIColor(red: 224.range, green: 192.range, blue: 104.range, alpha: 1) //E0C068
        
        static let rock = UIColor(red: 184.range, green: 160.range, blue: 56.range, alpha: 1) //B8A038
        
        static let bug = UIColor(red: 168.range, green: 184.range, blue: 32.range, alpha: 1) //A8B820
        
        static let ghost = UIColor(red: 112.range, green: 88.range, blue: 152.range, alpha: 1) //705898
        
        static let steel = UIColor(red: 184.range, green: 184.range, blue: 208.range, alpha: 1) //B8B8D0
        
        static let fire = UIColor(red: 240.range, green: 128.range, blue: 48.range, alpha: 1) //F08030
        
        static let water = UIColor(red: 104.range, green: 144.range, blue: 240.range, alpha: 1) //6890F0
        
        static let grass = UIColor(red: 120.range, green: 200.range, blue: 80.range, alpha: 1) //78C850
        
        static let electric = UIColor(red: 248.range, green: 208.range, blue: 48.range, alpha: 1) //F8D030
        
        static let psychic = UIColor(red: 248.range, green: 88.range, blue: 136.range, alpha: 1) //F85888
        
        static let ice = UIColor(red: 152.range, green: 216.range, blue: 261.range, alpha: 1) //98D8D8
        
        static let dragon = UIColor(red: 112.range, green: 56.range, blue: 248.range, alpha: 1) //7038F8
        
        static let dark = UIColor(red: 112.range, green: 88.range, blue: 72.range, alpha: 1) //705848
        
        static let fairy = UIColor(red: 238.range, green: 153.range, blue: 172.range, alpha: 1) //EE99AC
        
        static let unknown = UIColor(red: 104.range, green: 160.range, blue: 144.range, alpha: 1) //68A090
    }
    
    /// Pokemon move color
    struct PokemonMove {
        
        static let physical = UIColor(red: 255.range, green: 69.range, blue: 0.range, alpha: 1) //FF4500
        
        static let special = UIColor(red: 34.range, green: 102.range, blue: 204.range, alpha: 1) //2266CC
        
        static let status = UIColor(red: 153.range, green: 153.range, blue: 153.range, alpha: 1) //999999
        
        static let zMove = UIColor(red: 250.range, green: 202.range, blue: 13.range, alpha: 1) //FACA0D
    }
    
    /// App object color
    struct AppObject {
        
        // For custom objects in app
        
        static let sectionBackground = UIColor(red: 199.range, green: 222.range, blue: 217.range, alpha: 0.7) //C7DED9
        
        static let sectionText = UIColor(red: 59.range, green: 77.range, blue: 79.range, alpha: 1) //3B4D4F
        
        
        // For default objects in app
        
        //static let navigationBar = UIColor.clear
        
        //static let barItem = UIColor.clear
        
        //static let viewController = UIColor.clear
        
        //static let tableViewController = UIColor.clear
        
        static let tableViewSeparator = UIColor(red: 199.range, green: 199.range, blue: 204.range, alpha: 1) //C7C7CC
    }
}

extension DBColor {
    
    static func get(color: String) -> UIColor {

        switch color.lowercased() {
        case "normal": return PokemonType.normal
        case "fighting": return PokemonType.fighting
        case "flying": return PokemonType.flying
        case "poison": return PokemonType.poison
        case "ground": return PokemonType.ground
        case "rock": return PokemonType.rock
        case "bug": return PokemonType.bug
        case "ghost": return PokemonType.ghost
        case "steel": return PokemonType.steel
        case "fire": return PokemonType.fire
        case "water": return PokemonType.water
        case "grass": return PokemonType.grass
        case "electric": return PokemonType.electric
        case "psychic": return PokemonType.psychic
        case "ice": return PokemonType.ice
        case "dragon": return PokemonType.dragon
        case "dark": return PokemonType.dark
        case "fairy": return PokemonType.fairy

        case "physical": return PokemonMove.physical
        case "special": return PokemonMove.special
        case "status": return PokemonMove.status
        case "zmove": return PokemonMove.zMove

        default: return PokemonType.unknown
        }
    }
}

private extension Int {
    
    /// Devided `self` by 255 to get RBG range 0-1.
    var range: CGFloat { return CGFloat(self / 255) }
}
