//
//  AudioPlayer.swift
//  PokedexApp
//
//  Created by Dara on 5/3/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import AVFoundation

class PokeAudioPlayer {
    
    enum PokeSoundEffect: String {
        case error = "error.m4a"
        case openPC = "open-pc.m4a"
        case save = "save.m4a"
        case select = "select.m4a"
        
        var fileName: String { return rawValue.components(separatedBy: ".")[0] }
        var fileType: String { return rawValue.components(separatedBy: ".")[1] }
    }
    
    /** Audio player singleton. */
    private static var pokeAudioPlayerInstance = PokeAudioPlayer()
    
    /** `AudioPlayer` instance. */
    static var instance: PokeAudioPlayer { return pokeAudioPlayerInstance }
    
    /** The main player used to play audio. */
    var mainPlayer = AVAudioPlayer()
    
    static let errorPlayer = load(audio: PokeSoundEffect.error.fileName, ofType: PokeSoundEffect.error.fileType)
    
    static let openPCPlayer = load(audio: PokeSoundEffect.openPC.fileName, ofType: PokeSoundEffect.openPC.fileType)
    
    static let savePlayer = load(audio: PokeSoundEffect.save.fileName, ofType: PokeSoundEffect.save.fileType)
    
    static let selectPlayer = load(audio: PokeSoundEffect.select.fileName, ofType: PokeSoundEffect.select.fileType)
    
    static var isSoundEffectSettingOn: Bool {
        return UserDefaults.standard.bool(forKey: Constant.Key.Setting.soundEffectSwitchState)
    }
    
    func play(soundEffect: PokeSoundEffect) {
        guard PokeAudioPlayer.isSoundEffectSettingOn || soundEffect == .save else { return }
        switch soundEffect {
        case .select: mainPlayer = PokeAudioPlayer.selectPlayer
        case .openPC: mainPlayer = PokeAudioPlayer.openPCPlayer
        case .save: mainPlayer = PokeAudioPlayer.savePlayer
        case .error: mainPlayer = PokeAudioPlayer.errorPlayer
        }
        mainPlayer.prepareToPlay()
        mainPlayer.play()
    }
    
    func play(audio: String, ofType type: String) {
        guard PokeAudioPlayer.isSoundEffectSettingOn else { return }
        mainPlayer = PokeAudioPlayer.load(audio: audio, ofType: type)
        mainPlayer.prepareToPlay()
        mainPlayer.play()
    }
    
    static func load(audio: String, ofType type: String) -> AVAudioPlayer {
        guard let path = Bundle.main.path(forResource: audio, ofType: type) else { return AVAudioPlayer() }
        do {
            let audioUrl = URL(fileURLWithPath: path)
            let audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            return audioPlayer
        } catch {
            print(error.localizedDescription)
            print("PokeAudioPlayer fail to load audio \(audio).\(type)!!")
            return AVAudioPlayer()
        }
    }
}
