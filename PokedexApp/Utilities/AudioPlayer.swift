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
    }
    
    static let error = load(resourceAudio: .error)
    
    static let openPC = load(resourceAudio: .openPC)
    
    static let save = load(resourceAudio: .save)
    
    static let select = load(resourceAudio: .select)
    
    static var isSoundEffectSettingOn: Bool { return UserDefaults.standard.bool(forKey: Constant.Key.Setting.soundEffectSwitchState) }
    
    static var mainPlayer: AVAudioPlayer!
    
    static func play(audio: ResourceAudioFile) {
        
        if isSoundEffectSettingOn || audio == .save {
            switch audio {
            case .select: mainPlayer = select
            case .openPC: mainPlayer = openPC
            case .save: mainPlayer = save
            case .error: mainPlayer = error
            }
            mainPlayer.prepareToPlay()
            mainPlayer.play()
        }
    }
    
    static func play(audio: String, ofType type: String) {
        
        guard isSoundEffectSettingOn, let path = Bundle.main.path(forResource: audio, ofType: type) else { return }
        do {
            mainPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print(error.localizedDescription)
            mainPlayer = AudioPlayer.error
        }
        mainPlayer.prepareToPlay()
        mainPlayer.play()
    }
    
    static func load(resourceAudio: ResourceAudioFile) -> AVAudioPlayer {
        
        do {
            let audioUrl = URL(fileReferenceLiteralResourceName: resourceAudio.rawValue)
            let audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            return audioPlayer
        } catch {
            print(error.localizedDescription)
            return AVAudioPlayer()
        }
    }
}
