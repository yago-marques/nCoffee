//
//  CoffeeCarouselCell.swift
//  nCoffee
//
//  Created by Yago Marques on 15/02/23.
//

import Foundation
import UIKit

final class CoffeeCarouselCell: UICollectionViewCell {

    static let identifier = "CoffeeCarouselCell"

    private let coffeeBanner: UIImageView = {
        let banner = UIImageView()
        banner.contentMode = .scaleAspectFill
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.layer.masksToBounds = true
        
        return banner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configureCell(_ imageData: Data) {
        coffeeBanner.image = UIImage(data: imageData)
    }

}

extension CoffeeCarouselCell: ViewCoding {
    func setupView() {

    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            coffeeBanner.topAnchor.constraint(equalTo: self.topAnchor),
            coffeeBanner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coffeeBanner.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            coffeeBanner.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupHierarchy() {
        self.addSubview(coffeeBanner)
    }
}
