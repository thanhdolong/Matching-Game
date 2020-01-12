//
//  NetworkManager.swift
//  MatchingGame
//
//  Created by Thành Đỗ Long on 11/01/2020.
//  Copyright © 2020 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol NetworkManager: class {
    func fetchDecodable<T: Decodable>(type: T.Type, route: Route, decoder: JSONDecoder) -> Promise<T>
}

extension NetworkManager {
    func fetchDecodable<T: Decodable>(type: T.Type, route: Route) -> Promise<T> {
        return fetchDecodable(type: type, route: route, decoder: JSONDecoder())
    }
}

class NetworkManagerImpl: NetworkManager {
    func fetchDecodable<T: Decodable>(type: T.Type, route: Route, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        let result = Promise<T> { seal in

            AF.request(route).validate().responseDecodable(of: T.self,
                                                           decoder: decoder,
                                                           completionHandler: { (response) in

                switch response.result {
                case .success(let success):
                    seal.fulfill(success)
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }

        return result
    }
}
