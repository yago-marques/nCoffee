//
//  APICallError.swift
//  nCoffee
//
//  Created by Yago Marques on 09/03/23.
//

import Foundation

enum APICallError: Error {
    case invalidUrl
    case network(Error)
    case invalidAuth
    case invalidResponse
    case httpError(code: Int)
}
