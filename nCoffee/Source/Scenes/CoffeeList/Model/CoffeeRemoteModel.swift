//
//  Coffee.swift
//  nCoffee
//
//  Created by Yago Marques on 08/02/23.
//

import Foundation

struct CoffeeRemoteModel: Codable {
    let name: String
    let image: String
    let type: String
    let quantity: Int
    let price: Double
    let rating: Double
    let banners: String
    let description: String
    let place: String
    let url: String
}
