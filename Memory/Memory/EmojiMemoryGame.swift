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
        let numberOfPairs = 3
        let emojis = ["🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇧🇷", "🇨🇺", "🇻🇪", "🇺🇸", "🇫🇷", "🇦🇺"]
        let content = emojis.shuffled().prefix(numberOfPairs)
        board = MemoryBoard<String>(numberOfPairs: content.count) { content[$0] }
    }

    // MARK: Intents

    func choose(card:MemoryBoard<String>.Card) {
        board.choose(card: card)
    }
}
