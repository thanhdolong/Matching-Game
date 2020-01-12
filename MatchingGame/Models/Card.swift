//
//  Card.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import UIKit
import Kingfisher

struct Card: Hashable {
    var identifier: Int
    var isFaceUp: Bool
    var isMatched: Bool
    var imageURL: URL

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    init(identifier: Int, imageURL: URL) {
        self.identifier = identifier
        self.isFaceUp = false
        self.isMatched = false
        self.imageURL = imageURL
    }
}
