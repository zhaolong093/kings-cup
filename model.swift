//
//  model.swift
//  Drinking game
//
//  Created by 是她 on 23/9/2025.
//

import Foundation

enum Suit: CaseIterable{
    case hearts,diamonds,clubs,spades
    var emoji: String{
        switch self{
        case .hearts:
            return "❤️"
        case .diamonds:
            return "♦️"
        case .clubs:
            return "♣️"
        case .spades:
            return "♠️"
        }
    }
}

enum Rank: Int, CaseIterable{
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, Jack, Queen, King
    var label: String{
        switch self{
        case .ace:
            return "A"
        case .Jack:
            return "J"
        case .Queen:
            return "Q"
        case .King:
            return "K"
        default: return String(rawValue)
        }
    }
}

struct Card: Identifiable, Equatable{
    let id: UUID = UUID()
    let rank: Rank
    let suit: Suit
}

struct Deck{
    private(set) var cards: [Card] = []
    
    static func standardShuffled()->Deck{
        var arr: [Card] = []
        for s in Suit.allCases{
            for r in Rank.allCases{
                arr.append(Card(rank: r, suit: s))
            }
        }
        arr.shuffle()
        return Deck(cards: arr)
    }
    mutating func draw() -> Card?{
        cards.popLast()
    }
    var isEmpty: Bool{
        cards.isEmpty
    }
}
