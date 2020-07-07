//
//  ContentView.swift
//  Memorize
//
//  Created by Nathan on 7/7/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.purple)
        .font(viewModel.cards.count<10 ? Font.largeTitle : Font.headline)
         
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 16.0).stroke(lineWidth: 3)
                Text(card.content)
            } else  {
                RoundedRectangle(cornerRadius: 16.0).fill()
                RoundedRectangle(cornerRadius: 16.0).stroke(lineWidth: 3)
            }

        }.aspectRatio(0.66, contentMode: .fit)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
