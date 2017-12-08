//
//  Utilities.swift
//  PokedexApp
//
//  Created by Dara on 3/27/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

extension Int {
    
    func toPokedexId() -> String {
        
        return String(format: "#%03d", self)
    }
    
    func toProgress() -> Float {
        
        return (Float(exactly: self) ?? 0.0) / 200.0
    }
}
