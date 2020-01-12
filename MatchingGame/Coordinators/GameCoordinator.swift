//
//  GameCoordinator.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Swinject

final class GameCoordinator: Coordinator {
    // MARK: - Instance Properties
    var children: [Coordinator] = []
    let container: Container
    let router: Router
    let cards: [Card]

    // MARK: - Object Lifecycle
    public init(router: Router, container: Container, cards: [Card]) {
        self.router = router
        self.container = container
        self.cards = cards
    }

    // MARK: - Instance Methods
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = container.resolve(GameViewController.self)!
        viewController.viewModel.setCards(cards: cards)
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
}
