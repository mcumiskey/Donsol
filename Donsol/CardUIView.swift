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

struct ComposableCardView: View {
    let card: Card
    let store: Store <DonsolState, DonsolAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            
            Button (action: {
                if (!card.isFlipped) {
                    viewStore.send(.selectCard(card.value))
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
}
