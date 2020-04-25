//
//  Concentration.swift
//  Concentration
//
//  Created by Aleksander Pentchev on 25/04/2020.
//  Copyright © 2020 Aleksander Pentchev. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numOfPairsOfCards: Int) {
        assert(numOfPairsOfCards > 0, "Concentration.init: number of pairs of cards must be > 0" )
        for _ in 1...numOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: shuffle the cards
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): choses index not in the cards" )
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
