//
//  Game.swift
//  Donsol
//
//  Created by Miles Cumiskey on 4/2/22.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    @Published var current_health: Int = 22
    @Published var current_sheild: Int = 0
    @Published var sheild_break: Int = 0
    
    //flow controls
    @Published var canEscape: Bool
    @Published var gameOver: Bool
    @Published var healthPotionSickness: Bool
    
    
    
    @Published var deck = Deck()
    
    var room: [Card] = [] // 1-4 cards representing the active room
    
    var healthPercent: CGFloat { (CGFloat(current_health) / CGFloat(22)) * 100.0 }
    var sheildPercent: CGFloat { (CGFloat(current_sheild) / CGFloat(11)) * 100.0 }
    
    
    init() {
        current_health = 22
        current_sheild = 0
        canEscape = false
        gameOver = false
        healthPotionSickness = false
        generateRoom()
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
    
    func restoreHealth (healing: Int) {
        if(healthPotionSickness){
            //cannot heal with health potion sickness!
        } else {
            if(current_health + healing >= 22) {
                current_health = 22
            } else {
                current_health = current_health + healing
            }
        }
    }
    
    func generateRoom () {
        room = (0..<4).compactMap { _ in deck.drawCard()}
        canEscape = false
    }
    
    func checkRoom () {
        //we want to check if all four cards are flipped
        //all flipped = go to next room
        
        //if not all are flipped, check to see if any are jokers, clubs, or spades
        //if there are any, cannot progress to next room
        
        for card in room {
            if(card.isFlipped == true) {
                //do nothing
            } else {
                switch card.value {
                case .heart(_), .diamond(_) :
                    canEscape = true
                case .spade(_), .club(_), .joker(_) :
                    canEscape = false
                }
            }
        }
    }
    
    
    func selectCard(card: CardValue) {
        
        // flip the card
        room = room.map { c in
            guard c.value == card else { return c }
            return Card(value: card, isFlipped: true)
        }
        
        switch card {
        case .heart(let num):
            
            switch num {
    
            case .ace, .jack, .queen, .king:
                restoreHealth(healing: 11)
                
            default:
                restoreHealth(healing: num.rawValue)
            }
            healthPotionSickness = true
            
            
        case .diamond(let num) :
            switch num {
            case .ace, .jack, .queen, .king:
                current_sheild = 11
            default:
                current_sheild = num.rawValue
            }
            healthPotionSickness = false
            sheild_break = 0

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
            healthPotionSickness = false
            sheild_break = num.rawValue
            
        case .joker :
            lowerHealth(damage: 21)
            healthPotionSickness = false
            
        }
        checkRoom()
    }
    
}

