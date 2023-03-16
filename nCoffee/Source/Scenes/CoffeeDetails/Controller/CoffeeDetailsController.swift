//
//  CoffeeOverviewController.swift
//  nCoffee
//
//  Created by Yago Marques on 15/02/23.
//

import Foundation
import UIKit

final class CoffeeDetailsController: UIViewController {

    let detailsView: CoffeeDetailsView
    let coffee: CoffeeViewModel

    init(detailsView: CoffeeDetailsView, coffee: CoffeeViewModel) {
        self.detailsView = detailsView
        self.coffee = coffee
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

private extension CoffeeDetailsController {
    func setupView() {
        self.view = self.detailsView
        detailsView.configureView(coffee)
        navigationController?.navigationBar.topItem?.backButtonTitle = "Voltar"
    }
}
