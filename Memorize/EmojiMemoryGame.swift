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

    
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = EmojiMemoryGame.setTheme()
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = theme.numberOfPairsOfCards
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs, theme: theme) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    static func setTheme() -> Theme {
        return Theme.allCases[Int.random(in: 0...Theme.allCases.count-1)]
    }
        
    
    //MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var cardColor: Color {
        model.theme.cardColor
    }
    
    var themeName: String {
        model.theme.rawValue
    }
    
    var score: Int {
        model.score
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
