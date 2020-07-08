//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nathan on 7/7/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🍎", "🥝", "🍌", "🍇", "🍊", "🍐", "🍑", "🍒", "🥥", "🍍", "🍋", "🍓", "🍉"].shuffled()
        let numberOfPairs = Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    
    //MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
