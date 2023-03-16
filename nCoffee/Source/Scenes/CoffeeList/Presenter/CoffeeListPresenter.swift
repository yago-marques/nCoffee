//
//  CoffeeListPresenter.swift
//  nCoffee
//
//  Created by Yago Marques on 13/03/23.
//

import Foundation

final class CoffeeListPresenter {
    let coffeeService: CoffeeClient

    init(coffeeService: CoffeeClient) {
        self.coffeeService = coffeeService
    }

    func getCoffeeViewModel(completion: @escaping ([CoffeeViewModel]) -> Void) {
        coffeeService.getCoffee { result in
            if case let .success(cafes) = result {
                let viewModels = cafes.map { self.makeViewModel($0) }
                var validCafes = [CoffeeViewModel]()
                for coffee in viewModels where coffee != nil {
                    validCafes.append(coffee!)
                }

                completion(validCafes)
            }
        }
    }

    func makeViewModel(_ remoteModel: CoffeeRemoteModel) -> CoffeeViewModel? {
        let bannersData = remoteModel.banners.data(using: .utf8) ?? Data()

        guard let banners = try? JSONSerialization.jsonObject(with: bannersData, options: .fragmentsAllowed) as? [String] else {
            return nil
        }

        return .init(
            name: remoteModel.name,
            image: Data(base64Encoded: remoteModel.image) ?? Data(),
            type: remoteModel.type,
            quantity: "\(remoteModel.quantity) ml",
            price: remoteModel.price.formatted(.currency(code: "BRL")),
            rating: "\(remoteModel.rating)",
            banners: banners.map { Data(base64Encoded: $0) ?? Data() },
            description: remoteModel.description,
            place: remoteModel.place,
            url: remoteModel.url
        )
    }
}
