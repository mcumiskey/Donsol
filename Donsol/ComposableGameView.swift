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
                    Text("This is a game about surviving a dungeon made of 54 playing cards.")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(30.0)
                        .border(Color.white, width: 1)
                    
                    ComposableHealthView(store: self.store)
                        .frame(height: 14)
                    ComposableSheildView(store: self.store)
                        .frame(height: 14)
                    
                    //
                    //                ComposableCardView(card: Card(value: .heart(.ace), isFlipped: false), store: self.store)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(viewStore.room) { card in
                            ComposableCardView(card: card, store: self.store)
                        }
                    }
                }
                .setBackground()
                .navigationTitle("Donsol")
                .navigationBarItems(leading: Button("Main Menu") { })
                .onAppear {
                    viewStore.send(.generateRoom)
                }
            }
        }
    }
}

struct ComposableGameView_Previews: PreviewProvider {
    static var previews: some View {
        ComposableGameView(
            store: Store(
                initialState: DonsolState(currentHealth: 22,
                                          healthPotionSickness: false),
                reducer: donsolReducer,
                environment: .live
            )
        )
    }
}
