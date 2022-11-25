import SwiftUI
import ComposableArchitecture

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

