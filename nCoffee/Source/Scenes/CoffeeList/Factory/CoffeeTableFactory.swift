//
//  CoffeeTableFactory.swift
//  nCoffee
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation
import UIKit

enum CoffeeTableFactory {
    static func make() -> UIViewController {
        CoffeeTableViewController(coffeeService: RemoteCoffeeLoader())
    }
}
