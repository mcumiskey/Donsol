//
//  HealthView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 6/23/22.
//

import SwiftUI
import ComposableArchitecture

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

struct ComposableHealthView: View {
    let store: Store <DonsolState, DonsolAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .padding(5)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(Color("Red"))
                
                HStack {
                    Text("\(viewStore.currentHealth)")
                        .foregroundColor(.white)
                    Text("/")
                        .foregroundColor(.white)
                    Text("22")
                        .foregroundColor(.white)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: geometry.size.width * (viewStore.healthPercent/100), height: geometry.size.height)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
