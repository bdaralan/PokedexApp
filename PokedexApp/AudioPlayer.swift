//
//  AudioPlayer.swift
//  PokedexApp
//
//  Created by Dara on 5/3/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import AVFoundation

struct AudioPlayer {
    
    enum ResourceAudioFile: String {
        case error = "error.m4a"
        case openPC = "open-pc.m4a"
        case save = "save.m4a"
        case select = "select.m4a"
        
        var fileName: String { return rawValue.components(separatedBy: ".")[0] }
        var fileType: String { return rawValue.components(separatedBy: ".")[1] }
    }
    
    /// The main audio player
    static private var player = AVAudioPlayer()
    
    static let error = load(resource: .error)
    
    static let openPC = load(resource: .openPC)
    
    static let save = load(resource: .save)
    
    static let select = load(resource: .select)
    
    static var isSoundEffectSettingOn: Bool {
        return UserDefaults.standard.bool(forKey: Constant.Key.Setting.soundEffectSwitchState)
    }
    
    static func play(audio: ResourceAudioFile) {
        guard isSoundEffectSettingOn || audio == .save else { return }
        switch audio {
        case .select: player = select
        case .openPC: player = openPC
        case .save: player = save
        case .error: player = error
        }
        player.prepareToPlay()
        player.play()
    }
    
    static func play(audio: String, ofType type: String) {
        guard isSoundEffectSettingOn else { return }
        player = error // default to error in case of fail try or no file
        if let path = Bundle.main.path(forResource: audio, ofType: type) {
            do {
                let url = URL(fileURLWithPath: path)
                let pokemonCry = try AVAudioPlayer(contentsOf: url)
                player = pokemonCry
            } catch {
                print(error.localizedDescription)
            }
        }
        player.prepareToPlay()
        player.play()
    }
    
    static func load(resource: ResourceAudioFile) -> AVAudioPlayer {
        guard let path = Bundle.main.path(forResource: resource.fileName, ofType: resource.fileType) else { return AVAudioPlayer() }
        do {
            let audioUrl = URL(fileURLWithPath: path)
            let audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            return audioPlayer
        } catch {
            print(error.localizedDescription)
            return AVAudioPlayer()
        }
    }
}
