//
//  ComposableUIElements.swift
//  Donsol
//
//  Created by Miles Cumiskey on 11/8/22.
//

import SwiftUI
import ComposableArchitecture

struct HealthBar: View {
    let maxValue: Int
    let curValue: Int
    let percent: CGFloat
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "heart.fill")
                .resizable()
                .padding(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.red)
            
            HStack {
                Text("\(curValue)")
                    .foregroundColor(.white)
                Text("/")
                    .foregroundColor(.white)
                Text("\(maxValue)")
                    .foregroundColor(.white)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width * (percent/100), height: geometry.size.height)
                }
            }
            .padding(.vertical, 4)
            
        }.frame(height: 14)
        .padding(.horizontal, 25)
    }
}

struct SheildBar: View {
    let maxValue: Int
    let curValue: Int
    let percent: CGFloat
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "suit.diamond.fill")
                .resizable()
                .padding(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.red)
            
            HStack {
                Text("\(curValue)")
                    .foregroundColor(.white)
                Text("/")
                    .foregroundColor(.white)
                Text("\(maxValue)")
                    .foregroundColor(.white)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width * (percent/100), height: geometry.size.height)
                }
            }
            .padding(.vertical, 4)
            
        }.frame(height: 14)
        .padding(.horizontal, 25)
    }
}



struct ComposableCardView: View {
    let card: Card
    let selectCard: (Card) -> Void
    var body: some View {
            Button (action: {
                if (!card.isFlipped) {
                    selectCard(card)
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

struct ComposableHeaderView: View {
    let text: String
    var body: some View {
        VStack {
            Text(text)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(30.0)
                .border(Color.white, width: 1)
        }
    }
}

struct ComposableShieldStrengthView: View {
    let shieldStrength: Int
    var body: some View {
        VStack {
            Text("Your shield will break if you take more than \(shieldStrength) damage")
                .foregroundColor(.white)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(30.0)
                .border(Color.white, width: 1)
                .lineLimit(0)
        }
    }
}


