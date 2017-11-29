//
//  PokeDataTests.swift
//  PokedexAppTests
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import XCTest
@testable import PokedexApp

class PokeDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitilizes() {
        // check if all data are parsed
        PokeData.initializes()
        XCTAssertNotNil(PokeData.instance.pokemonJson)
        XCTAssertNotNil(PokeData.instance.pokemonEvolutionTreeJson)
        XCTAssertNotNil(PokeData.instance.pokemonMegaEvolutionJson)
        XCTAssertNotNil(PokeData.instance.pokemonMap)
        
        // check if any data missing
        let pokemonJsonKeyCount = PokeData.instance.pokemonJson.keys.count
        let pokemonMegaEvolutionKeyCount = PokeData.instance.pokemonMegaEvolutionJson.keys.count
        let allPokemonKeyCount = pokemonJsonKeyCount + pokemonMegaEvolutionKeyCount
        let allPokemonMapKeyCount = PokeData.instance.pokemonMap.keys.count
        XCTAssertEqual(allPokemonKeyCount, allPokemonMapKeyCount)
    }
}
