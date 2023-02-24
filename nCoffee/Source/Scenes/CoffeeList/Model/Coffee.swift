//
//  Coffee.swift
//  nCoffee
//
//  Created by Yago Marques on 08/02/23.
//

import Foundation

struct Coffee {
    let name: String
    let image: String
    let type: String
    let quantity: String
    let price: Double
    let rating: Double
    let carouselImages: [String]
    let description: String
    let address: String
    let mapsUrl: String
}


extension Coffee {
    static func getCoffeeMock() -> [Coffee] {
        let objects = coffeeNames.map { generateCoffee(with: $0) }
        return objects
    }

    static func generateCoffee(with name: String) -> Coffee {
        let coffeeTypes = ["Gourmet", "Arabica", "Expresso", "Americano"]
        let possibleQuantitites = ["50ml", "100ml", "150ml"]
        let possiblePrices = [22.90, 32.90, 25.90, 16.90, 43.90, 20.90]
        let possibleRatings = [4.5, 2.5, 5, 3.4, 4.8]

        return .init(
            name: name,
            image: "Coffee1",
            type: coffeeTypes.randomElement() ?? "Arabica",
            quantity: possibleQuantitites.randomElement() ?? "50ml",
            price: possiblePrices.randomElement() ?? 22.34,
            rating: possibleRatings.randomElement() ?? 1.5,
            carouselImages: ["CoffeeBg1", "CoffeeBg2", "CoffeeBg3"],
            description: "É uma bebida feita a partir de grãos de café de alta qualidade, cultivados em condições ideais em fazendas especializadas em todo o mundo. Esses grãos são colhidos à mão e submetidos a um rigoroso processo de seleção, onde apenas os melhores são escolhidos.",
            address: "Maraponga food square",
            mapsUrl: "https://maps.apple.com/?address=Avenida%20Godofredo%20Maciel,%203081,%20Jardim%20Cearence,%20Fortaleza%20-%20CE,%2060712-023,%20Brazil&auid=8186736832341883308&ll=-3.802862,-38.571426&lsp=9902&q=Maraponga%20Food%20Square"
        )
    }
}

let coffeeNames = ["Jamaica Blue Mountain", "Hawaiian Kona", "Colombian Narino Supremo", "Ethiopian Sidamo", "Kenyan AA", "Tanzanian Peaberry", "Yemen Mocha", "Colombian Excelso", "Ethiopian Yirgacheffe", "Guatemalan Antigua", "Sumatra Mandheling", "Brazilian Santos", "Peruvian Cajamarca", "Bolivian Caranavi", "Mexican Chiapas", "Java Estate", "Costa Rican Tarrazu", "Rwandan Blue Mountain", "Vietnamese Robusta", "Indonesian Java", "Indian Monsooned Malabar", "Ugandan Bugisu", "Haitian Blue Mountain", "Nicaraguan Maragogype"]
