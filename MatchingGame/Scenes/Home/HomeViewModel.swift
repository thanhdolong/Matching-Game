//
//  HomeViewModel.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright (c) 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation
import PromiseKit

final class HomeViewModel {
    private var gameSettings: Settings
    private let cardService: CardService

    init(cardService: CardService,
         settings: Settings = Settings(cardsToMatch: 2, matchToWin: 10)) {

        self.cardService = cardService
        self.gameSettings = settings
    }

    func setCardsToMatch(_ value: Int) {
        gameSettings.cardsToMatch = value
    }

    func setMatchToWin(_ value: Int) {
        gameSettings.matchToWin = value
    }

    func getGameSettings() -> Settings {
        return gameSettings
    }

    func prepareGame() -> Promise<[Card]> {
        let amountOfImages = gameSettings.matchToWin
        return cardService.getCards(amount: amountOfImages)
    }
}
