//
//  MainMenuView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 11/24/22.
//

import SwiftUI
import ComposableArchitecture

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            VStack {
                BaseInstructionView()
                NavigationLink(
                    destination: ComposableGameView(
                        store: Store(
                            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: false),
                            reducer: donsolReducer,
                            environment: .live
                        )
                    ), label: { Text("Start Game") }
                )
                
                NavigationLink(
                    destination: TutorialView(), label: { Text("How to Play") }
                )
            }
        }
    }
}

struct BaseInstructionView: View {
    
    var body: some View {
        
        VStack{
            Text("Donsol, designed by John Eternal, is a card game about exploring a dungeon made of a standard 54 poker card set.")
                 
            Text("A standard deck, jokers included, is a dungeon. Shuffle the deck and draw 4 cards, display them before you, this is a room. A room ends when all the cards are folded.")
            
                 Text("♦ Diamonds are shields")
                 Text("♥ ︎Hearts are potions")
                 Text("♠ Spades are monsters")
                 Text("♣ ︎Clubs are also monsters")
        } .padding(30)

            
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
