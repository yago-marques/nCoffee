//
//  CoffeeDetailsFactory.swift
//  nCoffee
//
//  Created by Yago Marques on 15/02/23.
//

import Foundation
import UIKit

enum CoffeeDetailsFactory {
    static func make(with coffee: Coffee) -> UIViewController {
        let view = CoffeeDetailsView(frame: UIScreen.main.bounds)
        
        return CoffeeDetailsController(detailsView: view, coffee: coffee)
    }
}
