//
//  MemoryBoard.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

struct MemoryBoard<ContentType> {
    var cards: Array<Card>

    init(numberOfPairs: Int, cardContentGenerator: (Int)->ContentType) {
        cards = [Card]()
        for index in 0..<numberOfPairs {
            let content = cardContentGenerator(index)
            cards.append(Card(isFlipped: true, content: content))
            cards.append(Card(isFlipped: true, content: content))
        }
    }

    func choose(card:Card) {
        print("Selected card \(card)")
    }

    struct Card {
        var isFlipped: Bool
        var content: ContentType
    }
}
