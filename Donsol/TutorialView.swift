///
//  TutorialView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 11/25/22.
//

import SwiftUI

struct TutorialView: View {
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                RoyaltyTutorialView()
                    .tag(0)
                    .tabItem {
                        Label("Faces", systemImage: "crown")
                    }
                HeartsTutorialView()
                    .tag(1)
                    .tabItem {
                        Label("Hearts", systemImage: "heart")
                    }
                DiamondsTutorialView()
                    .tag(2)
                    .tabItem {
                        Label("Diamonds", systemImage: "diamond")
                    }
                MonsterTutorialView()
                    .tag(3)
                    .tabItem {
                        Label("Clubs", systemImage: "suit.club.fill")
                    }
                MonsterTutorialView()
                    .tag(3)
                    .tabItem {
                        Label("Spades", systemImage: "suit.spade.fill")
                    }
            }
        }
    }
}

struct HeartsTutorialView: View {
    var body: some View {
        Text("Heart")
    }
}

struct DiamondsTutorialView: View {
    var body: some View {
        Text("Diamond")
    }
}

struct MonsterTutorialView: View {
    var body: some View {
        Text("Clubs, Spades")
    }
}

struct RoyaltyTutorialView: View {
    var body: some View {
        Text("Kings, Queens, Jack")
    }
}

struct DonsolTutorialView: View {
    var body: some View {
        Text("Donsol")
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
