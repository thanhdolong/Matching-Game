//
//  GameViewController.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    private(set) var viewModel: GameViewModel

    // MARK: - UI
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let rightBarButtonItem = UIBarButtonItem()

    // MARK: - View lifecycle

    init(gameViewModel: GameViewModel) {
        self.viewModel = gameViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.createGame()

        collectionView.dataSource = self
        collectionView.delegate = self

        setupUI()
        arrangeSubviews()
        layout()
        setupNavigationBar()
    }

    func setupUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")

        rightBarButtonItem.title = "Shuffle"
        rightBarButtonItem.action = #selector(shuffleTapped)
        rightBarButtonItem.target = self

        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
    }

    func arrangeSubviews() {
        view.addSubview(collectionView)
    }

    func layout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = "Matches: \(viewModel.matchCount)/\(viewModel.gameSettings.matchToWin)"
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.tintColor = UIColor(named: "DefaultTextColor")
    }

    @objc func shuffleTapped() {
        viewModel.shuffleGame()
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        let card = viewModel.getCard(for: indexPath.row)
        cell.configureCell(card: card)
        return cell
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 5, height: collectionView.bounds.width / 5)
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.chooseCard(at: indexPath.row)
    }
}

extension GameViewController: GameViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }

    func didWinGame() {
       showScore()
    }

    private func showScore() {
        let restartAction = UIAlertAction(title: "Restart the game", style: .default) { [unowned self] _ in
            self.viewModel.createGame()
        }

        presentAlertAction(withTitle: "You won the game", message: "You made \(viewModel.flipCount) flips. 🙌", alertActions: [restartAction])
    }

    func didChangeMatches() {
        navigationItem.title = "Matches: \(viewModel.matchCount)/\(viewModel.gameSettings.matchToWin)"
    }
}
