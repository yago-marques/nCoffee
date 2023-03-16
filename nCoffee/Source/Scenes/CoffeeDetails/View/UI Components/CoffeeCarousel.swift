//
//  CoffeeCarousel.swift
//  nCoffee
//
//  Created by Yago Marques on 15/02/23.
//

import Foundation
import UIKit

final class CoffeeCarousel: UIView {

    var imageList = [Data]() {
        didSet {
            self.carouselCollection.reloadData()
            self.pageControl.numberOfPages = imageList.count
        }
    }

    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        return layout
    }()

    private lazy var carouselCollection: UICollectionView = {
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionLayout)
        myCollectionView.register(CoffeeCarouselCell.self, forCellWithReuseIdentifier: CoffeeCarouselCell.identifier)
        myCollectionView.backgroundColor = .clear
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.isPagingEnabled = true
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.showsHorizontalScrollIndicator = false

        return myCollectionView
    }()

    private let carouselOverley: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground

        return view
    }()

    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.currentPage = 0
        control.isUserInteractionEnabled = true
        control.pageIndicatorTintColor = .gray
        control.addTarget(self, action: #selector(pageControlSelectionAction), for: .valueChanged)
        control.currentPageIndicatorTintColor = .red

        return control
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

}

@objc private extension CoffeeCarousel {
    func pageControlSelectionAction() {
        navigateToCorrectScreen(at: pageControl.currentPage)
    }
}

private extension CoffeeCarousel {
    func navigateToCorrectScreen(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        carouselCollection.isPagingEnabled = false
        carouselCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        carouselCollection.isPagingEnabled = true
    }
}

extension CoffeeCarousel: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if frame.width != .zero {
            let scrollPos = scrollView.contentOffset.x / frame.width
            pageControl.currentPage = Int(scrollPos)
        }
    }
}

extension CoffeeCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = carouselCollection.dequeueReusableCell(withReuseIdentifier: CoffeeCarouselCell.identifier, for: indexPath) as? CoffeeCarouselCell else {
            return UICollectionViewCell()
        }

        cell.configureCell(imageList[indexPath.row])

        return cell
    }
}

extension CoffeeCarousel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = carouselCollection.frame.width
        return CGSize(width: width, height: width * 0.6)
    }
}

extension CoffeeCarousel: ViewCoding {
    func setupView() { }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            carouselCollection.topAnchor.constraint(equalTo: topAnchor),
            carouselCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselCollection.trailingAnchor.constraint(equalTo: trailingAnchor),

            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: carouselCollection.bottomAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupHierarchy() {
        self.addSubview(carouselCollection)
        self.addSubview(carouselOverley)
        self.addSubview(pageControl)
    }
}
