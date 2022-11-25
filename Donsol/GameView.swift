//
//  ContentView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 4/2/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var game = Game()
    
    var body: some View {
        
        if(!game.gameOver) {
            VStack{
                ComposableHeaderView(text: "This is a game about surviving a dungeon made of 54 playing cards.")
                Spacer()
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(game.room) { card in
                        CardButtonView(game: game, card: card)
                    }
                }
                Spacer()
                if(self.game.sheild_break != 0) {
                    Text("Sheild Break: \(self.game.sheild_break)")
                        .foregroundColor(.white)
                        .padding(10)
                }
                Button(action: { game.generateRoom() }, label: {
                    Text("Next Room")
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                })
            }.setBackground()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

