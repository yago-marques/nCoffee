//
//  RemoteCoffeeLoader.swift
//  nCoffee
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation

protocol CoffeeClient: AnyObject {
    func getCoffee(completion: @escaping (Result<[Coffee], Error>) -> Void)
}

final class RemoteCoffeeLoader: CoffeeClient {

    func getCoffee(completion: @escaping (Result<[Coffee], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            completion(.success(Coffee.getCoffeeMock()))
        }
    }

}
