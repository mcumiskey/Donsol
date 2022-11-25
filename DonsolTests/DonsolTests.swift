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
    func testLowerHealth() {
        let store = TestStore(
            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: false),
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
            initialState: DonsolState(currentHealth: 5, currentShield: 0, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        
        store.assert(
            .send(.restoreHealth(healing: 1)){
                $0.currentHealth = 6
                $0.healthPotionSickness = true
            }
        )
    }
    
    func testRestoreHealthWithSickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 5, currentShield: 0, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: .mock
        )
        
        store.send(.restoreHealth(healing: 1))
    }
    
    func testGenerateRoom(){
        var cards: [Card] = []
        var deck = Deck()
        let store = TestStore (
            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: true),
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
    
    
    func testSelectCardHeartNOTflippedNOsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 20, currentShield: 0, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.heart(.two)))
        store.receive(.restoreHealth(healing: 2)) {
            $0.currentHealth = 22
            $0.healthPotionSickness = true
        }
    }
    
    func testSelectCardHeartNOTflippedYESsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 20, currentShield: 0, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.heart(.two)))
        store.receive(.restoreHealth(healing: 2))
    }

    func testSelectCardDiamondNOTflippedNOsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 20, currentShield: 0, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.diamond(.two))) {
            $0.currentShield = 2
            $0.shieldStrength = 21
        }
    }
    
    func testSelectCardDiamondNOTflippedYESsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 20, currentShield: 0, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.diamond(.two))) {
            $0.currentShield = 2
            $0.healthPotionSickness = false
            $0.shieldStrength = 21

        }
    }
    
    func testSelectCardDiamondNOTflippedNOsicknessWithCurSheild(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 20, currentShield: 11, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.diamond(.two))) {
            $0.currentShield = 2
            $0.shieldStrength = 21
        }
    }
    
    func testSelectCardClubNOTflippedNOsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: false),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.club(.two)))
        store.receive(.lowerHealth(damage: 2)) {
            $0.currentHealth = 20
            $0.shieldStrength = 21
        }
    }
    
    func testSelectCardClubNOTflippedYESsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.club(.two))){
            $0.healthPotionSickness = false
        }
        store.receive(.lowerHealth(damage: 2)) {
            $0.currentHealth = 20
        }
    }
    
    func testSelectCardJokerNOTflippedYESsickness(){
        let store = TestStore (
            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: true),
            reducer: donsolReducer,
            environment: .mock
        )
        store.send(.selectCard(CardValue.joker(.red))){
            $0.healthPotionSickness = false
        }
        store.receive(.lowerHealth(damage: 21)) {
            $0.currentHealth = 1
        }
    }

}
