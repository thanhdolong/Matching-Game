//
//  CardCollectionViewCell.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import UIKit
import Kingfisher

class CardCollectionViewCell: UICollectionViewCell, ReusableView {

    // MARK: - UI
    private let imageView = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        arrangeSubviews()
        layout()
    }

    private func arrangeSubviews() {
        addSubview(imageView)
    }

    private func layout() {
        layer.cornerRadius = 10
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func configureCell(card: Card) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: card.imageURL)
        
        if card.isFaceUp || card.isMatched {
            backgroundColor = .red
            imageView.isHidden = false
        } else {
            backgroundColor = .blue
            imageView.isHidden = true
        }
    }
}
