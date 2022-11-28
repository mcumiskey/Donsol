//
//  Card.swift
//  Donsol
//
//  Created by Miles Cumiskey on 4/2/22.
//

import Foundation
import SwiftUI //for Image property of card

enum CardValue: Equatable {
    enum Number: Int, Equatable {
        case ace = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        case ten = 10
        case jack = 11
        case queen = 12
        case king = 13
    }
    
    enum Color: String, Equatable {
        case red, blue
    }

    case heart(Number)
    case diamond(Number)
    case spade(Number)
    case club(Number)
    case joker(Color)
    
    var isMonster: Bool {
        switch self {
        case .heart, .diamond:
            return false
        default:
            return true
        }
    }
    
    var image : Image {
        switch self {
        //the num is the Enum, that has to bee gotten after the suite
        case .heart(let num) :
            return Image("hearts_\(num.rawValue)")
        case .diamond(let num) :
            return Image("diamonds_\(num.rawValue)")
        case .spade(let num) :
            return Image("spades_\(num.rawValue)")
        case .club(let num) :
            return Image("clubs_\(num.rawValue)")
        case .joker(let color) :
            return Image("joker_\(color.rawValue)")
        }
    }
    
    var backImage : Image {
        return Image("back_blue")
    }
    
    var cardDescription : String {
        switch self {
        //the num is the Enum, that has to bee gotten after the suite
        case .heart(let num) :
                if(num.rawValue > 10){
                    return "Large Potion \(num)"
                } else {
                    return "Potion \(num)"
                }
        case .diamond(let num) :
            return "Sheild \(num)"
        case .spade(let num) :
            return "Monster \(num)"
        case .club(let num) :
            return "Monster \(num)"
        case .joker(let color) :
            return "\(color) donsol"
        }
    }
}

extension Array where Element == CardValue {
    static var standardDeck: [CardValue] {
        [
           .heart(.ace),
           .heart(.two),
           .heart(.three),
           .heart(.four),
           .heart(.five),
           .heart(.seven),
           .heart(.eight),
           .heart(.nine),
           .heart(.ten),
           .heart(.jack),
           .heart(.queen),
           .heart(.king),
         
           .diamond(.ace),
           .diamond(.two),
           .diamond(.three),
           .diamond(.four),
           .diamond(.five),
           .diamond(.seven),
           .diamond(.eight),
           .diamond(.nine),
           .diamond(.ten),
           .diamond(.jack),
           .diamond(.queen),
           .diamond(.king),
           
           .spade(.ace),
           .spade(.two),
           .spade(.three),
           .spade(.four),
           .spade(.five),
           .spade(.seven),
           .spade(.eight),
           .spade(.nine),
           .spade(.ten),
           .spade(.jack),
           .spade(.queen),
           .spade(.king),
           
           .club(.ace),
           .club(.two),
           .club(.three),
           .club(.four),
           .club(.five),
           .club(.seven),
           .club(.eight),
           .club(.nine),
           .club(.ten),
           .club(.jack),
           .club(.queen),
           .club(.king),
           
           .joker(.blue),
           .joker(.red)
       ]
    }
}

//the cards have a value and know if they are flipped
//the CardValue holds the suit and numbers
struct Card: Equatable, Identifiable {
    var id: String { value.cardDescription }
    let value: CardValue
    let isFlipped: Bool
}

extension Array where Element == Card {
    static var newDeck: [Card] {
        //map the CardValues to the new Deck of cards.
        //$0 is a representation of the argument each time, it is a parameter
        [CardValue].standardDeck.map { Card(value: $0, isFlipped: false)}
    }
}

struct Deck: Equatable {
    var cards: [Card]
    
    init() {
        cards = .newDeck
    }
    
    func listDeck() {
        for card in cards {
            print(card.value.cardDescription)
        }
    }
    
    mutating func shuffleDeck() {
        cards.shuffle()
    }
    
    mutating func drawCard() -> Card? {
        return cards.popLast()
    }
    
    mutating func addCard(card: Card) {
        cards.append(card)
    }
    
}
