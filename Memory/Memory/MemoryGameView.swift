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
        VStack{
            if viewModel.won {
                Text("Has Ganado 🎉")
            }
            GridView(viewModel.cardViewModels) { cardViewModel in
                CardView(cardViewModel: cardViewModel)
                    .onTapGesture { viewModel.choose(cardViewModel: cardViewModel) }

            }
            .padding()
            .foregroundColor(Color.blue)
        }
    }
}

struct CardView: View{
    var cardViewModel: CardViewModel<String>

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if cardViewModel.isFlipped
                    || cardViewModel.isMatched {
                    if cardViewModel.isMatched {
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.green, lineWidth:3)
                    } else {
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 3)
                    }
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.gray.opacity(0.25))
                    Text(cardViewModel.content).font(Font.system(size: min(geometry.size.height, geometry.size.width) - 20))
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
