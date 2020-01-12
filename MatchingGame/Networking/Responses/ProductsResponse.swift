//
//  ProductsResponse.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 11/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation

struct ProductsResponse: Decodable {
    let products: [Product]

    struct Product: Decodable {
        let image: Image
    }

    struct Image: Decodable {
        let id: Int
        let width: Int
        let height: Int
        let src: URL
    }
}
