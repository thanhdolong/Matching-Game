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
    private(set) var numberOfMatchCards: Int = 2
    private(set) var gameSettings: Settings

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
        let card = getCard(for: index)

        
    }
}
