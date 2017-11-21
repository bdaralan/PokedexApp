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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitilizes() {
        // check if all data are parsed
        PokeData.initializes()
        XCTAssertNotNil(PokeData.pokemonJson)
        XCTAssertNotNil(PokeData.pokemonEvolutionTreeJson)
        XCTAssertNotNil(PokeData.pokemonMegaEvolutionJson)
        XCTAssertNotNil(PokeData.pokemonMap)
        
        // check if any data missing
        let pokemonJsonKeyCount = PokeData.pokemonJson.keys.count
        let pokemonMegaEvolutionKeyCount = PokeData.pokemonMegaEvolutionJson.keys.count
        let allPokemonKeyCount = pokemonJsonKeyCount + pokemonMegaEvolutionKeyCount
        let allPokemonMapKeyCount = PokeData.pokemonMap.keys.count
        XCTAssertEqual(allPokemonKeyCount, allPokemonMapKeyCount)
    }
}
