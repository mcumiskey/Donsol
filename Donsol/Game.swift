//
//  Game.swift
//  Donsol
//
//  Created by Miles Cumiskey on 4/2/22.
//

import Foundation
import SwiftUI

struct RoomCard {
    var card: Card
    var isFlipped: Bool = false
    
    mutating func flipCard () {
        isFlipped.toggle()
    }
}

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
    
    func generateRoom () {
    }
    
    func generateRoom (topRight: Card, topLeft: Card, bottomRight: Card, bottomLeft: Card) {
        var card2 = RoomCard(card: topRight, isFlipped: false)
                
    }
    
    
    func selectCard(card: Card) {
        switch card {
        
        case .heart(let num):
            switch num {
                case .ace, .jack, .queen, .king:
                    if(current_health + 11 >= max_health) {
                        current_health = max_health
                    } else {
                        current_health = current_health + 11
                    }
                    
                default:
                    if(current_health + num.rawValue >= max_health) {
                        current_health = max_health
                    } else {
                        current_health = current_health + num.rawValue
                    }
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
    }
    
}

