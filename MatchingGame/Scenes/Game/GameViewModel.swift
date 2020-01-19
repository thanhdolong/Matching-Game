//
//  GameViewModel.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation

final class GameViewModel {
    private var cards: [Card]
    private var shuffledCard = [Card]()
    
    private(set) var flipCount: Int = 0
    private(set) var score: Int = 0
    private(set) var gameSettings: Settings
    private(set) var identifierOfFaceUpCard: Int?
    private(set) var shouldHideCard: Bool = false
    
    init(cards: [Card], settings: Settings) {
        self.cards = cards
        self.gameSettings = settings
    }
    
    func createGame() {
        shuffledCard.removeAll()
        for _ in 0..<gameSettings.cardsToMatch {
            shuffledCard.append(contentsOf: cards)
        }
        shuffledCard.shuffle()
    }
    
    func numberOfRows() -> Int {
        return shuffledCard.count
    }
    
    func getCard(for index: Int) -> Card {
        return shuffledCard[index]
    }
    
    func chooseCard(at index: Int) {
        guard shuffledCard[index].isMatched == false else { return }
        flipCount = flipCount + 1

        if let identifierOfFaceUpCard = identifierOfFaceUpCard {
            shuffledCard[index].isFaceUp = true
            let faceUpCards = shuffledCard.filter { $0.isFaceUp }

            if shuffledCard[index].identifier == identifierOfFaceUpCard  {
                if faceUpCards.count == gameSettings.cardsToMatch {

                    shuffledCard = shuffledCard.map({ card in
                        guard card.isFaceUp else { return card }

                        var card = card
                        card.isFaceUp = false
                        card.isMatched = true
                        return card
                    })

                }

            } else {
                self.identifierOfFaceUpCard = nil
            }

        } else {
            shuffledCard = shuffledCard.map({ card in
                var card = card
                card.isFaceUp = false
                return card
            })

            shuffledCard[index].isFaceUp = true
            self.identifierOfFaceUpCard = shuffledCard[index].identifier
        }
    }
    
}
