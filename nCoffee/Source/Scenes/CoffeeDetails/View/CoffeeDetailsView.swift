//
//  CoffeeDetailsView.swift
//  nCoffee
//
//  Created by Yago Marques on 15/02/23.
//

import Foundation
import UIKit

final class CoffeeDetailsView: UIView {

    private var url: String = ""

    private let imageCarousel: CoffeeCarousel = {
        let carousel = CoffeeCarousel(frame: .zero)
        carousel.translatesAutoresizingMaskIntoConstraints = false

        return carousel
    }()

    private let coffeeInfo: CoffeeInfo = {
        let info = CoffeeInfo(frame: .zero)
        info.translatesAutoresizingMaskIntoConstraints = false

        return info
    }()

    private lazy var buttonToLocation: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Conhecer local", for: .normal)
        button.backgroundColor = .systemBrown
        button.layer.cornerCurve = .circular
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(toMaps), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configureView(_ viewModel: CoffeeViewModel) {
        self.imageCarousel.imageList = viewModel.banners
        self.coffeeInfo.setupView(viewModel: viewModel)
        self.url = viewModel.url
    }

}

@objc
extension CoffeeDetailsView {
    func toMaps() {
        animateButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIApplication.shared.open(URL(string: self.url)!)
        }
    }
}

private extension CoffeeDetailsView {
    func animateButton() {
        let hapticSoft = UIImpactFeedbackGenerator(style: .soft)
        let hapticRigid = UIImpactFeedbackGenerator(style: .rigid)

        hapticSoft.impactOccurred(intensity: 1.00)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            hapticRigid.impactOccurred(intensity: 1.00)
        }

        UIView.animate(withDuration: 0.1, animations: { }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.buttonToLocation.layer.opacity = 0.5
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.buttonToLocation.layer.opacity = 1
                })
            })
        })
    }
}

extension CoffeeDetailsView: ViewCoding {
    func setupView() {
        self.backgroundColor = .systemBackground
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCarousel.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageCarousel.widthAnchor.constraint(equalTo: widthAnchor),
            imageCarousel.heightAnchor.constraint(equalTo: imageCarousel.widthAnchor, multiplier: 0.7),
            imageCarousel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),

            coffeeInfo.topAnchor.constraint(equalTo: imageCarousel.bottomAnchor),
            coffeeInfo.widthAnchor.constraint(equalTo: widthAnchor),
            coffeeInfo.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65),

            buttonToLocation.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonToLocation.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonToLocation.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            buttonToLocation.heightAnchor.constraint(equalTo: buttonToLocation.widthAnchor, multiplier: 0.2)
        ])
    }

    func setupHierarchy() {
        self.addSubview(imageCarousel)
        self.addSubview(coffeeInfo)
        self.addSubview(buttonToLocation)
    }
}
