//
//  Game.swift
//  Donsol
//
//  Created by Miles Cumiskey on 4/2/22.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    var max_health: Int = 21
    @Published var current_health: Int = 21
    var max_sheild: Int = 11
    @Published var current_sheild: Int = 0
    @Published var sheild_break: Int = 0
    
    @Published var canEscape: Bool
    
    @Published var deck = Deck()
    var lastCard: Card?
    
    @Published var gameOver: Bool
    
    var healthPercent: CGFloat { (CGFloat(current_health) / CGFloat(max_health)) * 100.0 }
    var sheildPercent: CGFloat { (CGFloat(current_sheild) / CGFloat(max_sheild)) * 100.0 }


    init() {
        max_health = 21
        current_health = 21
        max_sheild = 11
        current_sheild = 0
        canEscape = true
        gameOver = false
    }
    
    func lowerHealth (damage: Int) {

        current_health = current_health - max(0, damage - current_sheild)
        
        if(damage >= sheild_break){
            sheild_break = 0;
            current_sheild = 0;
        }
        
        if(current_health <= 0){
            gameOver = true
            current_health = 0
        }
    }
    
    func restoreHealth (life: Int) {
        if(current_health + life >= max_health) {
            current_health = max_health
        } else {
            current_health = current_health + life
        }
        
    }

    func selectCard(card: Card) {
        
        switch card {
        
        case .heart(let num):
            switch num {
                case .ace, .jack, .queen, .king:
                    restoreHealth(life: 11)
                default:
                    restoreHealth(life: num.rawValue)
                }
            
        case .diamond(let num) :
            switch num {
            case .ace, .jack, .queen, .king:
                current_sheild = max_sheild
            default:
                current_sheild = num.rawValue
            }


        case .spade(let num), .club(let num) :
            switch num {
            case .jack :
                lowerHealth(damage: 11)
                
            case .queen :
                lowerHealth(damage: 13)

            case .king :
                lowerHealth(damage: 15)
                
            case .ace :
                lowerHealth(damage: 17)

            default :
                lowerHealth(damage: num.rawValue)

            }
        case .joker :
            lowerHealth(damage: 21)
        }
        
        lastCard = card
    }
}


struct Deck {
    var deck: [Card]

    init() {
        deck = [
            .heart(.ace),
            .heart(.two),
            .heart(.three),
            .heart(.four),
            .heart(.five),
            .heart(.seven),
            .heart(.eight),
            .heart(.nine),
            .heart(.ten),
            .heart(.jack),
            .heart(.queen),
            .heart(.king),

            .diamond(.ace),
            .diamond(.two),
            .diamond(.three),
            .diamond(.four),
            .diamond(.five),
            .diamond(.seven),
            .diamond(.eight),
            .diamond(.nine),
            .diamond(.ten),
            .diamond(.jack),
            .diamond(.queen),
            .diamond(.king),

            .spade(.ace),
            .spade(.two),
            .spade(.three),
            .spade(.four),
            .spade(.five),
            .spade(.seven),
            .spade(.eight),
            .spade(.nine),
            .spade(.ten),
            .spade(.jack),
            .spade(.queen),
            .spade(.king),

            .club(.ace),
            .club(.two),
            .club(.three),
            .club(.four),
            .club(.five),
            .club(.seven),
            .club(.eight),
            .club(.nine),
            .club(.ten),
            .club(.jack),
            .club(.queen),
            .club(.king),

            .joker(.blue),
            .joker(.red)
        ]
        deck.shuffle()
    }

    func listDeck() {
        for card in deck {
            print(card.cardDescription)
        }
    }

    func deckSize() -> Int {
        return deck.count
    }

    mutating func drawCard() -> Card {
        return deck[1]
    }

    mutating func addCard(card: Card) {
        deck.append(card)
    }
}


