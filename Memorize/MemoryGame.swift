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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startingUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var seen: Bool = false
        var id: Int
        
        
        
        // MARK: - Bonus Time


        // can be zero while means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6


        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }


        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        //the accumulated time this card has been face up in the past
        //(i.e. not including the current time it's been faceup if it is currently so)
        var pastFaceUpTime: TimeInterval = 0

        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }

        //percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }

        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        //whether we are currently faceup, unmatched and have not yet used the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        //called when the card transitions to face up state
        private mutating func  startingUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
    
}














