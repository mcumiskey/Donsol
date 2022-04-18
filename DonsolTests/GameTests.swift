//
//  GameTests.swift
//  DonsolTests
//
//  Created by Miles Cumiskey on 4/17/22.
//

@testable import Donsol
import XCTest


final class GameTests: XCTestCase {
    func testLowerHealth() {
        //usually 3 phasees, setup, eecute, and assserrtt
        //in a test we need to create a system to test
        //create an instance of game
        //execute functions of game
        //assert stuff about what has happened
        let game = Game()
        game.lowerHealth(damage: 1)
        XCTAssert(game.current_health == 20)
    }
    func testLowerHealth_lowerBelowZero {

        let game = Game()
        game.lowerHealth(damage: 22)
        XCTAssert(game.gameOver == true)
        XCTAssert(game.current_health == 0)
    }
}
