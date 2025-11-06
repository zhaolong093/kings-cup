//
//  GameState.swift
//  Drinking game
//
//  Created by 是她 on 23/9/2025.
//

import Foundation
import SwiftUI

final class GameState: ObservableObject {
    @Published private(set) var deck: Deck = .standardShuffled()
    @Published private(set) var lastCard: Card?
    @Published private(set) var pileCount: Int = 0
    @Published private(set) var currentRule: Rule?
    @Published private(set) var kingsDrawn: Int = 0
    
    
    func resetDeck(){
        deck = .standardShuffled()
        lastCard = nil
        pileCount = 0
        currentRule = nil
        kingsDrawn = 0
    }
    
    func draw(){
        guard !deck.isEmpty else { return }
        if let c = deck.draw(){
            lastCard = c
            pileCount += 1
            currentRule = RuleBook.classic[c.rank]
            if c.rank == .King{
                kingsDrawn += 1
            }
        }
    }
}
