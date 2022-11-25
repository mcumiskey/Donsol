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
                NavigationLink(
                    destination: ComposableGameView(
                        store: Store(
                            initialState: DonsolState(currentHealth: 22, currentShield: 0, healthPotionSickness: false),
                            reducer: donsolReducer,
                            environment: .live
                        )
                    ), label: { Text("Start Game") }
                )
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
