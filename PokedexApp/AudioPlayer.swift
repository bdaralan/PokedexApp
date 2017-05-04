//
//  AudioPlayer.swift
//  PokedexApp
//
//  Created by Dara on 5/3/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import AVFoundation

class AudioPlayer {
    
    private var player = AVAudioPlayer()
    
    private var soundEffectIsOn: Bool {
        return UserDefaults.standard.bool(forKey: KEYS.Setting.soundEffectSwitchState)
    }
    
    var setting: AVAudioPlayer {
        set { player = newValue }
        get { return player }
    }
    
    func play(audio: String, ofType type: String = "m4a", forcePlay: Bool = false) {
        
        if forcePlay || soundEffectIsOn {
            if let path = Bundle.main.path(forResource: audio, ofType: type) {
                do {
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                } catch { print(error) }
                
                player.prepareToPlay()
                player.play()
                
            } else {
                self.play(audio: .error)
            }
        }
    }
    
    func play(audio: AudioFile, forcePlay: Bool = false) {
        
        if forcePlay || soundEffectIsOn {
            if let path = Bundle.main.path(forResource: audio.rawValue, ofType: "m4a") {
                do {
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                } catch { print(error) }
            }
            
            player.prepareToPlay()
            player.play()
        }
    }
}


enum AudioFile: String {
    case error = "error"
    case openPC = "open-pc"
    case save = "save"
    case select = "select"
}
