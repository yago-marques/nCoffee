//
//  ViewController.swift
//  nCoffee
//
//  Created by Yago Marques on 08/02/23.
//

import UIKit

class CoffeeTableViewController: UITableViewController {

    let coffeeService: CoffeeClient
    var filteredCafes = [Coffee]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var allCafes = [Coffee]()


    private lazy var filterSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Todos", "Arabica", "Expresso", "Gourmet"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(filterCoffee), for: .valueChanged)

        return control
    }()

    init(coffeeService: CoffeeClient) {
        self.coffeeService = coffeeService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildLayout()

        coffeeService.getCoffee { result in
            if case .success(let coffeeGroup) = result {
                self.filteredCafes = coffeeGroup
                self.allCafes = coffeeGroup
            }
        }
    }

    @objc
    private func filterCoffee() {
        switch filterSegmentedControl.selectedSegmentIndex {
        case 0:
            filteredCafes = allCafes
        case 1:
            filteredCafes = allCafes.filter { $0.type == "Arabica" }
        case 2:
            filteredCafes = allCafes.filter { $0.type == "Expresso" }
        case 3:
            filteredCafes = allCafes.filter { $0.type == "Gourmet" }
        default:
            filteredCafes = allCafes
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCafes.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.width * 0.35
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeCustomCell.identifier) as? CoffeeCustomCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: filteredCafes[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterSegmentedControl.removeFromSuperview()
        let coffee = filteredCafes[indexPath.row]
        self.navigationController?.pushViewController(CoffeeDetailsFactory.make(with: coffee), animated: true)
    }
}

extension CoffeeTableViewController: ViewCoding {
    func setupView() {
        self.tableView.register(CoffeeCustomCell.self, forCellReuseIdentifier: CoffeeCustomCell.identifier)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterSegmentedControl.centerXAnchor.constraint(equalTo: self.navigationController!.navigationBar.centerXAnchor),
            filterSegmentedControl.centerYAnchor.constraint(equalTo: self.navigationController!.navigationBar.centerYAnchor),
            filterSegmentedControl.widthAnchor.constraint(equalTo: self.navigationController!.navigationBar.widthAnchor, multiplier: 0.9)
        ])
    }

    func setupHierarchy() {
        self.navigationController?.navigationBar.addSubview(filterSegmentedControl)
    }
}
