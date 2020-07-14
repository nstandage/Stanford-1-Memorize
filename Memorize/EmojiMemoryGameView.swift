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
                .foregroundColor(viewModel.themeColor)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                    
                }
                .padding(5)
            }
                
            .padding()
            .foregroundColor(self.viewModel.themeColor)
            
            
            HStack {
                Text("\(viewModel.score)")
                    .font(.largeTitle)
                    .padding(.leading, 20)
                    .foregroundColor(viewModel.themeColor)
                
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.newGame()
                    }
                }, label: {
                    Text("New Game")
                        .font(.headline)
                        .padding()
                        .background(viewModel.themeColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
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
    
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else  {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    //MARK: - Drawing Constants
    
    private let fontScaleFacor: CGFloat = 0.7
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFacor
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
