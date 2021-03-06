//
//  ShopifyRoute.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 12/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

public enum ShopifyRoute {
    case getProductImages(limit: Int)
}

extension ShopifyRoute: Route {
    var baseURL: String {
        return "https://shopicruit.myshopify.com/admin"
    }

    var method: HTTPMethod {
        switch self {
        case .getProductImages:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getProductImages:
            return "/products.json"
        }
    }

    var accessToken: String {
        let file = Bundle.main.path(forResource: "Shopify", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        return dictionary["accessToken"] as! String
    }

    var parameters: Parameters? {
        switch self {
        case .getProductImages(let limit):
            return [
                "limit": String(limit),
                "fields": "image",
                "access_token": accessToken
            ]
        }
    }

}
