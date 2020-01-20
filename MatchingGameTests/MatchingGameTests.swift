//
//  MatchingGameTests.swift
//  MatchingGameTests
//
//  Created by Thành Đỗ Long on 11/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import XCTest
import Quick
import Nimble
import PromiseKit
import Swinject

@testable import MatchingGame

class MatchingGameTests: QuickSpec {

    override func spec() {
        var container: Container!

        beforeEach {
            container = Container()
            container.register(NetworkManager.self) { _ in NetworkManagerImpl()}
            container.register(CardService.self) { resolver in
                CardServiceImpl(networkManager: resolver.resolve(NetworkManager.self)!)
            }
        }

        describe("Card service") {
            context("when request images from shopify service") {
                it("should correctly parse data") {
                    guard let fileUrl = Bundle(for: type(of: self)).path(forResource: "ProductResponse", ofType: "json") else {
                        return fail("ProductResponse.json not found")
                    }

                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: fileUrl), options: .alwaysMapped)

                        let decoder: JSONDecoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase

                        let response = try decoder.decode(ProductsResponse.self, from: data)
                        expect(response.products).toNot(beNil())
                        expect(response.products.count).to(equal(50))
                        expect(response.products[1].image.src).to(beAKindOf(URL.self))
                    } catch {
                        fail("Cannot parsing JSON file: \(error)")
                    }

                }

                it("should return data") {
                    let fetcher = container.resolve(CardService.self)!
                    var cards = [Card]()

                    waitUntil(timeout: 10) { done in
                        fetcher.getCards(amount: 10)
                            .done { response in
                                cards = response
                                done()
                            }
                            .catch { error in
                                fail("\(error)")
                            }
                    }

                    expect(cards.count).to(equal(10))
                    expect(cards.first!.identifier).to(beAKindOf(Int.self))
                    expect(cards.first!.isFaceUp).to(be(false))
                    expect(cards.first!.isMatched).to(be(false))
                    expect(cards.first!.imageURL).to(beAKindOf(URL.self))

                }
            }
        }
    }
}
