//
//  HomeViewController.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright (c) 2020 Thành Đỗ Long. All rights reserved.
//

import UIKit
protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidPressPlayButton(_ viewController: HomeViewController, cards: [Card])
}

final class HomeViewController: UIViewController {
    private(set) var viewModel: HomeViewModel
    weak var delegate: HomeViewControllerDelegate?

    private var indicator: UIView?

    var homeView: HomeView! {
        guard isViewLoaded else { return nil }
        return (view as! HomeView)
    }

    // MARK: - View lifecycle

    init(homeViewModel: HomeViewModel) {
        self.viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cardsToMatchSlider(_ sender: UISlider) {
        let value = Int(sender.value)
        homeView.numberOfCardsToMatchLabel.text = "Number of cards to match: \(value)"
        viewModel.setCardsToMatch(value)
    }


    @IBAction func matchToWinSlider(_ sender: UISlider) {
        let value = Int(sender.value)
        homeView.numberOfMatchToWinLabel.text = "Number of match to win: \(value)"
        viewModel.setMatchToWin(value)
    }

    @IBAction func playGameButton(_ sender: UIButton) {
        indicator = showActivityIndicatory(onView: self.view)

        viewModel.prepareGame()
            .done({ [unowned self] cards in
                self.delegate?.homeViewControllerDidPressPlayButton(self, cards: cards)
            })
            .ensure { [unowned self] in
                guard let indicator = self.indicator else { return }
                self.removeIndicator(indicator: indicator)
            }
            .catch { [unowned self] error in
                self.presentAlertAction(withTitle: "Network error", message: error.localizedDescription)
            }
    }
}
