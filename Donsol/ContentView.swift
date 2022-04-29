//
//  ContentView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var game = Game()
    var Card1 = Card.heart(.ace)
    var Card2 = Card.club(.queen)
    var Card3 = Card.diamond(.king)
    var Card4 = Card.joker(.red)
    
    @State var isEnabled = true

        
    var body: some View {
        ZStack {
            BackgroundView()
            VStack{
                Spacer()

                HeaderView(game: game)

                
                HStack {
                    CardButtonView(game: game, isEnabled: $isEnabled, card: Card1)
                    CardButtonView(game: game, isEnabled: $isEnabled, card: Card2)

                }
                HStack {
                    CardButtonView(game: game, isEnabled: $isEnabled, card: Card3)
                    CardButtonView(game: game, isEnabled: $isEnabled, card: Card4)

                }
                Spacer()
                Text("Sheild Break: \(self.game.sheild_break)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color("Background"))
            .ignoresSafeArea()
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
                Text("\(self.game.max_health)")
                    .foregroundColor(.white)
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 10)
                
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: game.healthPercent, height: 10)
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
            
            Text("\(self.game.current_sheild)" + " / " + "\(self.game.max_sheild)")
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
    @Binding var isEnabled: Bool
    var card: Card
    
    var body: some View {
            Button (action: {
                game.selectCard(card: card)

            }) {
            VStack {
                if(isEnabled) {
                    CardView(card: card, showBack: true)
                } else {
                    CardView(card: card, showBack: false)
                }
            }
        }
    }
}

struct CardView: View {
    var card: Card
    var showBack: Bool
    
    var body: some View {
        if(showBack) {
            card.image
                .padding([.leading, .trailing], 25)
            Text(card.cardDescription)
                .foregroundColor(.white)
        } else {
            card.backImage
                .padding([.leading, .trailing], 25)
            Text(" ")
                .foregroundColor(.white)
        }
        
    }
}
