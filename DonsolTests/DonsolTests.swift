//
//  DonsolTests.swift
//  DonsolTests
//
//  Created by Miles Cumiskey on 4/17/22.
//

import XCTest
import ComposableArchitecture
@testable import Donsol

class DonsolTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLowerHealth() {
        let store = TestStore(
            initialState: DonsolState(currentHealth: 22, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        
        store.assert(
            .send(.lowerHealth(damage: 1)){
                $0.currentHealth = 21
            }
        )
    }
    
    func testRestoreHealthNoSickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 5, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        
        store.assert(
            .send(.restoreHealth(healing: 1)){
                $0.currentHealth = 6
            }
        )
    }
    
    func testRestoreHealthWithSickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 5, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: .mock
        )
        
        store.send(.restoreHealth(healing: 1))
    }
    
    func testGenerateRoom(){
        var cards: [Card] = []
        var deck = Deck()
        let store = TestStore (
            initialState: DonsolState(currentHealth: 22, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: DonsolEnviornment(
                drawCard: {
                    let card = deck.drawCard()
                    if let card = card {
                        cards.append(card)
                    }
                    return card
                }
            )
        )
        store.send(.generateRoom) {
            $0.room = cards
        }
    }
    


}
