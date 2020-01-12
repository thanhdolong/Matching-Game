//
//  AppDependency.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Swinject

final class AppDependency {
    let container: Container

    init(container: Container = .init()) {
        self.container = container
        setupDependencies()
    }

    private func setupDependencies() {
        container.register(NetworkManager.self) { _ in
            NetworkManagerImpl()
        }

        container.register(CardService.self) { resolver in
            CardServiceImpl(networkManager: resolver.resolve(NetworkManager.self)!)
        }

        // MARK: - ViewModels
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(cardService: resolver.resolve(CardService.self)!)
        }

        container.register(GameViewModel.self) { _ in
            GameViewModel()
        }

        // MARK: - ViewControllers
        container.register(HomeViewController.self) { resolver in
            HomeViewController(homeViewModel: resolver.resolve(HomeViewModel.self)!)
        }

        container.register(GameViewController.self) { resolver in
            GameViewController(gameViewModel: resolver.resolve(GameViewModel.self)!)
        }
    }
}
