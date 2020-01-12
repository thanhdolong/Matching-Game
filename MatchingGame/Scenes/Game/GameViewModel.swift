//
//  GameViewModel.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation

final class GameViewModel {
    private var cards = [Card]()

    func setCards(cards: [Card]) {
        self.cards = cards
    }

    func numberOfRows() -> Int {
        return cards.count
    }

    func getCard(for index: Int) -> Card {
        return cards[index]
    }
}
