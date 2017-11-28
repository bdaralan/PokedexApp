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
        
        static let normal = UIColor(red: 168.rgbRange, green: 168.rgbRange, blue: 120.rgbRange, alpha: 1) //A8A878
        
        static let fighting = UIColor(red: 192.rgbRange, green: 48.rgbRange, blue: 40.rgbRange, alpha: 1) //C03028
        
        static let flying = UIColor(red: 168.rgbRange, green: 144.rgbRange, blue: 240.rgbRange, alpha: 1) //A890F0
        
        static let poison = UIColor(red: 160.rgbRange, green: 64.rgbRange, blue: 160.rgbRange, alpha: 1) //A040A0
        
        static let ground = UIColor(red: 224.rgbRange, green: 192.rgbRange, blue: 104.rgbRange, alpha: 1) //E0C068
        
        static let rock = UIColor(red: 184.rgbRange, green: 160.rgbRange, blue: 56.rgbRange, alpha: 1) //B8A038
        
        static let bug = UIColor(red: 168.rgbRange, green: 184.rgbRange, blue: 32.rgbRange, alpha: 1) //A8B820
        
        static let ghost = UIColor(red: 112.rgbRange, green: 88.rgbRange, blue: 152.rgbRange, alpha: 1) //705898
        
        static let steel = UIColor(red: 184.rgbRange, green: 184.rgbRange, blue: 208.rgbRange, alpha: 1) //B8B8D0
        
        static let fire = UIColor(red: 240.rgbRange, green: 128.rgbRange, blue: 48.rgbRange, alpha: 1) //F08030
        
        static let water = UIColor(red: 104.rgbRange, green: 144.rgbRange, blue: 240.rgbRange, alpha: 1) //6890F0
        
        static let grass = UIColor(red: 120.rgbRange, green: 200.rgbRange, blue: 80.rgbRange, alpha: 1) //78C850
        
        static let electric = UIColor(red: 248.rgbRange, green: 208.rgbRange, blue: 48.rgbRange, alpha: 1) //F8D030
        
        static let psychic = UIColor(red: 248.rgbRange, green: 88.rgbRange, blue: 136.rgbRange, alpha: 1) //F85888
        
        static let ice = UIColor(red: 152.rgbRange, green: 216.rgbRange, blue: 261.rgbRange, alpha: 1) //98D8D8
        
        static let dragon = UIColor(red: 112.rgbRange, green: 56.rgbRange, blue: 248.rgbRange, alpha: 1) //7038F8
        
        static let dark = UIColor(red: 112.rgbRange, green: 88.rgbRange, blue: 72.rgbRange, alpha: 1) //705848
        
        static let fairy = UIColor(red: 238.rgbRange, green: 153.rgbRange, blue: 172.rgbRange, alpha: 1) //EE99AC
        
        static let unknown = UIColor(red: 104.rgbRange, green: 160.rgbRange, blue: 144.rgbRange, alpha: 1) //68A090
    }
    
    /// Pokemon move color
    struct PokemonMove {
        
        static let physical = UIColor(red: 255.rgbRange, green: 69.rgbRange, blue: 0.rgbRange, alpha: 1) //FF4500
        
        static let special = UIColor(red: 34.rgbRange, green: 102.rgbRange, blue: 204.rgbRange, alpha: 1) //2266CC
        
        static let status = UIColor(red: 153.rgbRange, green: 153.rgbRange, blue: 153.rgbRange, alpha: 1) //999999
        
        static let zMove = UIColor(red: 250.rgbRange, green: 202.rgbRange, blue: 13.rgbRange, alpha: 1) //FACA0D
    }
    
    /// Pokemon stats color
    
    struct PokemonStat {
        
        static let hp = UIColor(red: 120.rgbRange, green: 200.rgbRange, blue: 80.rgbRange, alpha: 1) // 78C850
        
        static let attack = UIColor(red: 233.rgbRange, green: 64.rgbRange, blue: 3.rgbRange, alpha: 1) // E94003
        
        static let defense = UIColor(red: 176.rgbRange, green: 48.rgbRange, blue: 0, alpha: 1) // B03000
        
        static let spAttack = UIColor(red: 34.rgbRange, green: 102.rgbRange, blue: 204.rgbRange, alpha: 1) // 2266CC
        
        static let spDefense = UIColor(red: 17.rgbRange, green: 55.rgbRange, blue: 112.rgbRange, alpha: 1) //B3770
        
        static let speed = UIColor(red: 249.rgbRange, green: 201.rgbRange, blue: 14.rgbRange, alpha: 1) // F9C90E
    }
    
    struct PokemonMeasurement {
        
        static let weight = UIColor(red: 231.rgbRange, green: 73.rgbRange, blue: 130.rgbRange, alpha: 1) // E74982
        
        static let height = UIColor(red: 103.rgbRange, green: 217.rgbRange, blue: 215.rgbRange, alpha: 1) // 67D9D7
    }
    
    /// App object color
    struct AppObject {
        
        // For custom objects in app
        
        static let sectionBackground = UIColor(red: 199.rgbRange, green: 222.rgbRange, blue: 217.rgbRange, alpha: 0.7) //C7DED9
        
        static let sectionText = UIColor(red: 59.rgbRange, green: 77.rgbRange, blue: 79.rgbRange, alpha: 1) //3B4D4F
        
        static let tableViewSeparator = UIColor(red: 199.rgbRange, green: 199.rgbRange, blue: 204.rgbRange, alpha: 1) //C7C7CC
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
        case "unknow": return PokemonType.unknown

        case "physical": return PokemonMove.physical
        case "special": return PokemonMove.special
        case "status": return PokemonMove.status
        case "zmove": return PokemonMove.zMove

        default: return UIColor.clear
        }
    }
}

private extension Int {
    
    /// Devided `self` by 255 to get RBG range `0-1`.
    var rgbRange: CGFloat { return CGFloat(self) / 255 }
}
