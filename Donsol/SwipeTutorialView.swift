//
//  SwipeTutorialView.swift
//  Donsol
//
//  Created by Miles Cumiskey on 11/26/22.
//

import SwiftUI

struct SwipeTutorialView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            TabView(selection: $selection) {
                
                Text("Donsol, designed by John Eternal, is a card game about exploring a dungeon made of a deck of cards.")
                    .foregroundColor(Color("TextColor"))
                    .padding(30)
                    .tag(0)

                VStack {
                    Text("Each 'Room' in the dungeon is described using 4 randomly drawn cards")
                        .foregroundColor(Color("TextColor"))
                        .padding(30.0)

                    Text("A standard deck, jokers included, is a dungeon.")
                        .foregroundColor(Color("TextColor"))
                }.padding(30)
                .tag(1)
                
                //monsters p1
                VStack {
                    Spacer()
                    Text("Clubs and Spades are monsters, you must defeat them in order to move forward.")
                        .foregroundColor(Color("TextColor"))
                        .padding(30.0)
                    HStack {
                        Image("clubs_1")
                        Image("spades_10")
                        
                    }.padding(30)
                    Text("Monsters deal damage equal to their card values.")
                        .foregroundColor(Color("TextColor"))
                        .padding(30.0)
                    Text("Face cards are as follows J is 11, Q is 13, K is 15, A is 17; Jokers are both equal to 21")
                        .foregroundColor(Color("TextColor"))
                        .padding(30.0)
                    Spacer()
                }.padding(30)
                .tag(3)
                
                //hearts p1
                VStack {
                    Text("Heart cards represent potions.")
                        .foregroundColor(Color("TextColor"))
                        .padding(30.0)
                    CustomValueBar(icon: "heart.fill", value: 11, color: "Red", fullness: "middle")
                    HStack {
                        Image("hearts_6")
                        VStack {
                            Text("+6 ♥")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("Red"))
                            Image(systemName: "arrow.turn.right.up")
                                .font(.system(size: 60))
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            Text("Selecting a heart restores health equal to the card value.")
                                .foregroundColor(Color("TextColor"))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }.padding(30)
                    .frame(width: 350, height: 250)
                }.padding(30)
                .tag(3)
                
                //hearts p2
                VStack {
                    Text("Drinking multiple potions in a row will make you sick.")
                        .foregroundColor(Color("TextColor"))
                        .padding(30.0)
                    CustomValueBar(icon: "heart.fill", value: 17, color: "Red", fullness: "low")
                    HStack {
                        Image("hearts_2")
                        VStack {
                            Text("+0 ♥")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("Sick"))
                            Image(systemName: "arrow.turn.right.up")
                                .font(.system(size: 60))
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            Text("Only the first potion's value will be gained.")
                                .foregroundColor(Color("TextColor"))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }.padding(30)
                    .frame(width: 350, height: 250)
                }.padding(30)
                .tag(4)
                
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .setBackground()
    }
}

struct CustomValueBar: View {
    let icon: String
    let value: Int
    let color: String
    let fullness: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "heart.fill")
                .resizable()
                .padding(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(Color(color))
            
            HStack {
                Text("\(value)")
                    .foregroundColor(Color("TextColor"))
                Text("/")
                    .foregroundColor(Color("TextColor"))
                Text("\(22)")
                    .foregroundColor(Color("TextColor"))
            }
            if(fullness == "low"){
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.77), height: geometry.size.height)
                            .opacity(0.40)
                       
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.77), height: geometry.size.height)
                        
                    }
                }
                .padding(.vertical, 4)
            } else if(fullness == "middle"){
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.77), height: geometry.size.height)
                            .opacity(0.40)
                       
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.5), height: geometry.size.height)
                        
                    }
                }
                .padding(.vertical, 4)
            } else {
                
            }
            
            
        }.frame(height: 14)
        .padding(.horizontal, 30)
    }
}

struct CustomValueBarTwoColor: View {
    let icon: String
    let value: Int
    let color: String
    let changeColor: String
    let fullness: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "heart.fill")
                .resizable()
                .padding(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(Color(color))
            
            HStack {
                Text("\(value)")
                    .foregroundColor(Color("TextColor"))
                Text("/")
                    .foregroundColor(Color("TextColor"))
                Text("\(22)")
                    .foregroundColor(Color("TextColor"))
            }
            if(fullness == "low"){
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Rectangle()
                            .foregroundColor(Color(changeColor))
                            .frame(width: geometry.size.width * (0.86), height: geometry.size.height)
                            .opacity(0.60)
                       
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.77), height: geometry.size.height)
                        
                    }
                }
                .padding(.vertical, 4)
            } else if(fullness == "middle"){
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.75), height: geometry.size.height)
                            .opacity(0.40)
                       
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: geometry.size.width * (0.5), height: geometry.size.height)
                        
                    }
                }
                .padding(.vertical, 4)
            } else {
                
            }
            
            
        }.frame(height: 14)
        .padding(.horizontal, 30)
    }
}

struct SwipeTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeTutorialView()
    }
}
