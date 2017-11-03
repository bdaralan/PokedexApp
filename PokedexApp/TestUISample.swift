//
//  TestUISample.swift
//  PokedexApp
//
//  Created by Dara on 11/2/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

struct TestUISample {
    
    public static func testPokemonDefenseView() {
        guard let window = UIApplication.shared.keyWindow else { print("TestUISample Fail to run"); return }
        let pokemonDefView = PokemonDefenseView()
        pokemonDefView.typeLabel.text = "Grass"
        pokemonDefView.effectiveSlider.value = 0.8
        
        let view = UIView(frame: window.frame)
        view.backgroundColor = UIColor.lightGray
        window.addSubview(view)
        view.addSubview(pokemonDefView)
        pokemonDefView.frame.size.width = 320
        pokemonDefView.layer.borderWidth = 1
        pokemonDefView.layer.borderColor = UIColor.blue.cgColor
        pokemonDefView.center = view.center
    }
}
