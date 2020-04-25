//
//  ViewController.swift
//  Concentration
//
//  Created by Aleksander Pentchev on 25/04/2020.
//  Copyright © 2020 Aleksander Pentchev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private lazy var game = Concentration(numOfPairsOfCards: numOfPairsOfCards)
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"

        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!
        
    @IBAction private func touchMyCard(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("choses card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["👻", "🎃","🧨","🕵🏻‍♂️", "😸", "❤️", "⭐️", "💵"]
    
    private var emoji = [Int: String]()

    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}

