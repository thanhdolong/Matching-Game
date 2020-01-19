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
    let settings: Settings

    // MARK: - Object Lifecycle
    public init(router: Router, container: Container, cards: [Card], settings: Settings) {
        self.router = router
        self.container = container
        self.cards = cards
        self.settings = settings
    }

    // MARK: - Instance Methods
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewModel = container.resolve(GameViewModel.self, arguments: cards, settings)!
        let viewController = container.resolve(GameViewController.self, argument: viewModel)!
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
}
