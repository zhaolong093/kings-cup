//
//  Rules.swift
//  Drinking game
//
//  Created by 是她 on 23/9/2025.
//


import Foundation
struct Rule {
    let title: String
    let description: String
}

enum RuleBook{
    static let classic: [Rank: Rule] = [
            .ace:   Rule(title: "Waterfall", description: "Everyone drinks; you can stop when the left person stops."),
            .two:   Rule(title: "You", description: "Pick someone to drink."),
            .three: Rule(title: "Me", description: "You drink."),
            .four:  Rule(title: "Floor", description: "Last to touch the floor drinks."),
            .five:  Rule(title: "Guys", description: "All guys drink."),
            .six:   Rule(title: "Girls", description: "All girls drink."),
            .seven: Rule(title: "Heaven", description: "Last to raise a hand drinks."),
            .eight: Rule(title: "Mate", description: "Choose a mate—drink together all rounds."),
            .nine:  Rule(title: "Rhyme", description: "Say a word; go around rhyming."),
            .ten:   Rule(title: "Categories", description: "Pick a category; go around naming items."),
            .Jack:  Rule(title: "Never Have I Ever", description: "3 fingers; first to 0 drinks."),
            .Queen: Rule(title: "Question Master", description: "Answer the QM’s question → drink."),
            .King:  Rule(title: "King’s Cup", description: "Pour to the cup; 4th king drinks it.")
        ]
}
