//
//  CardService.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation
import PromiseKit
import Kingfisher

protocol CardService: class {
    func getCards(amount: Int) -> Promise<[Card]>
}

final class CardServiceImpl: CardService {
    private var networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getCards(amount: Int) -> Promise<[Card]> {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return networkManager
            .fetchDecodable(type: ProductsResponse.self,
                            route: ShopifyRoute.getProductImages(limit: amount),
                            decoder: decoder)
            .then { productsResponse -> Promise<[Card]> in
                let cards = productsResponse
                    .products
                    .map { product -> Card in
                        Card(identifier: product.image.productId, imageURL: product.image.src)
                    }

                return Promise.value(cards)
            }
    }
}
