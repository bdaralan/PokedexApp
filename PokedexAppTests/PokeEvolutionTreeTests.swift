//
//  PokeEvolutionTreeTests.swift
//  PokedexAppTests
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import XCTest
@testable import PokedexApp

class PokeEvolutionTreeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        PokeData.initializes()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPokemonNodesEvolutionStage() {
        let raltsTree = PokeEvolutionTree(baseId: 280) // Ralts
        XCTAssertEqual(raltsTree.pokemonNodes(evolutionStage: .first).count, 1) // [Ralts]
        XCTAssertEqual(raltsTree.pokemonNodes(evolutionStage: .second).count, 1) // [Kirlia]
        XCTAssertEqual(raltsTree.pokemonNodes(evolutionStage: .third).count, 2) // [Gardevoir, Gallade]
        
        let eeveeTree = PokeEvolutionTree(baseId: 133) // Eevee
        XCTAssertEqual(eeveeTree.pokemonNodes(evolutionStage: .first).count, 1) // [Eevee]
        XCTAssertEqual(eeveeTree.pokemonNodes(evolutionStage: .second).count, 8) // [all eevee'eon]
        XCTAssertEqual(eeveeTree.pokemonNodes(evolutionStage: .third).count, 0) // []
    }
}
