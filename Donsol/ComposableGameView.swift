//
//  ComposableGameView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 11/6/22.
//

import SwiftUI
import ComposableArchitecture


struct ComposableGameView: View {
    let store: Store<DonsolState, DonsolAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                VStack {
                    if(!viewStore.isGameOver) {
                        VStack {
                            ComposableShieldStrengthView(shieldStrength: viewStore.shieldStrength)
                            
                            HealthBar(maxValue: 22, curValue: viewStore.currentHealth, percent: viewStore.healthPercent)
                            
                            SheildBar(maxValue: 11, curValue: viewStore.currentShield, percent: viewStore.sheildPercent)
                                                        
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(viewStore.room) { card in
                                    ComposableCardView(card: card) { card in
                                        viewStore.send(.selectCard(card.value))
                                    }
                                }.padding(10)
                            }
                        }
                        .padding(20)
                        
                        if(viewStore.canEscape) {
                            if(viewStore.room.isEmpty) {
                                Button(action: { viewStore.send(.generateRoom) }) {
                                    Text("Draw Cards")
                                        .frame(width: 100, height: 50, alignment: .center)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(15)
                                }
                            }
                            Button(action: { viewStore.send(.generateRoom) }) {
                                Text("Next Room")
                                    .frame(width: 100, height: 50, alignment: .center)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                .setBackground()

            }
        }
    }
}

struct ComposableGameView_Previews: PreviewProvider {
    static var previews: some View {
        ComposableGameView(
            store: Store(
                initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: false),
                reducer: donsolReducer,
                environment: .live
            )
        )
    }
}
