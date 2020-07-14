//
//  Themes.swift
//  Memorize
//
//  Created by Nathan on 7/13/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
import SwiftUI



enum Theme: String, CaseIterable {
    case Fruit
    case Animals
    case Places
    case Sports
    case Faces
    case Colors

    
    
    var emojis: [String] {
        switch self {
        case .Fruit:
            return ["🍎", "🥝", "🍌", "🍇", "🍊", "🍐", "🍑", "🍒", "🥥", "🍍", "🍋", "🍓", "🍉"]
        case .Animals:
            return ["🦁","🦊","🐻","🐼","🐨","🐯","🐸","🦅","🐝","🐗","🐴","🐌"]
        case .Places:
            return ["🗿","🗽","🗼","🏰","🏯","🏟","🎡","🎢","🎠","⛲️","🏜","🌋","🏔","🏝"]
        case .Sports:
            return ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸","🏒","⛳️","🥊","🏹"]
        case .Faces:
            return ["😎","🤓","☹️","🤨","🙃","😀","😤","😳","😞","🤫","🤔","🙄","🥱","🤮","🥴"]
        case .Colors:
            return ["🟥","🟧","🟨","🟩","🟦","🟪","⬛️","🟫","⬜️"]
        }
    }
    
    var cardColor: Color {
        switch self {
        case .Fruit:
            return Color.init(.green)
        case .Animals:
            return Color.init(.blue)
        case .Places:
            return Color.init(.darkGray)
        case .Sports:
            return Color.init(.orange)
        case .Faces:
            return Color.init(.purple)
        case .Colors:
            return Color.init(.black)
        }
    }
    
    
    
    var numberOfPairsOfCards: Int {
        switch self {
         case .Fruit:
            return 4
        case .Animals:
            return Int.random(in: 3...6)
        case .Places:
            return 6
        case .Sports:
            return 3
        case .Faces:
            return 5
        case .Colors:
            return 5
        }
        
        
    }
    
    
    
//    struct Themes {
//        numberOfPairsOfCards: Int
//        emojis: [String]
//        color: Color
//    }
    
    
    
    
    
    
    
}
