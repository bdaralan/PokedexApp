//
//  AVAudioPlayerExtension.swift
//  PokedexApp
//
//  Created by Dara on 6/8/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import AVFoundation

extension AVAudioPlayer {
    
    enum ResourceAudioFile: String {
        case error = "error.m4a"
        case openPC = "open-pc.m4a"
        case save = "save.m4a"
        case select = "select.m4a"
    }
    
    
    
    convenience init(resourceAudio: ResourceAudioFile) {
        
        let fileString = resourceAudio.rawValue.components(separatedBy: ".")
        let resource = fileString[0]
        let type = fileString[1]
        
        if let path = Bundle.main.path(forResource: resource, ofType: type) {
            do { try self.init(contentsOf: URL(fileURLWithPath: path)) }
            catch { print(error) }
        
        } else {
            print("Failed to init(resourceAudio: \(fileString). Cannot find \(fileString) in main bundle)")
            self.init()
        }
    }
}
