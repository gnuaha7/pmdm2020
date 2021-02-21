//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

class EmojiMemoryGame {
    private(set) var board: MemoryBoard<String> = EmojiMemoryGame.createBoard()

    static func createBoard() -> MemoryBoard<String> {
        let emojis = ["🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇦🇺"]
        return MemoryBoard<String>(numberOfPairs: 3) { emojis[$0] }
    }

    // MARK: Intents

    func choose(card:MemoryBoard<String>.Card) {
        board.choose(card: card)
    }
}
