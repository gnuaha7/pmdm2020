//
//  MemoryBoard.swift
//  Memory
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

private enum MemoryBoardState {
    case noFlippedCards
    case oneFlippedCards(flippedInde: Int)
    case twoFlippedCards(flippedIndex1: Int, flippedIndex2: Int)
}

struct MemoryBoard<ContentType: Equatable> {
    var cards: Array<Card>
    private var state = MemoryBoardState.noFlippedCards

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
        let optionalIndex = cards.firstIndex { $0.id == card.id }
        guard let cardIndex = optionalIndex else {
            return
        }
        
        cards[cardIndex].isFlipped.toggle()

        switch state {
        case .noFlippedCards:
            state = .oneFlippedCards(flippedInde: cardIndex)
        case .oneFlippedCards(let flippedIndex):
            if card.content == cards[flippedIndex].content {
                cards[flippedIndex].isFlipped = false
                cards[cardIndex].isFlipped = false
                cards[flippedIndex].isMatched = true
                cards[cardIndex].isMatched = true
                state = .noFlippedCards
            } else {
                state = .twoFlippedCards(flippedIndex1: flippedIndex, flippedIndex2: cardIndex)
            }
        case .twoFlippedCards(let index1, let index2):
            cards[index1].isFlipped.toggle()
            cards[index2].isFlipped.toggle()
            state = .oneFlippedCards(flippedInde: cardIndex)
        }
    }

    struct Card: Identifiable {
        var isFlipped: Bool = false
        var isMatched: Bool = false
        var content: ContentType

        // MARK: Identifiable
        var id: Int
    }
}
