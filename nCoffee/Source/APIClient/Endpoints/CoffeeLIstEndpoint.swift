//
//  CoffeeLIstEndpoint.swift
//  nCoffee
//
//  Created by Yago Marques on 13/03/23.
//

import Foundation

final class CoffeeListEndpoint: EndpointProtocol {
    var urlBase: String = "sheetlabs.com"
    var path: String = "/NNT/Coffee"
    var httpMethod: HTTPMethod
    var body: Data
    var headers: [String : String]
    var queries: [URLQueryItem]

    init(
        httpMethod: HTTPMethod = .get,
        body: Data = Data(),
        headers: [String: String] = ["Content-Type": "application/json"],
        queries: [URLQueryItem] = []
    ) {
        self.httpMethod = httpMethod
        self.body = body
        self.headers = headers
        self.queries = queries
    }
}
