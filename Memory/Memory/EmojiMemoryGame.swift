//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var board: MemoryBoard<String>

    init() {
        let numberOfPairs = 4
        let emojis = ["🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇧🇷", "🇨🇺", "🇻🇪", "🇺🇸", "🇫🇷", "🇦🇺"]
        let content = emojis.shuffled().prefix(numberOfPairs)
        board = MemoryBoard<String>(numberOfPairs: content.count) { content[$0] }
    }

    var won: Bool {
        return board.cards.allSatisfy { $0.isMatched }
    }

    var cardViewModels: [CardViewModel<String>] {
        return board.cards.map {
            CardViewModel(card: $0)
        }
    }

    // MARK: Intents

    func choose(cardViewModel:CardViewModel<String>) {
        let cardIndex = board.cards.firstIndex {
            cardViewModel.id == $0.id
        }

        if let safeCardIndex = cardIndex {
            board.choose(card: board.cards[safeCardIndex])
        }
    }
}

class CardViewModel<Content>: Identifiable where Content:Equatable {
    private let card:MemoryBoard<Content>.Card

    var isFlipped: Bool {
        card.isFlipped
    }

    var isMatched: Bool {
        card.isMatched
    }

    var content: Content {
        card.content
    }

    var id: Int {
        card.id
    }


    init(card:MemoryBoard<Content>.Card) {
        self.card = card
    }
}
