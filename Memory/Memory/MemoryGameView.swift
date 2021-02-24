//
//  MemoryGameView.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            ForEach(viewModel.board.cards) { card in
                CardView(card: card)
                    .onTapGesture { viewModel.choose(card: card) }
            }
        }
        .padding()
        .foregroundColor(Color.blue)
    }
}

struct CardView: View{
    var card: MemoryBoard<String>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFlipped || card.isMatched {
                    if card.isMatched {
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.green)
                    } else {
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke()
                    }
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.gray.opacity(0.25))
                    Text(card.content).font(Font.system(size: min(geometry.size.height, geometry.size.width) - 20))
                } else {
                    RoundedRectangle(cornerRadius: 10.0)
                }
            }
        }
    }
}









































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemoryGameView(viewModel: EmojiMemoryGame())
            MemoryGameView(viewModel: EmojiMemoryGame())
                .preferredColorScheme(.dark)
        }
    }
}
