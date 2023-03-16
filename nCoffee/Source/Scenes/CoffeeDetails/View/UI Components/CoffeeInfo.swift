//
//  CoffeeInfo.swift
//  nCoffee
//
//  Created by Yago Marques on 24/02/23.
//

import Foundation
import UIKit

final class CoffeeInfo: UIView {

    private let coffeeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0

        return label
    }()

    private let coffeeSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    private let coffeeRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemYellow
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        return label
    }()

    private let coffeeAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    private let coffeeDescription: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.textAlignment = .justified

        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setupView(viewModel: CoffeeViewModel) {
        self.coffeeTitle.text = viewModel.name
        self.coffeeSubtitle.text = "\(viewModel.type) | \(viewModel.quantity) | \(viewModel.price)"
        self.coffeeRating.text = "\(viewModel.rating) ⭐️"
        self.coffeeAddress.text = "🚕  \(viewModel.place)"
        self.coffeeDescription.text = viewModel.description
    }

}

extension CoffeeInfo: ViewCoding {
    func setupView() {

    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            coffeeTitle.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            coffeeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            coffeeTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),

            coffeeRating.centerYAnchor.constraint(equalTo: coffeeTitle.centerYAnchor),
            coffeeRating.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            coffeeSubtitle.topAnchor.constraint(equalToSystemSpacingBelow: coffeeTitle.bottomAnchor, multiplier: 2),
            coffeeSubtitle.leadingAnchor.constraint(equalTo: coffeeTitle.leadingAnchor),
            coffeeSubtitle.trailingAnchor.constraint(equalTo: coffeeRating.trailingAnchor),

            coffeeAddress.topAnchor.constraint(equalToSystemSpacingBelow: coffeeSubtitle.bottomAnchor, multiplier: 1),
            coffeeAddress.widthAnchor.constraint(equalTo: coffeeSubtitle.widthAnchor),
            coffeeAddress.centerXAnchor.constraint(equalTo: centerXAnchor),

            coffeeDescription.topAnchor.constraint(equalToSystemSpacingBelow: coffeeAddress.bottomAnchor, multiplier: 2),
            coffeeDescription.widthAnchor.constraint(equalTo: coffeeAddress.widthAnchor),
            coffeeDescription.bottomAnchor.constraint(equalTo: bottomAnchor),
            coffeeDescription.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupHierarchy() {
        let views = [
            coffeeTitle,
            coffeeSubtitle,
            coffeeRating,
            coffeeAddress,
            coffeeDescription
        ]

        views.forEach { self.addSubview($0) }
    }
}
