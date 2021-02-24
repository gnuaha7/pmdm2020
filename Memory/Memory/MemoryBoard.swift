//
//  MemoryBoard.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

struct MemoryBoard<ContentType: Equatable> {
    var cards: Array<Card>
    var alreadyFlippedIndex1: Int = -1
    var alreadyFlippedIndex2: Int = -1

    init(numberOfPairs: Int, cardContentGenerator: (Int)->ContentType) {
        cards = [Card]()
        for index in 0..<numberOfPairs {
            let content = cardContentGenerator(index)
            cards.append(Card(content: content, id:2 * index))
            cards.append(Card(content: content, id:2 * index + 1))
        }
        cards.shuffle()
    }

    mutating func choose(card:Card) {
        let cardIndex = index(of: card)
        cards[cardIndex].isFlipped.toggle()

        if alreadyFlippedIndex1 >= 0 && alreadyFlippedIndex2 >= 0 {
            cards[alreadyFlippedIndex1].isFlipped.toggle()
            cards[alreadyFlippedIndex2].isFlipped.toggle()
            alreadyFlippedIndex1 = cardIndex
            alreadyFlippedIndex2 = -1
            return
        } else if alreadyFlippedIndex1 == -1 {
            alreadyFlippedIndex1 = cardIndex
        } else if sameContent(card, as: cards[alreadyFlippedIndex1]) {
            cards[alreadyFlippedIndex1].isFlipped = false
            cards[cardIndex].isFlipped = false
            cards[alreadyFlippedIndex1].isMatched = true
            cards[cardIndex].isMatched = true
            alreadyFlippedIndex1 = -1
        } else {
            alreadyFlippedIndex2 = cardIndex
        }
    }

    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }

        // HACK: Wrong!!!
        return -1
    }

    func sameContent(_ card1:Card, as card2:Card) -> Bool
    {
        return card1.content == card2.content
    }

    struct Card: Identifiable {
        var isFlipped: Bool = false
        var isMatched: Bool = false
        var content: ContentType

        // MARK: Identifiable
        var id: Int
    }
}
