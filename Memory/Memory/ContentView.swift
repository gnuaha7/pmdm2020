//
//  ContentView.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            ForEach(0..<viewModel.board.cards.count) { row in
                CardView(card: viewModel.board.cards[row])
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
                if card.isFlipped {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke()
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
            ContentView(viewModel: EmojiMemoryGame())
            ContentView(viewModel: EmojiMemoryGame())
                .preferredColorScheme(.dark)
        }
    }
}
