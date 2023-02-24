//
//  CoffeeCustomCell.swift
//  nCoffee
//
//  Created by Yago Marques on 08/02/23.
//

import UIKit

class CoffeeCustomCell: UITableViewCell {

    static let identifier = "CoffeeCustomCell"

    private let coffeeImage: UIImageView = {
        let coffeeImageView = UIImageView()
        coffeeImageView.translatesAutoresizingMaskIntoConstraints = false
        coffeeImageView.contentMode = .scaleAspectFit

        return coffeeImageView
    }()

    private let coffeeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0

        return label
    }()

    private let coffeeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    private let coffeePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGreen
        label.numberOfLines = 0

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configureCell(with coffee: Coffee) {
        DispatchQueue.main.async {
            self.coffeeImage.image = UIImage(named: coffee.image)
            self.coffeeTitle.text = coffee.name
            self.coffeeDescription.text = "\(coffee.type) | \(coffee.quantity)"
            self.coffeePrice.text = "\(coffee.price.formatted(.currency(code: "BRL")))"
        }
    }

}

extension CoffeeCustomCell: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            coffeeImage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            coffeeImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            coffeeImage.heightAnchor.constraint(equalTo: coffeeImage.widthAnchor),
            coffeeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            coffeeTitle.topAnchor.constraint(equalTo: coffeeImage.topAnchor, constant: 5),
            coffeeTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: coffeeImage.trailingAnchor, multiplier: 2),
            coffeeTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),

            coffeeDescription.topAnchor.constraint(equalTo: coffeeTitle.bottomAnchor, constant: 5),
            coffeeDescription.leadingAnchor.constraint(equalTo: coffeeTitle.leadingAnchor),

            coffeePrice.bottomAnchor.constraint(equalTo: coffeeImage.bottomAnchor, constant: -5),
            coffeePrice.leadingAnchor.constraint(equalTo: coffeeDescription.leadingAnchor)
        ])
    }

    func setupHierarchy() {
        let views = [
            coffeeImage,
            coffeeTitle,
            coffeeDescription,
            coffeePrice
        ]

        views.forEach { view in
            self.addSubview(view)
        }
    }
}
