//
//  BackgroundView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 6/19/22.
//

import SwiftUI

struct BackgroundView: ViewModifier {
    func body(content: Content) -> some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func setBackground () -> some View {
        modifier(BackgroundView())
    }
}
