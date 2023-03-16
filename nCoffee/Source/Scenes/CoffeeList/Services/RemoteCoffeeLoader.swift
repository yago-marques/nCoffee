//
//  RemoteCoffeeLoader.swift
//  nCoffee
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation

protocol CoffeeClient: AnyObject {
    func getCoffee(completion: @escaping (Result<[CoffeeRemoteModel], Error>) -> Void)
}

final class RemoteCoffeeLoader: CoffeeClient {

    let apiClient: HTTPClient

    init(apiClient: HTTPClient) {
        self.apiClient = apiClient
    }

    func getCoffee(completion: @escaping (Result<[CoffeeRemoteModel], Error>) -> Void) {
        apiClient.request(endpoint: CoffeeListEndpoint()) { result in
            switch result {
            case .success(let coffeeData):
                guard let remoteCoffee = try? JSONDecoder().decode([CoffeeRemoteModel].self, from: coffeeData) else { return }

                completion(.success(remoteCoffee))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

}
