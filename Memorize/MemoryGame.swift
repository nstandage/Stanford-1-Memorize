//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nathan on 7/7/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var theme: Theme
    private(set) var score = 0
    private var date = Date()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
//        timeScore()
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let previousPickIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[previousPickIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[previousPickIndex].isMatched = true
                    updateScore(by: 2)
                } else {
                    if cards[chosenIndex].seen {
                    updateScore(by: -1)
                    }
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                if cards[chosenIndex].seen {
                    updateScore(by: -1)
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].seen = true
        }
    }
    
    
    private mutating func updateScore(by number: Int) {
        score += number
    }
    
    private mutating func timeScore() {
        let newDate = Date()
        let time = date.timeIntervalSince(newDate)

        score += max(10 + Int(time * 0.9), 0)
        date = newDate
    }
    
    
    init(numberOfPairsOfCards: Int, theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        self.theme = theme
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
        score = 0
    }
    
    

    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var seen: Bool = false
        var id: Int
    }
}
