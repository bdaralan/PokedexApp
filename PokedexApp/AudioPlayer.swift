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
    
    private let cache = NSCache<AnyObject, AnyObject>()
    
    private var soundEffectIsOn: Bool {
        return UserDefaults.standard.bool(forKey: CONSTANTS.keys.setting.soundEffectSwitchState)
    }
    
    var setting: AVAudioPlayer {
        set { player = newValue }
        get { return player }
    }
    
    
    init() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch { print(error) }
    }
    
    
    func play(audio: String, ofType type: String = "m4a", forcePlay: Bool = false) {
        
        let cacheKey = "\(audio).\(type)"
        
        DispatchQueue.main.async {
            if self.soundEffectIsOn || forcePlay {
                if let cachedPlayer = self.cache.object(forKey: cacheKey as AnyObject) as? AVAudioPlayer {
                    self.player = cachedPlayer
                    self.player.prepareToPlay()
                    self.player.play()
                } else {
                    if let path = Bundle.main.path(forResource: audio, ofType: type) {
                        do {
                            self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                        } catch { print(error) }
                        
                        self.player.prepareToPlay()
                        self.player.play()
                        
                    } else {
                        self.play(audio: .error)
                    }
                }
            }
        }
    }
    
    func play(audio: AudioFile, forcePlay: Bool = false) {
        
        let cacheKey = "\(audio.rawValue).m4a"
        
        DispatchQueue.main.async {
            if self.soundEffectIsOn || forcePlay {
                if let cachedAudio = self.cache.object(forKey: cacheKey as AnyObject) as? AVAudioPlayer {
                    self.player = cachedAudio
                } else if let path = Bundle.main.path(forResource: audio.rawValue, ofType: "m4a") {
                    do {
                        let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                        self.cache.setObject(player, forKey: audio.rawValue as AnyObject)
                        self.player = player
                    } catch { print(error) }
                }
                
                self.player.prepareToPlay()
                self.player.play()
            }
        }
    }
}


enum AudioFile: String {
    case error = "error"
    case openPC = "open-pc"
    case save = "save"
    case select = "select"
}
