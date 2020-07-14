//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nathan on 7/7/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            Text(viewModel.themeName)
                .font(.largeTitle)
                .padding(.top, 20)
                .foregroundColor(viewModel.cardColor)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
        
            .padding()
            .foregroundColor(self.viewModel.cardColor)
            
            
            HStack {
                Text("\(viewModel.score)")
                    .font(.largeTitle)
                    .padding(.leading, 20)
                    .foregroundColor(viewModel.cardColor)
                
                Spacer()
                Button(action: viewModel.newGame) {
                    Text("New Game")
                        .font(.headline)
                        .padding()
                        .background(viewModel.cardColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.trailing, 20)
            }
            .padding(0)
            
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card

    
    var body: some View {
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
        
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else  {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                
            }
            
        }
        .font(Font.system(size: fontSize(for: size)))
        
        
    }
    
    //MARK: - Drawing Constants
    
    private let cornerRadius:CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFacor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFacor
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
