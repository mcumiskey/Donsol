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
    
    @Published var canEscape: Bool
    
    @Published var drawPile = Deck()
    @Published var currentRoom: [Card]
    @Published var discardPile: [Card]
    @Published var lastCard: Card?
    
    var healthPercent: CGFloat { (CGFloat(current_health) / CGFloat(max_health)) * 100.0 }
    var sheildPercent: CGFloat { (CGFloat(current_sheild) / CGFloat(max_sheild)) * 100.0 }


    init() {
        max_health = 21
        current_health = 21
        max_sheild = 11
        current_sheild = 0
        canEscape = true
        currentRoom = []
        discardPile = [] //empty array
    }
    
    func lowerHealth () {
        current_health -= 1
    }
    
    func selectCard(curCard: Card) {
        switch curCard {
        //restore health
        case .heart(let num):
            if case .heart = lastCard {
                // no healing
            } else {
                if num == .ace, num == .jack, num == .queen, num == .king {
                    if(current_health + 11 >= max_health) {
                        current_health = max_health
                    } else {
                        current_health = current_health + 11
                    }
                } else {
                if(current_health + num.rawValue >= max_health) {
                        current_health = max_health
                    } else {
                        current_health = current_health + num.rawValue
                    }
                }
            }
            
        case .diamond(let num) :
            if num == .ace,
               num == .jack,
               num == .queen,
               num == .king {
                current_sheild = max_sheild
            } else {
                current_sheild = num.rawValue
            }

        case .spade(let num), .club(let num) :
            if num == .jack {
                current_health -= 11
            }
            if num == .queen {
                current_health -= 13
            }
            if num == .king {
                current_health -= 15
            }
            if num == .ace {
                current_health -= 17
            } else {
                //current_health -= num.rawValue
            }
        case .joker :
            current_health -= 21
        }
    }
    
}

