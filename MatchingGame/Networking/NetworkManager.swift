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
    func fetch(route: Route) -> Promise<Any>
}

class NetworkManagerImpl: NetworkManager {
    func fetch(route: Route) -> Promise<Any> {
        let result = Promise<Any> { seal in

            AF.request(route).validate().responseJSON { (response) in

                    switch response.result {
                    case .success(let success):
                        seal.fulfill(success)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
            }

            return result
    }

    private let urlSession = URLSession.shared

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
