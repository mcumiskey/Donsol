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
}

