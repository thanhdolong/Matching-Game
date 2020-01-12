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

    // MARK: - Object Lifecycle
    public init(router: Router, container: Container) {
        self.router = router
        self.container = container
    }

    // MARK: - Instance Methods
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = container.resolve(GameViewController.self)!
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
}
