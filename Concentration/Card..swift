//
//  Card.swift
//  Concentration
//
//  Created by Aleksander Pentchev on 25/04/2020.
//  Copyright © 2020 Aleksander Pentchev. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init() {
        self.identifier = Card.getUniqueId()
    }
    
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
}
 
