//
//  Start.swift
//  Donsol
//
//  Created by Miles Cumiskey on 6/19/22.
//

import SwiftUI

struct Start: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Play Game", destination: GameView().navigationBarHidden(true))
               }.setBackground()
               .navigationTitle("Donsol")


               Text("Select a Color") // A placeholder to show before selection.
        }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
            .preferredColorScheme(.light)
    }
}
