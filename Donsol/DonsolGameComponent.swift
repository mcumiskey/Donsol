//
//  DonsolGameComponent.swift
//  Donsol
//
//  Created by Miles Cumiskey on 11/5/22.
//
import ComposableArchitecture
import CoreGraphics

struct DonsolState: Equatable {
    var currentHealth: Int
    var currentShield: Int
    var shieldStrength: Int = 0
    var healthPotionSickness: Bool
    var room: [Card] = []
    
    var canEscape: Bool {
        (currentHealth > 0) && !room.contains(where: { !$0.isFlipped && $0.value.isMonster })
    }
    
    var isGameOver: Bool {
        currentHealth == 0
    }
    
    var healthPercent: CGFloat { (CGFloat(currentHealth) / CGFloat(22)) * 100.0 }
    var sheildPercent: CGFloat { (CGFloat(currentShield) / CGFloat(11)) * 100.0 }
}

enum DonsolAction: Equatable {
    case lowerHealth(damage: Int)
    case restoreHealth(healing: Int)
    case generateRoom
    case selectCard(CardValue)
}

struct DonsolEnviornment {
    var drawCard: () -> Card?
    
    static var live: DonsolEnviornment {
        var deck = Deck()
        deck.shuffleDeck()
        return .init(drawCard: { deck.drawCard() })
    }
    
    static var mock: DonsolEnviornment {
        DonsolEnviornment(drawCard: { nil })
    }
}

//closure donsoleReducer STORES the reducer function as a variable
var donsolReducer = Reducer<DonsolState, DonsolAction, DonsolEnviornment> { state, action, env in
    switch action {
        case .lowerHealth(let damage):
            //current health = currenthealth - (damage - sheild)
            state.currentHealth = state.currentHealth - max(0, damage - state.currentShield)
            if (damage >= state.shieldStrength) {
                state.shieldStrength = 0
                state.currentShield = 0
            }
            if(damage < state.shieldStrength){
                state.shieldStrength = damage
            }
            if (state.currentHealth <= 0) {
                state.currentHealth = 0
            }
            
            return .none
        case .restoreHealth(let healing):
            if (state.healthPotionSickness) {
                //cannot heal with health potion sickness!
            } else {
                if(state.currentHealth + healing >= 22) {
                    state.currentHealth = 22
                } else {
                    state.currentHealth = state.currentHealth + healing
                }
            }
            state.healthPotionSickness = true
            return .none
        case .generateRoom:
            state.room = (0..<4).compactMap { _ in env.drawCard() }
            return .none
            
        case .selectCard(let cardValue):
            state.room = state.room.map { c in
                guard c.value == cardValue else { return c }
                return Card(value: cardValue, isFlipped: true)
            }
            
            switch cardValue {
                case .heart(let num):
                    switch num {
                        case .ace, .jack, .queen, .king:
                            return Effect(value: .restoreHealth(healing: 11))
                        default:
                            return Effect(value: .restoreHealth(healing: num.rawValue))
                    }
                    
                case .diamond(let num):
                    switch num {
                        case .ace, .jack, .queen, .king:
                            state.currentShield = 11
                        default:
                            state.currentShield = num.rawValue
                    }
                    state.healthPotionSickness = false
                    state.shieldStrength = 21
                    return .none
                    
                case .spade(let num), .club(let num):
                    state.healthPotionSickness = false
                    switch num {
                        case .jack:
                            return Effect(value: .lowerHealth(damage: 11))
                        case .queen:
                            return Effect(value: .lowerHealth(damage: 13))
                        case .king:
                            return Effect(value: .lowerHealth(damage: 15))
                        case .ace:
                            return Effect(value: .lowerHealth(damage: 17))
                        default:
                            return Effect(value: .lowerHealth(damage: num.rawValue))
                    }
                    
                case .joker :
                    state.healthPotionSickness = false
                    return Effect(value: .lowerHealth(damage: 21))
                    
            }
    }
}

