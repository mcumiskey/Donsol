//
//  SheildView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 6/23/22.
//

import SwiftUI
import ComposableArchitecture

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

struct ComposableSheildView: View {
    let store: Store <DonsolState, DonsolAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack(alignment: .center) {
                Image(systemName: "suit.diamond.fill")
                    .resizable()
                    .padding(5)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(.red)
                
                HStack {
                    Text("\(viewStore.currentShield)")
                        .foregroundColor(.white)
                    Text("/")
                        .foregroundColor(.white)
                    Text("11")
                        .foregroundColor(.white)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .trailing) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: geometry.size.width * (viewStore.sheildPercent/100), height: geometry.size.height)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
