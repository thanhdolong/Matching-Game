//
//  GameViewModel.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation

protocol GameViewModelDelegate: class {
    func didChangeMatches()
    func didWinGame()
    func reloadData()
}

final class GameViewModel {
    private var cards: [Card]
    private var shuffledCards = [Card]() {
        didSet {
            delegate?.reloadData()
        }
    }

    private(set) var gameSettings: Settings
    private(set) var identifierOfFaceUpCard: Int?
    private(set) var flipCount: Int = 0
    private(set) var matchCount: Int = 0 {
        didSet {
            if matchCount == gameSettings.matchToWin {
                delegate?.didWinGame()
            }
        }
    }

    weak var delegate: GameViewModelDelegate?

    init(cards: [Card], settings: Settings) {
        self.cards = cards
        self.gameSettings = settings
    }
    
    func createGame() {
        shuffledCards.removeAll()
        for _ in 0..<gameSettings.cardsToMatch {
            shuffledCards.append(contentsOf: cards)
        }
        shuffledCards.shuffle()
    }

    func shuffleGame() {
        shuffledCards.shuffle()
    }
    
    func numberOfRows() -> Int {
        return shuffledCards.count
    }
    
    func getCard(for index: Int) -> Card {
        return shuffledCards[index]
    }

    func chooseCard(at index: Int) {
        guard shuffledCards[index].isMatched == false else { return }
        flipCount = flipCount + 1

        if let identifierOfFaceUpCard = identifierOfFaceUpCard {
            shuffledCards[index].isFaceUp = true
            let faceUpCards = shuffledCards.filter { $0.isFaceUp }

            if shuffledCards[index].identifier == identifierOfFaceUpCard  {
                if faceUpCards.count == gameSettings.cardsToMatch {
                    matchCount = matchCount + 1
                    delegate?.didChangeMatches()

                    shuffledCards = shuffledCards.map({ card in
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
            shuffledCards = shuffledCards.map({ card in
                var card = card
                card.isFaceUp = false
                return card
            })

            shuffledCards[index].isFaceUp = true
            self.identifierOfFaceUpCard = shuffledCards[index].identifier
        }
    }
    
}
