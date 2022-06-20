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
        VStack{
            HeaderView(game: game)
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


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

struct HealthView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .resizable()
                .padding(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.red)
            
            HStack {
                Text("\(self.game.current_health)")
                    .foregroundColor(.white)
                Text("/")
                    .foregroundColor(.white)
                Text("22")
                    .foregroundColor(.white)
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 10)
                
                if (game.healthPotionSickness == true) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: game.healthPercent, height: 10)
                } else {
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: game.healthPercent, height: 10)
                }
                
            }
            
        }
    }
}

struct SheildView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        HStack {
            Image(systemName: "suit.diamond.fill")
                .resizable()
                .padding(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.red)
            
            Text("\(self.game.current_sheild)" + " / " + "11")
                .foregroundColor(.white)
            
            //
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 10)
                
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: game.sheildPercent, height: 10)
            }
            
        }
    }
}

struct CardButtonView: View {
    @ObservedObject var game: Game
    let card: Card
    
    var body: some View {
        Button (action: {
            if (!card.isFlipped) {
                game.selectCard(card: card.value)
            }
        }) {
            VStack {
                if(card.isFlipped) {
                    card.value.backImage
                        .padding([.leading, .trailing], 25)
                    Text("  ")
                } else {
                    card.value.image
                        .padding([.leading, .trailing], 25)
                    Text(card.value.cardDescription)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
