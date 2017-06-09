//
//  AudioPlayer.swift
//  PokedexApp
//
//  Created by Dara on 5/3/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import AVFoundation

class AudioPlayer {
    
    private var pokemonCry: AVAudioPlayer!
    
    private let error = AVAudioPlayer(resourceAudio: AVAudioPlayer.ResourceAudioFile.error)
    
    private let openPC = AVAudioPlayer(resourceAudio: AVAudioPlayer.ResourceAudioFile.openPC)
    
    private let save = AVAudioPlayer(resourceAudio: AVAudioPlayer.ResourceAudioFile.save)
    
    private let select = AVAudioPlayer(resourceAudio: AVAudioPlayer.ResourceAudioFile.select)
    
    private var isSoundEffectSettingOn: Bool {
        
        return UserDefaults.standard.bool(forKey: Constant.Key.Setting.soundEffectSwitchState)
    }
    
    
    
    func play(audio: AVAudioPlayer.ResourceAudioFile) {
        
        if isSoundEffectSettingOn || audio == .save {
            
            switch audio {
                
            case .select:
                select.prepareToPlay()
                select.play()
                
            case .openPC:
                openPC.prepareToPlay()
                openPC.play()
                
            case .save:
                save.prepareToPlay()
                save.play()
                
            case .error:
                error.prepareToPlay()
                error.play()
            }
        }
    }
    
    func play(audio: String, ofType type: String) {
        
        guard isSoundEffectSettingOn, let path = Bundle.main.path(forResource: audio, ofType: type) else { return }
        
        do { pokemonCry = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) }
        catch { print(error) }
        
        pokemonCry.prepareToPlay()
        pokemonCry.play()
        
    }
}
