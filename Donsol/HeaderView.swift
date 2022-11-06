//
//  HeaderView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 6/23/22.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        VStack {
            Text("This is a game about surviving a dungeon made of 54 playing cards.")
                .foregroundColor(.white)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(30.0)
                .border(Color.white, width: 1)
            HStack {
                HealthView(game: game)
                SheildView(game: game)
            }
        }
    }
}

